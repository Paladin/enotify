ActionController::Routing::Routes.draw do |map|
  map.resource :session
    
  map.resources :users

  map.resources :crimes, :collection => {:recent => :get}
  
  map.resources :service_requests, :collection => {:recent => :get}

  map.resources :permit_records, :collection => {:recent => :get}

  map.resources :violation_records, :collection => {:recent => :get}

  map.resources :recording_applications, :collection => {:recent => :get}

  map.resources :incidents, :collection => {:recent => :get}

  map.resources :enotify_mails

  map.connect ':controller/:year/:month', 
    :action => 'index',
    :requirements => {:month => /\d{1,2}/, :year => /\d{4}/}
  map.connect ':controller/:year/:month.:format', 
    :action => 'index',
    :requirements => {:month => /\d{1,2}/, :year => /\d{4}/}
    
  map.connect ':controller/search/*terms',
    :action => 'search'
    
  map.by_address ':controller/by_address/:address_id', :action => 'by_address'
  map.by_address ':controller/by_address/:address_id.:format', :action => 'by_address'
  
  map.by_record_number ':controller/by_record_number/:record_number', :action => 'by_record'
  map.by_record_number ':controller/by_record_number/:record_number.:format', :action => 'by_record'
  
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
