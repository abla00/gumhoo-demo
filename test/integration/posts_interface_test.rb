require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:abla)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, post: { title: "", content: "", price: nil }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    title   = "Valid title"
    content = "This post really ties the room together"
    price   = 10
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, post: { title:   title,
                               content: content,
                               price:   price,
                               picture: picture }
    end
    foo = assigns(:post)
    assert foo.picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "post sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.posts.count} posts", response.body
    # User with zero posts
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 posts", response.body
    other_user.posts.create!(title: "test", content: "A micropost", price:5)
    get root_path
    assert_match "1 post", response.body
  end
end
