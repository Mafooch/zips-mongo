Rails.application.routes.draw do
  root "zips#index"
  resources :zips
end
