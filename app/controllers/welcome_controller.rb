class WelcomeController < ApplicationController
  def index
    @posts = Post.all.limit(6).order("created_at desc")
    @projects = Project.all.limit(6).order("created_at desc")
  end 
end
