Rails.application.routes.draw do
  root to: "pages#home"

  get '/about', to: 'pages#about', as: :about

  resources :retirements, only: %i[new create show]
end
