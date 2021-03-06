class SessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_admin

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Hey!, combinacion de email y/o password incorrecta, se que tienes hambre pero concentrate!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
