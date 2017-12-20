Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'

  resources :memberships, only: [:new, :create]
  resources :subscribers, only: :create
end
