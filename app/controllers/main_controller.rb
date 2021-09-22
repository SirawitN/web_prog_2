class MainController < ApplicationController

	def feed
		@user = User.find(params[:user_id])
	end
	
end
