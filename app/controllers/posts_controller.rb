class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :find]
  before_action :correct_user,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @doc = Nokogiri::HTML(open(params[:post][:link]))
      render 'posts/find'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  # Fetch and parse HTML document
  def find
    if params[:link].blank?
      redirect_to root_url
    else
      @doc  = Nokogiri::HTML(open(params[:link]))
      @post = current_user.posts.build
    end
  end
  
  private

    def post_params
      params.require(:post).permit(:title, :content, :price, :currency, :picture, :link)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
