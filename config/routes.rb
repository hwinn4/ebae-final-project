Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy, :new]
  resources :users
  resources :listings
  resources :reviews
  resources :search, only: [:index]
  resources :bids, only: [:create]

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new', as: 'log_in'
  get '/logout', to: 'sessions#destroy', as: 'log_out'
  root to: "home#index"
end
