# Auto-Glossary Deployment Guide

## Overview
This guide walks through deploying auto-glossary.com to your VPS alongside mrdbid.com using Capistrano.

**Server:** 85.31.233.192
**User:** deploy
**Deploy Path:** /opt/auto-glossary
**Domain:** auto-glossary.com

---

## Prerequisites

✅ Already completed (from mrdbid setup):
- VPS with Ubuntu/Debian
- `deploy` user with sudo privileges
- SSH key authentication configured
- Nginx installed
- MySQL installed
- Ruby 3.4.3 via rbenv
- Git installed

---

## Step 1: DNS Configuration

Point auto-glossary.com to your VPS:

1. Log into your domain registrar
2. Add these DNS records:
   - **A record**: `@` → `85.31.233.192`
   - **CNAME record**: `www` → `auto-glossary.com`
3. Wait 5-60 minutes for propagation

Verify: `dig auto-glossary.com` should show `85.31.233.192`

---

## Step 2: Server Preparation

SSH into your VPS:
```bash
ssh deploy@85.31.233.192
```

### Create deployment directory:
```bash
sudo mkdir -p /opt/auto-glossary
sudo chown deploy:deploy /opt/auto-glossary
```

### Create MySQL database and user:
```bash
mysql -u root -p

CREATE DATABASE auto_glossary_production CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'auto_glossary'@'localhost' IDENTIFIED BY 'your_secure_password_here';
GRANT ALL PRIVILEGES ON auto_glossary_production.* TO 'auto_glossary'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

**Save the password!** You'll need it for `.env` file.

### Create shared directories:
```bash
cd /opt/auto-glossary
mkdir -p shared/config shared/log shared/tmp/pids shared/tmp/sockets shared/storage
```

---

## Step 3: Environment Configuration

### On the server, create `.env` file:
```bash
nano /opt/auto-glossary/shared/.env
```

Add this content (replace with actual values):
```bash
RAILS_MASTER_KEY=<copy from local config/master.key>
APP_HOST=auto-glossary.com
AUTO_GLOSSARY_DATABASE_PASSWORD=<your mysql password from Step 2>
```

Save and exit (Ctrl+O, Enter, Ctrl+X)

### Copy Rails credentials:
```bash
# On your local machine:
scp config/master.key deploy@85.31.233.192:/opt/auto-glossary/shared/config/
scp config/credentials.yml.enc deploy@85.31.233.192:/opt/auto-glossary/shared/config/
```

---

## Step 4: Nginx Configuration

### On the server, create Nginx config:
```bash
sudo nano /etc/nginx/sites-available/auto-glossary
```

Add this configuration:
```nginx
upstream auto_glossary_puma {
  server unix:///opt/auto-glossary/shared/tmp/sockets/puma.sock;
}

