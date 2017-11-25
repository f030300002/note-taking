Rails.application.routes.draw do

  get 'dashboard/index'

  root to: 'dashboard#index' 

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :users do
    resources :records
    resources :notes
  end

  resources :sessions

  resources :records, concerns: :paginatable

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  put '/users/:user_id/records/:id', to: 'records#update', as: :update_user_record
  delete '/users/:user_id/records/:id', to: 'records#destroy', as: :delete_user_record
  delete '/users/:user_id/notes/:id', to: 'notes#destroy', as: :delete_user_note

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
