Rails.application.routes.draw do

  #devise_for :users
  devise_for :users, controllers: { registrations: "users/registrations" }, views: { registerations: "users/registerations"}
  root 'welcome#index'

  resources :products
  get 'new_product', to: 'products#new'
  post 'create_product', to: 'products#create'
  delete 'destroy_product', to: 'products#destroy'
  get 'edit_product', to: 'products#edit'
  patch 'update_product', to: 'products#update'


  resources :categories
  get 'new_category', to: 'categories#new'
  post 'create_category', to: 'categories#create'
  delete 'destroy_category', to: 'categories#destroy'
  get 'edit_category', to: 'categories#edit'
  patch 'update_category', to: 'categories#update'

  get 'admin', to: 'users#admin'


  get 'new_order', to: 'orders#new'
  post 'create_order', to: 'orders#create'
  delete 'destroy_order', to: 'orders#destroy'
  get 'edit_order', to: 'orders#edit'
  patch 'update_order', to: 'orders#update'
  get 'my_cart', to: 'orders#cart'


end
