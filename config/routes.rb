Rails.application.routes.draw do
  resources :posts
  resources :users do
    collection do
      get 'create_fast', to: 'users#create_fast'
    end
  end

  get '/main', to: 'users#log_in'
  post '/main', to: 'users#find_user'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
