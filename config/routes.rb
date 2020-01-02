Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, skip: [:registrations, :sessions]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
     devise_for :users, controllers: {sessions: 'api/v1/sessions', registrations: 'api/v1/registrations'}
     resources :tweets

     get "follow", to: "relationships#follow_user"
    get "unfollow", to: "relationships#unfollow_user"
    get "follower_tweets", to: "tweets#follower_tweets"
    end
  end

end
