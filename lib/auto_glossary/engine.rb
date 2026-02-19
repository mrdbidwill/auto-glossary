# frozen_string_literal: true

require "rails"

module AutoGlossary
  class Engine < ::Rails::Engine
    isolate_namespace AutoGlossary

    # Make helpers available to the host app
    initializer "auto_glossary.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper AutoGlossary::GlossaryHelper
      end
      ActiveSupport.on_load(:action_view) do
        include AutoGlossary::GlossaryHelper
      end
    end

    # Add assets paths
    initializer "auto_glossary.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app/assets/stylesheets")
        app.config.assets.precompile += %w[glossary.css]
      end
    end

    # Add JavaScript paths for Stimulus
    initializer "auto_glossary.stimulus" do |app|
      # The JavaScript controller will need to be manually imported by the host app
      # or included via importmap/npm
    end
  end
end
