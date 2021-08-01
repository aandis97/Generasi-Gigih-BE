require 'sinatra'
require './db_connector'


get '/' do
    items = get_all_items
    erb :index, locals: {
        items: items
    } 
end

get '/items/:id' do
    id = params['id']
    item = select_one_item(id)
    erb :detail, locals: {
        item: item
    } 
end

get '/items/:id/edit' do
    id = params['id']
    item = select_one_item(id)
    erb :edit, locals: {
        item: item
    } 
end


post '/items/:id/update' do
    id = params['id']
    name = params['name']
    price = params['price']
    category_id = params['category']
    update_item(id, name, price,category_id)

    redirect '/'
end

get '/items/create/new' do
    erb :create
end

post '/items/create' do
    name = params['name']
    price = params['price']
    create_new_item(name, price)
    redirect '/'
end

post '/items/:id/delete' do
    id = params['id']
    delete_item(id)
    redirect '/'
end