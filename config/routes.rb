Rails.application.routes.draw do

resources :sessions, only: [:new, :create] do
  delete :destroy, on: :collection
end

resources :users, only: [:new, :create] do
  resources :likes, only: [:index]
end

resources :ideas do
  resources :likes, only: [:create, :destroy]
  resources :reviews
end

root 'ideas#index'
end
