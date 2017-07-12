class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
  end

  def new
      @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to @post, notice: "Your article was successfully saved!"
    else
      render 'new', notice: "Unable to save your post."
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def update
    if @post.update post_params
      redirect_to @post, notice: "Your article was succesfully saved!"
    else 
      render 'edit'
    end
  end

  private

  def post_params
      params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
