require './models/item'
require './models/category'

class ItemController
    def item_list
        items = Item.get_all_items 
        renderer = ERB.new(File.read("./views/item/index.erb"))
        renderer.result(binding)
    end

    def create_item
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/item/create.erb'))
        renderer.result(binding)
    end
    
    def save_item(params)
        puts 'save item controller'
        puts params['categories']
        item = Item.new({
            name: params['name'],
            price: params['price'],
            categories: params['categories']
        })
        item.save
    end

    
    def detail_item(params)
        item = Item.select_item_by_id(params['id']) 
        renderer = ERB.new(File.read('./views/item/detail.erb'))
        renderer.result(binding)
    end

    def edit_item(params)
        item = Item.select_item_by_id(params['id'])
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/item/edit.erb'))
        renderer.result(binding)
    end

    def update_item(params)
        puts params
        item = Item.new({
            id: params['id'],
            name: params['name'],
            price: params['price'],
            categories: params['categories']
        })
        item.update
    end

    
    def delete_item(params) 
        item = Item.new({id: params['id']})
        item.delete
    end
    
end