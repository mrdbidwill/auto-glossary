# frozen_string_literal: true

require_relative "auto_glossary/version"
require_relative "auto_glossary/engine" if defined?(Rails)

module AutoGlossary
  class Error < StandardError; end
end
