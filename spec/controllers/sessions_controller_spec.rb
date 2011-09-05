require 'spec_helper'

describe SessionsController do

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:linked_in]
  end

  describe "GET 'create'" do
    it "should create a new session from omniauth" do
      get :create
      session[:access_token].should== "abc123"
      session[:access_secret].should == "xyz987"
      response.should redirect_to(show_path)
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      session[:access_token] = request.env['omniauth.auth']['credentials']['token']
      session[:access_secret] = request.env['omniauth.auth']['credentials']['secret']
      stub_request(:get, "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,location,industry,distance,relation-to-viewer,current-share,connections,num-connections,num-connections-capped,summary,specialties,proposal-comments,associations,honors,interests,positions,publications,patents,languages,skills,certifications,educations,three-current-positions,three-past-positions,num-recommenders,recommendations-received,phone-numbers,im-accounts,twitter-accounts,date-of-birth,main-address,member-url-resources,picture-url,site-standard-profile-request,api-public-profile-request,site-public-profile-request,api-standard-profile-request,public-profile-url)").
         to_return(:status => 200, :body => "{}", :headers => {})
      get 'show'
      response.should be_success
    end

    it "should redirect to failure path" do
      get 'show'
      response.should redirect_to failure_path
    end
  end

  describe "GET 'error'" do
    it "should display error message" do
      get 'error'
      flash[:error].should == "Sign in with LinkedIn failed!"
      response.should redirect_to root_path
    end
  end

  describe "GET 'destroy'" do
    it "should destroy the session" do
      get 'destroy'
      session['access_token'].should be_nil
      session['access_secret'].should be_nil
      response.should redirect_to root_path
    end
  end

end
