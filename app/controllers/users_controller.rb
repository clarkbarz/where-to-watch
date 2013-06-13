class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  private

  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
  	end

    # Before filter

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in. " unless signed_in?
    end

    def sign_in_redirect_to(user)
      flash[:success] = "Profile updated"
      sign_in user
      redirect_to user
    end
end
