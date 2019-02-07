Rails.application.routes.draw do


  # get 'products/index'
  # get 'products/show'
  # get 'products/new'
  # get 'products/create'
  # get 'products/edit'
  # get 'products/update'

  devise_for :users
	root 'application#select_home_page'
  resources :products
	resources :posts do
		resources :comments
    resources :loves
	end

post 'import' => 'products#import'

get 'export' => 'products#export'
# get '/posts/:id', to: 'posts#mypost', as: 'mypostt'

get 'mypost' => 'posts#mypost'
# get 'like' => 'posts#like'
get 'userdetail' => 'posts#userdetail'
get 'demo' => 'posts#demo'
	 


  # get 'posts/indmypost
  # get 'posts/show'
  # get 'posts/edit'
  # get 'posts/create'
  # get 'posts/delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
