class ConnectionsController < ApplicationController
  def show
    if session['access_token'] && session['access_secret']
      client.authorize_from_access(session['access_token'], session['access_secret'])
      @conn = client.profile.connections
    else
      redirect_to failure_path
    end
 end
end
