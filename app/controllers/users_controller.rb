class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_same_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Galisoft Blog #{@user.username.capitalize}"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Update was successful!'
      redirect_to articles_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = 'You can only edit your own account'
      redirect_to root_path
    end
  end
end
