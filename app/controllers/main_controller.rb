class MainController < ApplicationController
	include MainConcern

	before_action :is_logged_in, only: %i[ feed ]
	before_action :set_user, only: %i[ feed ]
	before_action only: %i[ feed ] do
    	if @user
    		is_the_right_user(@user.id)
    	else
    		is_the_right_user(-1)
    	end
  	end

	def log_in
		#session[:user_id] = nil
		puts "user_id = #{session[:user_id]}"
		if session[:user_id] 
			redirect_to feed_path(session[:user_id])
		end
	end

	def log_out
		session[:user_id] = nil
		redirect_to main_path
	end

	def find_user
    	#puts "email = #{params[:email]}, password = #{params[:password]}"
    	@user = User.find_by(email: params[:email]).authenticate(params[:password]) rescue nil
    	respond_to do |format|
      		if @user
        		puts "Found"
        		format.html {redirect_to feed_path(@user)}
        		session[:user_id] = @user.id
      		else 
        		puts "Not found"
        		#flash.now[:alert] = "Log in failed, wrong email or password !!"
        		format.html { redirect_to main_path, alert: "Log in failed, wrong email or password"}   #<<-------------------- 
      		end
    	end
  	end


	def feed
	end

	private
		def set_user
			@user = User.find(params[:user_id]) rescue nil
		end
end
