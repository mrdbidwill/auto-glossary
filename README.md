# Auto-Glossary

Making technical content accessible by automatically highlighting specialized terms with instant Wikipedia definitions.

## 🚀 Status

**Core functionality:** ✅ Working and usable
**Gem extraction:** Planned for future

This Rails application demonstrates fully functional auto-glossary capabilities. The core features work and can be integrated into any Rails project by copying the relevant files. Future plans include extracting this into a standalone Ruby gem.

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

- Ruby on Rails 8
- Stimulus JS (Hotwired)
- Tailwind CSS
- Wikipedia API
- Rails caching (no database needed for glossary)

## 🚀 Quick Start

### Local Development

```bash
# Clone the repository
git clone https://github.com/mrdbidwill/auto-glossary.git
cd auto-glossary

# Install dependencies
bundle install

# Start the server
rails server -p 3001

# Visit the demo
open http://localhost:3001/demo
```

### Using in Your Rails Project

Copy these files to your Rails app:

1. **Backend:**
   - `app/services/wikipedia_glossary_service.rb`
   - `app/helpers/glossary_helper.rb`
   - `app/controllers/glossary_controller.rb`

2. **Frontend:**
   - `app/javascript/controllers/glossary_controller.js`
   - `app/assets/stylesheets/glossary.css`

3. **Add routes** to `config/routes.rb`:
   ```ruby
   get 'glossary/definition', to: 'glossary#definition', defaults: { format: :json }
   get 'glossary', to: 'glossary#index'  # Optional: browse all terms
   ```

4. **Include in layout** (`app/views/layouts/application.html.erb`):
   ```erb
   <body data-controller="glossary">
   ```

5. **Use in views:**
   ```erb
   <%= mark_glossary_terms(@article.body) %>
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

```
app/
├── controllers/
│   ├── glossary_controller.rb    # API endpoint for definitions
│   └── pages_controller.rb        # Demo page
├── helpers/
│   └── glossary_helper.rb         # Text processing & term marking
├── javascript/controllers/
│   └── glossary_controller.js     # Tooltips & modals (Stimulus)
├── services/
│   └── wikipedia_glossary_service.rb  # Wikipedia API integration
└── views/
    └── pages/
        └── demo.html.erb           # Live demo page

public/
└── index.html                      # Landing page (static)
```

## 🌐 Live Sites

- Landing page: [auto-glossary.com](https://auto-glossary.com) (coming soon)
- Demo: Run locally at `http://localhost:3001/demo`

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs or request features via [GitHub Issues](https://github.com/mrdbidwill/auto-glossary/issues)
- Submit pull requests
- Adapt this code for your own glossary sources (botany, medicine, etc.)
- Help extract this into a standalone gem

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

**Full Transparency:** This project, including code, documentation, tests, and content, was created with significant AI assistance using Claude Code (Anthropic's AI-powered development tool).

**Data Source Reliability:** While Wikipedia's reliability varies by topic and is sometimes criticized as not being "scholarly," scientific glossaries—particularly in specialized fields like mycology—tend to be well-maintained. These pages are typically monitored by knowledgeable volunteers with domain expertise. Unlike politically charged topics, technical scientific glossaries generally avoid the controversies that affect other Wikipedia content.

The mycology glossary used by this project benefits from:
- Active community of mycology enthusiasts and experts
- Subject matter that is factual and less prone to editorial disputes
- Regular review and updates by specialists
- Clear attribution to scientific sources

Users should still verify critical information, but for educational and reference purposes, this glossary provides a solid foundation.

## 🔮 Future Plans

- Extract into standalone Ruby gem
- Support for multiple glossary sources
- Configurable Wikipedia pages (botany, medicine, etc.)
- Admin interface for custom term management
- Multi-language support

---

Built with ❤️ by [mrdbidwill](https://github.com/mrdbidwill)
