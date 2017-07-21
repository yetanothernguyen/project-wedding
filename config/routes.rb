Rails.application.routes.draw do
  get 'guestbook/index'

  root 'home#index'
end
