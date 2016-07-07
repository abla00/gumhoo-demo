require 'test_helper'

class StaticPagesHelperTest < ActionView::TestCase
  test "container class helper" do
    assert_equal container_class(""),      "container row-space-top-2"
    assert_equal container_class("fluid"), "container-fluid"
  end
end
