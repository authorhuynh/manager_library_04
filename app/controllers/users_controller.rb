class UsersController < ApplicationController

  before_action :logged_in_user, except: [:index, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "view.users.show.error_user"
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params    
    if @user.save
      log_in @user
      flash[:success] = t "view.users.new.msg_success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "view.users.show.msg_update"
      redirect_to @user
    else
      flash[:danger] = t "view.users.show.msg_error"
      render :edit
    end
  end

  def destroy
    if User.find_by(id: params[:id]).destroy
      flash[:success] = t "view.users.index.msg_delete"
    else
      flash[:danger] = t "view.users.index.msg_error"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation, :phone, :address 
  end

  def verify_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
