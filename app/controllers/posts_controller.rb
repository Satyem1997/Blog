class PostsController < ApplicationController

    before_action :authenticate_user!, except: [:index]

    def demo
    end

    def userdetail
        @user = User.find(current_user.id)
    end

    # def like 
    #     if session[:vvlike].nil?
    #         session[:vvlike]=1
    #     else
    #         session[:vvlike] +=1
    #     end
    #     redirect_to posts_path
    # end

    def index
        # flash[:signin] = "You need to sign in first"
        # session[:vlike] ||= 0
        # session[:vlike] += 1
        @posts = Post.all.order("created_at DESC")
    end

    def mypost
        @posts = current_user.posts
    end


    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        # @post.user_id = current_user

        # params.to_json and return

        if @post.save!
            redirect_to mypost_path
        else
            render 'new'
        end
    end

    def show
        @userlove = Love.where("user_id = ? AND post_id = ?", current_user.id, params[:id])
        @post = Post.find(params[:id])
        @comments = @post.comments.order('created_at desc')
        @love = Love.where("post_id = ?", params[:id])
        @countlove = @love.size
        # @post = Post.find(current_user)
        # @post = Post.find(params[:id])
    end

    def update
        # @post = Post.find(current_user)
        @post = Post.find(params[:id])
        
        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    def edit
        @post = mypost.find(params[:id])
        # @post = Post.find(params[:id])
    end

    def destroy
        # @post = Post.find(current_user)
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to mypost_path

    end

    private

    def post_params
        params.require(:post).permit(:image, :title, :content)
    end

  def delete
  end
end
