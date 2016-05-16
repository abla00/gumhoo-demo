require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Gumhoo"
    assert_equal full_title("Help"), "Help | Gumhoo"
  end
end
