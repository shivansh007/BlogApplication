Rails.application.routes.draw do
  get 'welcome/index'

  	resources :users
	resources :articles do
	  	resources :comments
	end

  post 'users/login'
  post 'users/signup'
  post 'users/check'
  post 'users/new'
  post 'users/logout'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
