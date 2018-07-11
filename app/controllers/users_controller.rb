class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Cuenta creada exitosamente, bienvenido %s!" % @user.name
      redirect_to @user
    else
      # flash.now[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  private

    def user_params
      params
        .require(:user)
        .permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
    end
end
