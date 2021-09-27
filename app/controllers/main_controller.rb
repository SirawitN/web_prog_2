class MainController < ApplicationController
	before_action :set_user, only: %i[feed]

	def log_in
	end

	def find_user
    	puts "email = #{params[:email]}, password = #{params[:password]}"
    	@user = User.find_by(email: params[:email], password: params[:password])
    	respond_to do |format|
      		if @user != nil
        		puts "Found"
        		format.html {redirect_to user_id_path(@user)}
      		else 
        		puts "Not found"
        		flash.now[:alert] = "Log in failed, wrong email or password !!"
        		format.html {render :log_in}   #<<-------------------- 
      		end
    	end
  	end


	def feed
	end

	private
		def set_user
			@user = User.find(params[:user_id])
		end
	
end
