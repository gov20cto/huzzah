Huzzah::Application.routes.draw do
  get "reports" => "reports#index"

  resources :features

  root :to => "features#index"

  devise_for :users

  match "/images/uploads/*path" => "gridfs#serve"
end
