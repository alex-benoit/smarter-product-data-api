Rails.application.routes.draw do
  root to: 'pages#home', defaults: { format: :json }
  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index, :show]
    end
  end
end
