require './models/category.rb'

class CategoryController

    def category_list
        categories = Category.get_all_categories 
        renderer = ERB.new(File.read("./views/category/index.erb"))
        renderer.result(binding)
    end

    def create_category
        renderer = ERB.new(File.read('./views/category/create.erb'))
        renderer.result(binding)
    end
    
    def save_category(params)
        puts 'hit save_category controller';
        category = Category.new({
            name: params['name']
        })
        category.save
    end

    def detail_category(params)
        category = Category.select_category_by_id(params['id'])
        renderer = ERB.new(File.read('./views/category/detail.erb'))
        renderer.result(binding)
    end

    def edit_category(params)
        category = Category.select_category_by_id(params['id'])
        renderer = ERB.new(File.read('./views/category/edit.erb'))
        renderer.result(binding)
    end

    def update_category(params)
        puts params
        category = Category.new({
            id: params['id'],
            name: params['name'], 
        })
        category.update
    end

    def delete_category(params) 
        category = Category.new({id: params['id']})
        category.delete
    end

end