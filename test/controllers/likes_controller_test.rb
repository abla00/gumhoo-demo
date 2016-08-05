require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  
  test "create should require logged-in user" do
    assert_no_difference 'Like.count' do
      post :create
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Like.count' do
      delete :destroy, id: likes(:one)
    end
    assert_redirected_to login_url
  end
end
