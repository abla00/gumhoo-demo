require 'test_helper'

class LikingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:abla)
    @post = posts(:cat_video)
    log_in_as(@user)
  end

  test "liking page" do
    orange  = posts(:orange)
    get post_path(orange)
    assert @user.liking?(orange)
    assert_match 'Unlike', response.body
  end

  test "unliking page" do
    cat_video = posts(:cat_video)
    get post_path(cat_video)
    assert_not @user.liking?(cat_video)
    assert_match 'Like', response.body
  end
  
  test "should like a user the standard way" do
    assert_difference '@user.liking.count', 1 do
      post likes_path, post_id: @post.id
    end
  end

  test "should like a user with Ajax" do
    assert_difference '@user.liking.count', 1 do
      xhr :post, likes_path, post_id: @post.id
    end
  end

  test "should unlike a user the standard way" do
    @user.like(@post)
    like = @user.likes.find_by(post_id: @post.id)
    assert_difference '@user.liking.count', -1 do
      delete like_path(like)
    end
  end

  test "should unlike a user with Ajax" do
    @user.like(@post)
    like = @user.likes.find_by(post_id: @post.id)
    assert_difference '@user.liking.count', -1 do
      delete like_path(like), xhr: true
    end
  end
end
