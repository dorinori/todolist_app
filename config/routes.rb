Rails.application.routes.draw do
  	resources :tags

	resources :todo_lists do
	   resources :todo_items do
	    member do
	     patch :complete
	     patch :increment
	     patch :decrement
	    end
	  end
	end

	resources :todo_list_tags
	# get 'todo_list_tags(.:format)', :to => 'todo_list_tags#index', :as => :todo_list_tags
	delete  'todo_list_tags(.:format)', :to => 'todo_list_tags#destroy', :as => :delete_todo_list


	root "todo_lists#index"
end
