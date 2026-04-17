Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      post 'auth/register', to: 'auth#register'
      post 'auth/login', to: 'auth#login'

      resources :properties, only: [:index, :show]

      resources :watchlist, only: [:index] do
        collection do
          post ':property_id', action: :create
          delete ':property_id', action: :destroy
        end
      end
    end
  end
end
