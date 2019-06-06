class ApplicationController < ActionController::Base
    
    helper_method :current_user
    helper_method :logged_in?
    
    #gives the user a new token
    def log_in_user!(user)
        session[:session_token] = user.reset_session_token! 
    end 

    #verifies if the user and its session token???
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    #returns if the current user equals to the session token?
    def logged_in? 
        !current_user
    end

    #resets the session token
    def log_out! 
        current_user.reset_session_token! if current_user
        session[:session_token]= nil
        # @current_user = nil
    end
end
