Rails.application.routes.draw do

	get '/ui' => 'ui#index'
	get '/ui#' => 'ui#index'
	root 'ui#index'

	scope :api, defaults: { format: :json } do
    resources :foos, except: [:new, :edit]
    resources :bars, except: [:new, :edit]
	end
end
