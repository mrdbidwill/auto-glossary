require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "demo page loads successfully" do
    get demo_url
    assert_response :success
  end

  test "demo page contains glossary terms" do
    terms = { "basidiospore" => "A spore" }
    WikipediaGlossaryService.stubs(:fetch_glossary_terms).returns(terms)

    get demo_url
    assert_select ".glossary-term"
  end
end
