Rails.application.routes.draw do
  resources :pictures
  resources :advanced_searches
  resources :sessions, only: [:create, :destroy, :new]
  resources :users
  resources :reviews, only: [:new, :create, :show]
  resources :listings do
    resources :messages, only: [:new, :create, :show, :update]
    resources :sales do
      resources :reviews
    end
  end

  # resources :conversations do
  #   resources :messages, only: [:show, :new, :create]
  # end

  resources :categories
  resources :charges, only: [:create]
  resources :messages, only: [:index]
  patch 'messages/update_multiple', :to => 'messages#update_multiple'

  resources :search, only: [:index]
  resources :bids, only: [:create]
  resources :dashboard, only: [:index]
  resources :watchlists, only: [:create, :destroy]
  get '/analytics/highest_sale_price', to: 'analytics#highest_sale_price', as: 'highest_sale_price'
  get '/analytics/state', to: 'analytics#state', as: 'state'
  get '/analytics/highest_sale_price_month', to: 'analytics#highest_sale_price_month', as: 'highest_sale_price_month'
  get '/analytics/lowest_sale_price_month', to: 'analytics#lowest_sale_price_month', as: 'lowest_sale_price_month'
  get '/analytics/popular_by_bids', to: 'analytics#popular_by_bids', as: 'popular_by_bids'
  get '/users/public/:id', to: 'users#public', as: 'public'
  get '/analytics/most_watched', to: 'analytics#most_watched', as: 'most_watched'
  get '/user/:id/feedback', to: 'users#feedback'
  get 'user/:id/givefeedback', to: 'users#givefeedback'
  get '/users/:id/reviews', to: 'reviews#summary', as: 'reviews_summary'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new', as: 'log_in'
  get '/logout', to: 'sessions#destroy', as: 'log_out'
  root to: "home#index"
  get '/analytics', to: 'analytics#index', as: 'analytics'
  namespace :api, :defaults => { :format => 'json' } do
    resources :categories
    resources :advanced_searches
    resources :bids
    resources :buyers
    resources :charges
    resources :conditions
    resources :conversations
    resources :items
    resources :listings
    resources :locations
    resources :messages
    resources :phones
    resources :recently_viewed_listings
    resources :reviews
    resources :sales
    resources :sellers
    resources :users
    resources :watchlists

  end
end
