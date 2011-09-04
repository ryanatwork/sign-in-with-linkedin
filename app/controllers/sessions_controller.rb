class SessionsController < ApplicationController
  def create
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_secret] = request.env['omniauth.auth']['credentials']['secret']
    redirect_to show_path, :notice => "Signed in with LinkedIn!"
  end

  def show
    if session['access_token'] && session['access_secret']
      client.authorize_from_access(session['access_token'], session['access_secret'])
      @user = client.profile
    else
      redirect_to failure_path
    end
  end

  def error
    flash[:error] = "Sign in with LinkedIn failed!"
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "Signed out!"
  end
end
