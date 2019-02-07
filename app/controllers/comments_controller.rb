class CommentsController < ApplicationController

    before_action :authenticate_user!

	# def create
 #        @post = Post.find(params[:post_id])
 #         @comment = @post.comments.create(params[:comment].permit(:comment))
 #         comment.
 #        redirect_to post_path(@post)
 #    end

    def edit
        # render json: params and return

        @comment = Comment.find(params[:id])
        @post = Post.find(params[:post_id])
        respond_to do |format|
            format.js {}
            format.html {}

        end
        # @posts = @post.current_user.posts
        # @section_count = Section.count
    end

    def update
        @comment = Comment.find(params[:id])
        @post = Post.find(params[:post_id])

        # @comment.image_file_name = @post.image_file_name
        # @comment.image_content_type = @post.image_content_type
        # @comment.image_file_size = @post.image_file_size

        if @comment.update(comment_params)
            respond_to do|format|
                format.js
                format.html { redirect_to @comment.post }
            end
        else
            @posts = @post.current_user.posts
            respond_to do|format|
                format.js
                format.html { render('edit') }
            end
        end

        # @comment = Comment.find(params[:id])
        
        # if @comment.update(comment_params)
        #     redirect_to @post
        # else
        #     render 'edit'
        # end
    end

    #def new
     #   @comment = Comment.new
    #end

    def create
        @post = Post.find(params[:post_id])

        @comment = current_user.comments.new(comment_params)

        @comment.post_id = @post.id
        @comment.user_id = current_user.id
        @comment.image_file_name = @post.image_file_name
        @comment.image_content_type = @post.image_content_type
        @comment.image_file_size = @post.image_file_size

        # params.to_json and return

        @comment.save
        respond_to do |format|
            format.js
            format.html { redirect_to post_path(@comment.post) }
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.js
            format.html { redirect_to post_path(@post) }
        end
        
    end

    private

    def comment_params
        params.require(:comment).permit(:comment)
    end


    
end
