Rails.application.routes.draw do
  resource :guestbook, only: [:show, :create]

  root 'home#index'
end
