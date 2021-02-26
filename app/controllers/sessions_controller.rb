class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Logged in successfully'
      redirect_to root_path
    else
      flash.now[:error] = 'Credentials not correct'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully Logged out'
    redirect_to login_path
  end
end