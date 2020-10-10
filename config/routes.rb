Rails.application.routes.draw do
  root 'public/items#top'
  devise_for :admin, controllers: {
     sessions: 'admin/sessions'
     }
     #どこのコントローラーを引っ張ってくるかの記述
     #adminディレクトリのsessionsコントローラーを指定することが出来る
     #記述がないと、deviseディレクトリのsessionsコントローラーを引っ張ってくる

  scope module: :public do
      resource :end_users, only: [:show, :edit, :update, :destroy] #デバイスの下にあるとeditに飛ばしたとき、deviseのeditが読み込まれてしまうため,resourceを上に書く。idを付与しないのでresourceである
     devise_for :end_users, controllers: {
        sessions: 'public/end_users/sessions',
        registrations: 'public/end_users/registrations'
     }
     # post 'orders/information' => 'orders#information', as: "information"
     delete 'cart_items/destroy_all' => 'cart_items#destroy_all',as: "destroy_all"
     resources :cart_items, only: [:index, :update, :destroy, :create] do
       post 'orders/information' => 'orders#information', as: "information"
       get 'orders/completed' => 'orders#completed', as: "completed"
       resources :orders, only: [:new, :create, :index]
     end
     resources :items, only: [:index, :show]
     resources :addresses, only: [:index, :edit, :create, :update, :destroy]
   #   delete 'cart_items/destroy_all' => 'cart_items#destroy_all',as: "destroy_all" # resourceより後にあるので、viewを作ってないと,resourceのdestroyが先に読み込まれる
   # urlを指定するか指定しないかの違いは、resourceで先に読み込まれるか,viewを作るか
   # cart_itemsで指定するなら何もしなくてよいけど、
   # cart_items/destroy_allで指定するならば、viewファイルと、resouceより上に書かないといけない(cart_items/:idのidとしてdestroy_allが読み込まれてしまう)
     get 'end_users/confirm' => 'end_users#confirm',as: "confirm"                  #resourcesの中に存在しないので、自分で設定する必要がある。
     patch 'end_users/withdrawal' => 'end_users#withdrawal',as: "withdrawal"
  end
  namespace :admin do
     get 'top' => 'top#top'
     resources :genres, only: [:index, :create, :edit, :update]
     resources :end_users, only: [:index, :create, :edit, :update]
     resources :items, only: [:index, :new, :create, :show, :edit, :update]
     resources :orders, only: [:index, :show, :update]
     resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end