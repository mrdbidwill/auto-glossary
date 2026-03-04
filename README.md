# Auto-Glossary

Making technical content accessible by automatically highlighting specialized terms with instant Wikipedia definitions.

## 🚀 Status

**Standalone gem:** ✅ Ready to use as a Rails engine
**Demo app/docs:** ✅ Included in this repository

Auto-Glossary is now a standalone Ruby gem you can add to any Rails app. This repository includes a small Rails application used to demo the gem, host documentation pages, and test changes.

**Contributions welcome!** This is open source software - use it, improve it, adapt it for your needs.

## 📋 What It Does

Auto-Glossary automatically identifies and highlights technical terms in your content, providing instant definitions from Wikipedia. Perfect for educational websites, scientific documentation, and technical blogs.

### Example

```
The basidiospores are produced by the basidium on the hymenium surface of the pileus.
```

With Auto-Glossary, each technical term becomes interactive with hover definitions and click-through details.

## ✨ Features

- **⚡ Instant Setup** - Add one helper to your templates: `<%= mark_glossary_terms(@content) %>`
- **🎯 Smart Matching** - Handles plurals, variations, and edge cases automatically
- **📱 Responsive** - Beautiful tooltips and modals on all devices
- **♿ Accessible** - Full keyboard navigation and screen reader support
- **⚖️ Open Source** - MIT licensed, use freely
- **🚀 Fast** - Aggressive caching (24 hours), zero slowdown for readers
- **🔌 No Database Required** - Uses Rails.cache and Wikipedia API

## 🎯 Perfect For

- Educational websites (mycology, botany, medicine)
- Scientific documentation and research portals
- Technical blogs and knowledge bases
- Online textbooks and learning platforms
- Museum and natural history websites
- Field guide applications

## 🛠️ Tech Stack

- Ruby gem (Rails engine)
- Rails 8 demo app
- Stimulus JS (Hotwired)
- Tailwind CSS
- Wikipedia API
- Rails caching (no database needed for glossary)

## 🚀 Quick Start

### Install in Your Rails App

Add the gem:

```ruby
# Gemfile
gem "auto_glossary", ">= 0.1.1"
```

Install and run the installer:

```bash
bundle install
rails generate auto_glossary:install
```

Mount the engine (required for `/glossary` and the definition endpoint):

```ruby
# config/routes.rb
mount AutoGlossary::Engine => "/glossary"
```

Ensure the Stimulus controller is active (often on `<body>`):

```erb
<body data-controller="glossary">
```

Use it in views:

```erb
<%= mark_glossary_terms(@article.body) %>
```

### Local Development (Demo App)

```bash
git clone https://github.com/mrdbidwill/auto-glossary.git
cd auto-glossary

bundle install

rails server -p 3001

open http://localhost:3001/demo
```

## ⚙️ Configuration

The installer creates `config/initializers/auto_glossary.rb`. Customize it as needed:

```ruby
AutoGlossary.configure do |config|
  # Wikipedia glossary URL (default: Glossary of mycology)
  config.glossary_url = "https://en.wikipedia.org/wiki/Glossary_of_mycology"

  # Cache expiration time in seconds (default: 24 hours)
  config.cache_expiration = 86_400

  # Enable/disable caching (default: true)
  config.enable_caching = true
end
```

## 📖 Usage

### Basic Usage
```erb
<%= mark_glossary_terms("The mycelium forms hyphae in the substrate.") %>
```

### With Options
```erb
<!-- Mark only first occurrence of each term -->
<%= mark_glossary_terms(@content, first_only: true) %>

<!-- Mark all occurrences -->
<%= mark_glossary_terms(@content, first_only: false) %>
```

### Browse All Terms
Visit `/glossary` to see all available glossary terms and definitions.

## 🧪 Testing

Run the test suite:
```bash
rails test
```

## 🗂️ Project Structure

This repository includes a Rails demo app used to showcase the gem.

```
app/
├── controllers/
│   └── pages_controller.rb        # Home, demo, docs pages
├── javascript/controllers/
│   └── glossary_controller.js     # Tooltips & modals (Stimulus)
└── views/
    ├── pages/
    │   ├── home.html.erb           # Landing page
    │   ├── demo.html.erb           # Live demo page
    │   └── gem_docs.html.erb       # Gem documentation page
    └── glossary/
        └── index.html.erb          # Glossary browsing page used in the demo

config/
└── routes.rb                       # Mounts the engine at /glossary

public/
└── index.html                      # Landing page (static)
```

## 🌐 Live Sites

- Landing page: [auto-glossary.com](https://auto-glossary.com) 
- Demo: Run locally at `http://localhost:3001/demo`
- RubyGems: [auto_glossary](https://rubygems.org/gems/auto_glossary)

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs or request features via [GitHub Issues](https://github.com/mrdbidwill/auto-glossary/issues)
- Submit pull requests
- Adapt this code for your own glossary sources (botany, medicine, etc.)
- Help improve the gem (features, docs, tests)

## 📧 Contact

Questions? Email [will@mrdbid.com](mailto:will@mrdbid.com?subject=Auto-Glossary)

## 🔗 Related Projects

[MRDBID.com](https://mrdbid.com) - A personal mushroom storage notebook and much more...

## 📄 License

MIT License - Use freely in your projects, commercial or personal.

## 🙏 Acknowledgments

- Powered by Wikipedia's [Glossary of Mycology](https://en.wikipedia.org/wiki/Glossary_of_mycology) (CC BY-SA 4.0)
- Built with Rails 8 and Hotwire Stimulus
- Inspired by the need for accessible scientific content

## 🤖 AI-Generated Code & Content

**Full Transparency:** This project, including code, documentation, tests, and content, was created with significant AI assistance using Claude Code (Anthropic's AI-powered development tool) within JetBrains RubyMine IDE via the JetBrains AI Assistant integration.

**Development Environment:** The primary development tools used were:
- JetBrains RubyMine IDE with JetBrains AI Assistant
- Claude Code by Anthropic (accessed through JetBrains AI Assistant)
- Standard Rails tooling and testing frameworks

This combination proved effective for this project, though developers can use whatever tools work best for their workflow.

**Data Source Reliability:** While Wikipedia's reliability varies by topic and is sometimes criticized as not being "scholarly," scientific glossaries—particularly in specialized fields like mycology—tend to be well-maintained. These pages are typically monitored by knowledgeable volunteers with domain expertise. Unlike politically charged topics, technical scientific glossaries generally avoid the controversies that affect other Wikipedia content.

The mycology glossary used by this project benefits from:
- Active community of mycology enthusiasts and experts
- Subject matter that is factual and less prone to editorial disputes
- Regular review and updates by specialists
- Clear attribution to scientific sources

Users should still verify critical information, but for educational and reference purposes, this glossary provides a solid foundation.

## 🔮 Future Plans

- Support for multiple glossary sources
- Configurable Wikipedia pages (botany, medicine, etc.)
- Admin interface for custom term management
- Multi-language support

---

Built with ❤️ by [mrdbidwill](https://github.com/mrdbidwill)
