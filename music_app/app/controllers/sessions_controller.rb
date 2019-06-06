class SessionsController < ApplicationController

    def create
        user = User.find_by_credentials(
        params[:user][:email],
        params[:user][:password]
        )

        if user.nil? #not a user
            flash.now[:errors] = @user.errors.full_messages #render errors
            render :new #display view :new
        else
            log_in_user!(user) #login user
            redirect_to users_url
        end
    end

    def new #new session?
        render :new 
    end

    def destroy #logout
        log_out!
        redirect_to new_session_url
    end


    
end
