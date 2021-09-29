Rails.application.routes.draw do
  resources :posts
  resources :users do
    collection do
      get 'create_fast', to: 'users#create_fast'
    end
  end

  get '/main', to: 'main#log_in'
  post '/main', to: 'main#find_user'
  get '/main/:user_id', to: 'main#feed', as: "feed"
  get 'main/:user_id/log_out', to: 'main#log_out', as: "log_out"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
