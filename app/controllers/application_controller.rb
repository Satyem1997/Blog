class ApplicationController < ActionController::Base
	
	def select_home_page
		if current_user.present?
			redirect_to posts_path and return
		else
			redirect_to new_user_session_path and return
		end
	end
	
end
