# frozen_string_literal: true

require_relative "lib/auto_glossary/version"

Gem::Specification.new do |spec|
  spec.name = "auto_glossary"
  spec.version = AutoGlossary::VERSION
  spec.authors = ["Will Johnston"]
  spec.email = ["mrdbidwill@gmail.com"]

  spec.summary = "Automatically highlight and define technical terms from Wikipedia glossaries in Rails applications"
  spec.description = "Auto-Glossary provides hover tooltips and click-through definitions for technical terms by fetching content from Wikipedia glossaries. Perfect for educational, scientific, and technical documentation sites."
  spec.homepage = "https://auto-glossary.com"
  spec.required_ruby_version = ">= 3.2.0"
  spec.license = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mrdbidwill/auto-glossary"
  spec.metadata["changelog_uri"] = "https://github.com/mrdbidwill/auto-glossary/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "rails", ">= 7.0"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
