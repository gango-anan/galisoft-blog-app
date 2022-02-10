class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

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
      flash[:notice] = "Welcome to Galisoft Blog #{@user.username.capitalize}"
      redirect_to articles_path
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
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
