require "test_helper"

class GlossaryHelperTest < ActionView::TestCase
  test "mark_glossary_terms highlights known terms" do
    # Stub the service to return test data
    terms = { "basidiospore" => "A spore produced by a basidium" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    text = "The basidiospore is important."
    result = mark_glossary_terms(text)

    assert_includes result, 'class="glossary-term"'
    assert_includes result, 'data-term="basidiospore"'
  end

  test "mark_glossary_terms handles plurals" do
    terms = { "basidiospore" => "A spore produced by a basidium" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    text = "The basidiospores are numerous."
    result = mark_glossary_terms(text)

    assert_includes result, 'class="glossary-term"'
    assert_includes result, 'basidiospores'
  end

  test "mark_glossary_terms returns original text when no terms match" do
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns({})

    text = "This has no glossary terms."
    result = mark_glossary_terms(text)

    assert_equal text, result
  end

  test "mark_glossary_terms handles blank text" do
    result = mark_glossary_terms(nil)
    assert_nil result

    result = mark_glossary_terms("")
    assert_equal "", result
  end

  test "mark_glossary_terms marks only first occurrence when first_only is true" do
    terms = { "hypha" => "A filament" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    text = "The hypha grows. Another hypha appears."
    result = mark_glossary_terms(text, first_only: true)

    # Should only have one glossary-term span
    assert_equal 1, result.scan('class="glossary-term"').count
  end

  test "mark_glossary_terms marks all occurrences when first_only is false" do
    terms = { "hypha" => "A filament" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    text = "The hypha grows. Another hypha appears."
    result = mark_glossary_terms(text, first_only: false)

    # Should have two glossary-term spans
    assert_equal 2, result.scan('class="glossary-term"').count
  end
end
