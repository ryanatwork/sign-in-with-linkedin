Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['CONSUMER_KEY'].blank? or ENV['CONSUMER_SECRET'].blank?
    warn "*" * 80
    warn "WARNING: Missing consumer key or secret. First, register an app with LinkedIn at"
    warn "https://www.linkedin.com/secure/developer to obtain OAuth credentials. Then, start the server"
    warn "with the command: CONSUMER_KEY=abc CONSUMER_SECRET=123 rails server"
    warn "*" * 80
  end
  use OmniAuth::Strategies::LinkedIn, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end
