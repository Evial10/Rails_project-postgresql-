class UserSessionsController < ApplicationController

  def new 
    @user_session = UserSession.new
  end
  
  def create
    @user_sesion = UserSession.new(user_session_params)
    if @user_sesion.save
      redirect_to translations_path
    else
      render 'new'  
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path
  end
  
  private 
  
  def user_session_params
    params.require(:user_session).permit(:login, :password, :remember_me)
  end
  
end
