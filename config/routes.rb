Rails.application.routes.draw do
  root to: "pages#home"

  resources :retirements, only: %i[new create show]
end
