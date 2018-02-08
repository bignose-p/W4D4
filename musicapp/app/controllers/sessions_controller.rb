class SessionsController < ApplicationController
  

  def create 
    @user = User.find_by_credentials(params[:email], params[:password]) 
    
    if @user 
      log_in_user!(@user)
      redirect_to user_url(@user)
    else 
      redirect_to new_session_url
    end 

  end 
  
  
  def destroy 
    
    user = current_user 
    if user   
      user.reset_session_token!
    end 
    
    redirect_to new_session_url 
  end 
  
  def new 
    render :new 
  end 
  
    
end 
