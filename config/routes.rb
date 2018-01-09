Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles
  resources :comments
  root 'welcome#index'
end
