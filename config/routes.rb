Rails.application.routes.draw do
  namespace :api do
    namespace  :v1 do
      resources :timeslots
      get 'timestamps', to: 'timestamps#index'
    end
  end

  mount ActionCable.server => '/cable'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
