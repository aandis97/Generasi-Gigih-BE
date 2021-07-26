require 'sinatra'
require './controllers/category_controller.rb'
require './controllers/item_controller.rb'

get '/categories' do
    category_controller = CategoryController.new
    category_controller.category_list
end
  
get '/categories/create' do
    category_controller = CategoryController.new
    category_controller.create_category
end

post '/categories/create' do  
    category_controller = CategoryController.new
    category_controller.save_category(params)
    redirect '/categories'
end

get '/categories/:id/detail' do
    category_controller = CategoryController.new
    category_controller.detail_category(params)
end

get '/categories/:id/edit' do
    category_controller = CategoryController.new
    category_controller.edit_category(params)
end

post '/categories/:id/update' do
    category_controller = CategoryController.new
    category_controller.update_category(params)

    redirect '/categories'
end

post '/categories/:id/delete' do
    category_controller = CategoryController.new
    category_controller.delete_category(params)

    redirect '/categories'
end

# ==========================

get '/' do
    redirect '/items'
end


get '/items' do
    item_controller = ItemController.new
    item_controller.item_list
end
  
get '/items/create' do
    item_controller = ItemController.new
    item_controller.create_item
end

post '/items/create' do  
    item_controller = ItemController.new
    
    puts 'save item routes'
    item_controller.save_item(params)
    redirect '/items'
end

get '/items/:id/detail' do
    item_controller = ItemController.new
    item_controller.detail_item(params)
end

get '/items/:id/edit' do
    item_controller = ItemController.new
    item_controller.edit_item(params)
end

post '/items/:id/update' do
    item_controller = ItemController.new
    item_controller.update_item(params)

    redirect '/items'
end

post '/items/:id/delete' do
    item_controller = ItemController.new
    item_controller.delete_item(params)

    redirect '/items'
end