require "test_helper"

class GlossaryControllerTest < ActionDispatch::IntegrationTest
  test "definition endpoint returns JSON with valid term" do
    term = "basidiospore"
    definition = "A spore produced by a basidium"

    WikipediaGlossaryService.stubs(:get_definition).with(term).returns(definition)

    get glossary_definition_url, params: { term: term }, as: :json

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal term, json["term"]
    assert_equal definition, json["definition"]
  end

  test "definition endpoint returns 400 when term is missing" do
    get glossary_definition_url, as: :json

    assert_response :bad_request
    json = JSON.parse(response.body)
    assert_equal "Term parameter is required", json["error"]
  end

  test "definition endpoint returns 404 when term not found" do
    WikipediaGlossaryService.stubs(:get_definition).with("nonexistent").returns(nil)

    get glossary_definition_url, params: { term: "nonexistent" }, as: :json

    assert_response :not_found
    json = JSON.parse(response.body)
    assert_equal "Definition not found", json["error"]
  end

  test "index page loads successfully" do
    terms = { "basidiospore" => "Definition 1", "hypha" => "Definition 2" }

    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    get glossary_url

    assert_response :success
    assert_select "body"
  end
end
