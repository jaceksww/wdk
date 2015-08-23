Rails.application.routes.draw do
  
  get 'messages/inbox'

  get 'messages/outbox'

  get 'messages/deleted'

  get 'messages/create'
  get 'messages/create/:touserid' => 'messages#create'
  post 'messages/create'

  get 'messages/delete/:messageid/:userid' => 'messages#delete'

  get 'messages/view/:messageid' =>'messages#view'

  get 'infos/index'
  get 'infos' =>'infos#index'

  get 'infos/latest'

  get 'users/login'
  post 'users/login'
  
  get 'users/create_account'
  post 'users/create_account'
  post 'users/isboot'
   get 'users/savefield/:field/:val'=> 'users#savefield'
   
  get 'users/uzytkownicy'

  get 'profil/:displayname'=> 'users#profil'
  get 'users/logout'
  get 'users/settings/:userid'=> 'users#settings'
  post 'users/settings/:userid'=> 'users#settings'
  post 'users/settings'
  
  post 'ws/addimage'
  get 'ws/addimage'=> 'ws#addimage'
  get 'ws/addimage/:galleryid'=> 'ws#addimage'

  get 'ws/galerie'
  get 'ws/galerie/page/:start' => 'ws#galerie'
  get 'ws/galerie/:start/:userid' => 'ws#galerie'

  get 'ws/rejestr-polowow' => 'ws#rejestr_polowow'
  get 'ws/rejestr-polowow/page/:start' => 'ws#rejestr_polowow'
  get 'ws/rejestr-polowow/:start/:userid' => 'ws#rejestr_polowow'

  get 'ws/addrejestrfishery'=> 'ws#addrejestrfishery'
  post 'ws/addrejestrfishery'
  get 'ws/addgallery'=> 'ws#addgallery'
  post 'ws/addgallery'
  get 'ws/addcomment'=> 'ws#addcomment'
  post 'ws/addcomment'
  get 'ws/addarticle'=> 'ws#addarticle'
  get 'ws/addarticle/:id'=> 'ws#addarticle'
  post 'ws/addarticle'
  get 'ws'=> 'ws#index'
  get 'ws/page/:start'=> 'ws#index'
  get 'ws/:start/:userid'=> 'ws#index'
  get 'ws/:wwwid' => 'ws#view'
  
  get 'forums/index/:id' => 'forums#index'
  get 'forums/index'
  
  get 'forums/viewforum'
  get 'forums/viewforum/:id' => 'forums#viewforum'
  get 'forums/viewtopic'
  get 'forums/viewtopic/:id' => 'forums#viewtopic'
  get 'forums/viewtopic/:id/:start' => 'forums#viewtopic'
  get 'forums/deletepost/:postid/:userid/:topicid' => 'forums#deletepost'
  get 'forums/addtopic'

  get 'forums/addreply'
  post 'forums/addreply'

  get 'forums/subscribe'

  get 'liveboxes/index'

  get 'pages/index/:id' => 'pages#index'

  get 'pages/view'
  get 'ryby' => 'pages#ryby'
  get 'ryby/:id' => 'pages#ryba'
  get 'ryby/:id/:more' => 'pages#ryba'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'liveboxes#index'
  get 'page/:start' => 'liveboxes#index'
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
