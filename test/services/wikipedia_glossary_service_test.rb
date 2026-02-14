require "test_helper"

class WikipediaGlossaryServiceTest < ActiveSupport::TestCase
  test "get_definition handles exact match" do
    terms = { "basidiospore" => "Test definition" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    result = WikipediaGlossaryService.get_definition("basidiospore")
    assert_equal "Test definition", result
  end

  test "get_definition handles case insensitive match" do
    terms = { "basidiospore" => "Test definition" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    result = WikipediaGlossaryService.get_definition("Basidiospore")
    assert_equal "Test definition", result
  end

  test "get_definition handles plural by removing s" do
    terms = { "basidiospore" => "Test definition" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    result = WikipediaGlossaryService.get_definition("basidiospores")
    assert_equal "Test definition", result
  end

  test "get_definition returns nil for unknown term" do
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns({})

    result = WikipediaGlossaryService.get_definition("unknown")
    assert_nil result
  end

  test "term_exists? returns true for known term" do
    terms = { "basidiospore" => "Definition" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    assert WikipediaGlossaryService.term_exists?("basidiospore")
  end

  test "term_exists? returns false for unknown term" do
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns({})

    assert_not WikipediaGlossaryService.term_exists?("unknown")
  end
end
