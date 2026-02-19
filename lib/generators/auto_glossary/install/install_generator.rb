# frozen_string_literal: true

require "rails/generators"

module AutoGlossary
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Installs Auto-Glossary into your Rails application"

      def add_routes
        route <<~RUBY
          # Auto-Glossary routes
          mount AutoGlossary::Engine => "/glossary"
        RUBY
      end

      def copy_javascript
        template "glossary_controller.js", "app/javascript/controllers/glossary_controller.js"
      end

      def show_usage
        say "\n"
        say "================================================================", :green
        say "Auto-Glossary has been installed!", :green
        say "================================================================", :green
        say "\n"
        say "Next steps:", :yellow
        say "\n"
        say "1. Add the stylesheet to your layout (app/views/layouts/application.html.erb):", :yellow
        say "   <%= stylesheet_link_tag 'glossary', 'data-turbo-track': 'reload' %>", :cyan
        say "\n"
        say "2. Add the Stimulus controller to your <body> tag:", :yellow
        say "   <body data-controller=\"glossary\">", :cyan
        say "\n"
        say "3. Use in your views:", :yellow
        say "   <%= mark_glossary_terms(@article.body) %>", :cyan
        say "\n"
        say "4. Restart your Rails server", :yellow
        say "\n"
        say "For more info: https://github.com/mrdbidwill/auto-glossary", :blue
        say "\n"
      end
    end
  end
end
