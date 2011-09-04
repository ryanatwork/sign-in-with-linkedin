class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def client
    LinkedIn.configure do |config|
      config.token = ENV['CONSUMER_KEY']
      config.secret = ENV['CONSUMER_SECRET']
      config.default_profile_fields = ['id','first-name','last-name','headline','location',
        'industry','distance','relation-to-viewer','current-share','connections','num-connections',
        'num-connections-capped','summary','specialties','proposal-comments','associations','honors',
        'interests','positions','publications','patents','languages','skills','certifications',
        'educations','three-current-positions','three-past-positions','num-recommenders',
        'recommendations-received','phone-numbers','im-accounts','twitter-accounts','date-of-birth',
        'main-address','member-url-resources','picture-url','site-standard-profile-request',
        'api-public-profile-request','site-public-profile-request','api-standard-profile-request',
        'public-profile-url']
    end
    @client ||= LinkedIn::Client.new
  end

end
