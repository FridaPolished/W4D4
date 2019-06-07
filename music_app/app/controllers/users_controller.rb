class UsersController < ApplicationController

    def create 
        @user = User.new(user_params)
        if @user.save
            redirect_to :show
        else
            # flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find(params[:id])
        # @user = User.find_by(id: params[:id])
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
