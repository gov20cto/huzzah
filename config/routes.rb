Huzzah::Application.routes.draw do
  resources :features

  root :to => "features#index"

  devise_for :users

  match "/images/uploads/*path" => "gridfs#serve"
end
