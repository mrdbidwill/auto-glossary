require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "demo page loads successfully" do
    get demo_url
    assert_response :success
  end

  test "demo page contains expected content" do
    get demo_url
    assert_response :success
    assert_select "h1", text: /Auto-Glossary Demo/i
    assert_select ".prose", minimum: 1
  end

  test "gem docs page loads successfully" do
    get docs_url
    assert_response :success
  end
end
