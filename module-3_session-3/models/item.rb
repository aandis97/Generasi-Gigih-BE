require_relative '../db/db_connection' 

class Item
    attr_accessor :name, :price, :id, :categories

    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @price = params[:price]
        if(params[:categories].nil?)
            @categories = []            
        else
            @categories = params[:categories]
        end
    end

    def save
        # puts 'save item model before validation'
        return false unless valid?
        # puts 'save item model'
        client = create_db_client
        client.query("insert into items (name,price) values ('#{name}','#{price}') ")
        
        raw_latest_item = client.query('SELECT * FROM items ORDER BY items.id DESC LIMIT 1')
        latest_item = raw_latest_item.each[0]

        if(categories.length()>0)
            update_item_categories(latest_item["id"], categories)
        end 
    end

    def update
        return false unless valid?
        client = create_db_client
        client.query("update items set name='#{name}', price='#{price}' where id = #{id} ")

        if(categories.length()>0)
            update_item_categories(id, categories)
        end 
    end
 
    def delete
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE item_id = #{id}")
        client.query("DELETE FROM items WHERE id = #{id}")
    end
    
    def update_item_categories(item_id, categories)
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE item_id = #{item_id}")
        categories.each do | category |
            client.query("insert into item_categories values ('#{item_id}','#{category}') ")
        end
    end
    
    def valid?
        return false if @name.nil? 
        return false if @price.nil? 
        true
    end

    def self.get_all_items
        client = create_db_client
        rawData = client.query("select * from items")
        items = Array.new
        rawData.each do | data |
            items.push(Item.new({
                id: data["id"], 
                name: data["name"],
                price: data["price"],
                categories: Category.get_categories_by_item_id(data["id"])
            }))
        end
        items
    end

    def self.get_items_by_category_id(category_id)
        client = create_db_client
        rawData = client.query("select items.* from items join item_categories on item_categories.item_id=items.id where item_categories.category_id=#{category_id}")
        items = Array.new
        rawData.each do | data |
            items.push(Item.new({
                id: data["id"], 
                name: data["name"],
                price: data["price"],
                categories: Category.get_categories_by_item_id(data["id"])
            }))
        end
        items
    end

    def self.select_item_by_id(id)
        client = create_db_client
        raw_data = client.query("SELECT * FROM items where id=#{id} ")
        data = raw_data.each[0]
        item = Item.new({
            id: data["id"], 
            name: data["name"],
            price: data["price"],
            categories: Category.get_categories_by_item_id(data["id"])
        })
        item
    end

end