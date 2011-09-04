class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def client
    LinkedIn.configure do |config|
      config.token = ENV['CONSUMER_KEY']
      config.secret = ENV['CONSUMER_SECRET']
      config.default_profile_fields = ['certifications','date-of-birth','educations',
        'phone-numbers','positions','picture-url','skills','summary']
    end

    @client ||= LinkedIn::Client.new
    @client.authorize_from_access(session['access_token'], session['access_secret'])
  end

end
