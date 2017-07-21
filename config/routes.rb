Rails.application.routes.draw do

  resource :timeline, only: [:show]
  resource :guestbook, only: [:show, :create]
  resources :speeches, only: [:index, :show]
  resource :gift_registry, only: [:show]
  resource :story, only: [:show]
  resource :table_seating, only: [:show]

  root 'home#index'
end