server {
  listen 80;
  server_name auto-glossary.com www.auto-glossary.com;

  root /opt/auto-glossary/current/public;

  access_log /opt/auto-glossary/shared/log/nginx_access.log;
  error_log /opt/auto-glossary/shared/log/nginx_error.log;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @puma;

  location @puma {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://auto_glossary_puma;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 100M;
  keepalive_timeout 10;
}
```

### Enable the site:
```bash
sudo ln -s /etc/nginx/sites-available/auto-glossary /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

---

## Step 5: Systemd Service for Puma

### Create Puma systemd service:
```bash
sudo nano /etc/systemd/system/puma_auto_glossary.service
```

Add this content:
```ini
[Unit]
Description=Puma HTTP Server for auto-glossary
After=network.target

[Service]
Type=notify
User=deploy
WorkingDirectory=/opt/auto-glossary/current
Environment=RAILS_ENV=production
Environment=RBENV_ROOT=/home/deploy/.rbenv
Environment=RBENV_VERSION=3.4.3
ExecStart=/home/deploy/.rbenv/shims/bundle exec puma -C /opt/auto-glossary/current/config/puma.rb
ExecReload=/bin/kill -TSTP $MAINPID
StandardOutput=append:/opt/auto-glossary/shared/log/puma_access.log
StandardError=append:/opt/auto-glossary/shared/log/puma_error.log
Restart=always
RestartSec=1
SyslogIdentifier=puma_auto_glossary

[Install]
WantedBy=multi-user.target
```

### Enable and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl enable puma_auto_glossary
# Don't start yet - will start after first deploy
```

---

## Step 6: Deploy from Local Machine

### Verify SSH agent has your key:
```bash
ssh-add -l
# Should show your SSH key
# If not: ssh-add ~/.ssh/id_rsa
```

### Test connection to server:
```bash
bundle exec cap production deploy:check
```

This will verify all paths and permissions. Fix any errors before proceeding.

### First deployment:
```bash
bundle exec cap production deploy
```

This will:
1. Clone the repository
2. Install gems
3. Compile assets
4. Run migrations
5. Restart Puma

### Start Puma service:
```bash
ssh deploy@85.31.233.192 "sudo systemctl start puma_auto_glossary"
```

---

## Step 7: SSL Certificate (Let's Encrypt)

### Install Certbot:
```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx
```

### Get SSL certificate:
```bash
sudo certbot --nginx -d auto-glossary.com -d www.auto-glossary.com
```

Follow prompts:
- Enter email address
- Agree to terms
- Choose to redirect HTTP to HTTPS (option 2)

Certbot will automatically update your Nginx config and restart Nginx.

---

## Step 8: Verify Deployment

### Check the site:
1. Visit: https://auto-glossary.com
2. Visit: https://auto-glossary.com/demo
3. Test tooltips and modals

### Check logs if issues:
```bash
# Application logs
tail -f /opt/auto-glossary/current/log/production.log

# Puma logs
tail -f /opt/auto-glossary/shared/log/puma_access.log
tail -f /opt/auto-glossary/shared/log/puma_error.log

# Nginx logs
sudo tail -f /var/log/nginx/error.log
```

### Check service status:
```bash
sudo systemctl status puma_auto_glossary
sudo systemctl status nginx
```

---

## Future Deployments

After initial setup, deploying updates is simple:

```bash
# From your local machine:
git push origin main
bundle exec cap production deploy
```

Capistrano will automatically:
- Pull latest code
- Install new gems
- Compile assets
- Run migrations
- Restart Puma

---

## Useful Commands

### View application logs:
```bash
bundle exec cap production logs
```

### Rails console on server:
```bash
bundle exec cap production console
```

### Restart Puma:
```bash
bundle exec cap production puma:restart
# or on server: sudo systemctl restart puma_auto_glossary
```

### Rollback deployment:
```bash
bundle exec cap production deploy:rollback
```

---

## Troubleshooting

### Deployment fails with permission errors:
```bash
ssh deploy@85.31.233.192
sudo chown -R deploy:deploy /opt/auto-glossary
```

### Puma won't start:
```bash
ssh deploy@85.31.233.192
cd /opt/auto-glossary/current
RAILS_ENV=production bundle exec puma -C config/puma.rb
# Check error messages
```

### Database connection errors:
- Verify MySQL user and password in `/opt/auto-glossary/shared/.env`
- Test: `mysql -u auto_glossary -p auto_glossary_production`

### 502 Bad Gateway:
- Check Puma is running: `sudo systemctl status puma_auto_glossary`
- Check socket exists: `ls -la /opt/auto-glossary/shared/tmp/sockets/puma.sock`
- Check Nginx config: `sudo nginx -t`

---

## Resources

- **Capistrano docs**: https://capistranorb.com/
- **Puma docs**: https://puma.io/
- **Nginx docs**: https://nginx.org/en/docs/

---

**Ready to deploy!** Follow the steps above carefully, and you'll have auto-glossary.com running alongside mrdbid.com on the same VPS.
