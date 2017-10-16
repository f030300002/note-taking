Rails.application.routes.draw do

  get 'dashboard/index'

  root to: 'dashboard#index' 

  resources :users do
    resources :records
  end

  resources :sessions

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  put '/users/:user_id/records/:id', to: 'records#update', as: :update_user_record
  delete '/users/:user_id/records/:id', to: 'records#destroy', as: :delete_user_record

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
