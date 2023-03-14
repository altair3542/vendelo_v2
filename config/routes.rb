Rails.application.routes.draw do
  resources :categories, except: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # delete 'products/:id', to: 'products#destroy'
  # patch 'products/:id', to: 'products#update'
  # post 'products', to: 'products#create'
  # get 'products/new', to: 'products#new', as: :new_product
  # get '/products', to: 'products#index'
  # get '/products/:id', to: 'products#show', as: :product
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product
  resources :products, path: '/'
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
