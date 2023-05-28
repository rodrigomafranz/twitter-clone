class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome #{@user.name}!"
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end
  
end
