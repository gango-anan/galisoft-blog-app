class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in!'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Wrong password or email, try again!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have successfully logged out!'
    redirect_to root_path
  end
end
