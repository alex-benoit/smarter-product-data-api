Rails.application.routes.draw do
  root to: 'home#home', defaults: { format: :json }
  # Sidekiq Web UI
  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'

  # API
  namespace :v1, defaults: { format: :json } do
    resources :items, only: [:index, :show]
  end
end
