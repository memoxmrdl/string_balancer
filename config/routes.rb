Rails.application.routes.draw do
  resources :string_balancers, only: [:new, :create]

  root "string_balancers#new"
end
