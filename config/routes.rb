Rails.application.routes.draw do
  resources :features, only: [:index, :show] do
    resources :comments, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
