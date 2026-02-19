# frozen_string_literal: true

AutoGlossary::Engine.routes.draw do
  get "definition", to: "glossary#definition", defaults: { format: :json }
  get "", to: "glossary#index", as: :glossary
end
