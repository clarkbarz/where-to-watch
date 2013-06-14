class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Where to Watch!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.authenticate(params[:user][:old_password])
      if @user.email != params[:user][:email]
        @user.update_attribute :email, params[:user][:email]
        sign_in_redirect_to @user
      elsif @user.update_attributes(user_params)
        sign_in_redirect_to @user
      else
        render 'edit'
      end
    else
      flash.now[:error] = "Password is incorrect"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
  	end

    def sign_in_redirect_to(user)
      flash[:success] = "Profile updated"
      sign_in user
      redirect_to user
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
