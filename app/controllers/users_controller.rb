class UsersController < ApplicationController
  before_action :load_user_by_name, only: %i[show follow unfollow]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome #{@user.name}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end  

  def follow
    @fellowship = current_user.follow(@user)

    if @fellowship.persisted?
      redirect_to user_path(@user.name), notice: "You are now following @#{@user.name}!"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def unfollow
    @fellowship = current_user.unfollow(@user)
    
    if @fellowship.deleted_at?
      redirect_to user_path(@user.name), notice: "You are no longer following @#{@user.name}!"
    else
      render :show
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def load_user_by_name
    @user = User.find_by(name: params[:name])
  end

end
