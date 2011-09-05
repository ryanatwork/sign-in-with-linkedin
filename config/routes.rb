SignInWithLinkedin::Application.routes.draw do
  get "connections/show"

  root :to => "welcome#index"
  get '/auth/linked_in/callback', :to => 'sessions#create', :as => 'callback'
  get '/auth/failure', :to => 'sessions#error', :as => 'failure'
  get '/profile', :to => 'sessions#show', :as => 'show'
  delete '/signout', :to => 'sessions#destroy', :as => 'signout'
end
