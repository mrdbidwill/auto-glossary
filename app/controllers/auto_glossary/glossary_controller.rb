# frozen_string_literal: true

module AutoGlossary
  class GlossaryController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:definition]

    # GET /glossary/definition?term=basidiospore
    def definition
      term = params[:term]

      if term.blank?
        render json: { error: "Term parameter is required" }, status: :bad_request
        return
      end

      definition = AutoGlossary::WikipediaGlossaryService.get_definition(term)

      if definition
        render json: { term: term, definition: definition }
      else
        render json: { error: "Definition not found", term: term }, status: :not_found
      end
    rescue StandardError => e
      Rails.logger.error "Error fetching glossary definition: #{e.message}"
      render json: { error: "Internal server error" }, status: :internal_server_error
    end

    # GET /glossary - Optional: browse all terms
    def index
      @terms = AutoGlossary::WikipediaGlossaryService.fetch_glossary_terms
      @terms = @terms.sort_by { |k, _v| k.downcase }
    end
  end
end
