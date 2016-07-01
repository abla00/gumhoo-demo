require 'test_helper'

class StaticPagesHelperTest < ActionView::TestCase
  test "container class helper" do
    assert_equal container_class(""),      "container"
    assert_equal container_class("fluid"), "container-fluid"
  end
end
