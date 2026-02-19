# Auto-Glossary

Automatically highlight and define technical terms from Wikipedia glossaries in your Rails applications.

## What It Does

Auto-Glossary identifies technical terms in your content and provides instant definitions from Wikipedia. Perfect for educational websites, scientific documentation, and technical blogs.

**Example:**

```
The basidiospores are produced by the basidium on the hymenium surface of the pileus.
```

With Auto-Glossary, each technical term becomes interactive with:
- **Hover tooltips** - Quick definition preview
- **Click modals** - Full definition with Wikipedia attribution
- **Smart matching** - Handles plurals and variations automatically

## Demo

Visit [auto-glossary.com](https://auto-glossary.com/demo) to see it in action!

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'auto_glossary'
```

Then execute:

```bash
bundle install
```

Or install it yourself:

```bash
gem install auto_glossary
```

## Quick Start

### 1. Run the installer

```bash
rails generate auto_glossary:install
```

This will:
- Mount the engine routes
- Copy the Stimulus JavaScript controller
- Show you the next steps

### 2. Add stylesheet to your layout

In `app/views/layouts/application.html.erb`, add:

```erb
<%= stylesheet_link_tag 'glossary', 'data-turbo-track': 'reload' %>
```

### 3. Add Stimulus controller to body tag

```erb
<body data-controller="glossary">
```

### 4. Use in your views

```erb
<%= mark_glossary_terms(@article.body) %>
```

### 5. Restart your Rails server

```bash
rails server
```

Done! Technical terms will now be automatically highlighted with hover tooltips and click-through definitions.

## Usage Examples

### Basic Usage

```erb
<%= mark_glossary_terms(@text) %>
```

### Mark Only First Occurrence

```erb
<%= mark_glossary_terms(@text, first_only: true) %>
```

### Mark All Occurrences

```erb
<%= mark_glossary_terms(@text, first_only: false) %>
```

### Browse All Terms

Visit `/glossary` in your app to see all available glossary terms and definitions.

## Features

- ⚡ **Fast** - Aggressive caching (24 hours), minimal performance impact
- 🎯 **Smart** - Handles plurals, variations, and edge cases automatically
- 📱 **Responsive** - Beautiful tooltips and modals on all devices
- ♿ **Accessible** - Full keyboard navigation and screen reader support
- 🔌 **No Database Required** - Uses Rails.cache and Wikipedia API
- ⚖️ **Open Source** - MIT licensed

## How It Works

1. Fetches glossary terms from Wikipedia's "Glossary of Mycology"
2. Caches terms for 24 hours
3. Marks terms in your text with special HTML
4. JavaScript handles tooltips and modals
5. Definitions loaded on-demand from Wikipedia

## Configuration

The gem uses the [Glossary of Mycology](https://en.wikipedia.org/wiki/Glossary_of_mycology) by default. To use a different Wikipedia glossary, override the `GLOSSARY_PAGE` constant in `WikipediaGlossaryService`.

## Requirements

- Rails 7.0 or higher
- Ruby 3.2 or higher
- Stimulus JS (included in Rails 7+)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mrdbidwill/auto-glossary

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

- Built by [Will Johnston](https://github.com/mrdbidwill)
- Powered by [Wikipedia's Glossary of Mycology](https://en.wikipedia.org/wiki/Glossary_of_mycology) (CC BY-SA 4.0)
- Demo site: [auto-glossary.com](https://auto-glossary.com)
