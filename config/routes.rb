Rails.application.routes.draw do
  resources :users do
    collection do
      get 'create_fast', to: 'users#create_fast'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
