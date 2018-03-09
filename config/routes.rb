Rails.application.routes.draw do

  root 'static_pages#home'
  resources :sessions, only: [:create]
  get '/signin', to: 'sessions#new'
  post '/logout', to: 'sessions#destroy'
  

  get '/rides/new/:user_id/:attraction_id', to: 'rides#new'

  resources :attractions
  resources :rides

  resources :users
  #root '/', to: 'static_pages#home'

end
