Rails.application.routes.draw do

  root 'films#index'

  devise_for :users
  resources :films
end
