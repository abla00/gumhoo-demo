require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    @like = Like.new(user_id: users(:abla).id,
                     post_id: posts(:orange).id)
  end
  
  test "should be valid" do
    assert @like.valid?
  end

  test "should require a user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should require a post_id" do
    @like.post_id = nil
    assert_not @like.valid?
  end
  
  test "should like and unlike a post" do
    abla       = users(:abla)
    cat_video  = posts(:cat_video)
    assert_not abla.liking?(cat_video)
    abla.like(cat_video)
    assert abla.liking?(cat_video)
    abla.unlike(cat_video)
    assert_not abla.liking?(cat_video)
  end
  
end
