class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

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

  private

  def logged_in_redirect
    if logged_in?
      redirect_to root_path
    end
  end

end