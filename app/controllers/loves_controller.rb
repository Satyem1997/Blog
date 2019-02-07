class LovesController < ApplicationController

	    before_action :authenticate_user!

	def create 

		# @userlove = Love.where("user_id = ? AND post_id = ?", current_user.id, params[:post_id])

		@post = Post.find(params[:post_id])
		
		@love = Love.where("user_id = ? AND post_id = ?", current_user.id, params[:post_id])

		@like = Love.where("post_id = ?", params[:post_id])
        @countlove = @like.size

		if @love.empty?
			@love = Love.new()
			@love.post_id = @post.id
			@love.user_id = current_user.id
			@love.save!
			respond_to do |format|
            	# format.js {}
            	format.html { redirect_to post_path(@post) }
            end
		else
			flash[:fail] = "already liked"
			respond_to do |format|
            	# format.js {}
            	format.html { redirect_to post_path(@post) }
            end
			#render post_path(@post)
		end

	end

	def destroy
		@userlove = Love.where("user_id = ? AND post_id = ?", current_user.id, params[:post_id])
		@post = Post.find(params[:post_id])
		@love = Love.where("user_id = ? AND post_id = ?", current_user.id, params[:post_id])
		@love.destroy_all
		@like = Love.where("post_id = ?", params[:id])
        @countlove = @like.size
		respond_to do |format|
            format.js {}
            format.html { redirect_to post_path(@post) }
        end

	end

end
