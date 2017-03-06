class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password]) 
      flash[:success] = t "view.sessions.new.msg_success"
      log_in user
      params[:session][:remember_me] == Settings.number_one ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "view.sessions.new.msg_errors"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
