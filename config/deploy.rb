# config valid for current version and patch releases of Capistrano
lock "~> 3.20.0"

set :application, "auto_glossary"
set :repo_url, "git@github.com:mrdbidwill/auto-glossary.git"

set :branch, ENV.fetch("BRANCH", "main")

# Default deploy_to directory
set :deploy_to, "/opt/auto-glossary"

set :rbenv_type, :user
set :rbenv_ruby, "3.4.3"

# Puma configuration
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

# Linked files and directories
append :linked_files, "config/master.key", "config/credentials.yml.enc", ".env"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "storage"

# Keep last 5 releases
set :keep_releases, 5

# Restart Puma after deploy
namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke "puma:restart"
    end
  end

  after :publishing, :restart
end
