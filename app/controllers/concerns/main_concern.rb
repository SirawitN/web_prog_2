module MainConcern
	extend ActiveSupport::Concern

	included do
		helper_method :is_logged_in
	end

	def is_logged_in
      if !session[:user_id]  #check nil
        respond_to do |format|
          #flash[:alert] = "Please login before making any action !!!"
          format.html {redirect_to main_url, alert: "Please login before making any action !!!"}
        end
      end
    end

    def is_the_right_user(user_id)
    	#puts "session = #{session[:user_id]},  user_id = #{user_id}"
    	if(session[:user_id] != user_id)
    		redirect_back fallback_location: main_path, alert: "Access denied!!"
    	end
   	end
end