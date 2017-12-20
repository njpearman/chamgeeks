Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'

  resources :subscribers, only: :create
end
