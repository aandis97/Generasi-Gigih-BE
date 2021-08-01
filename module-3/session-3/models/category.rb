require_relative '../db/db_connection'

class Category
    attr_accessor :name, :id, :items

    def initialize(params)
        @id = params[:id]
        @name = params[:name]          
        if(params[:items].nil?)
            @items = []            
        else
            @items = params[:items]
        end
    end

    def save
        return false unless valid?

        puts 'hit save model';
        client = create_db_client
        client.query("insert into categories (name) values ('#{name}') ")
        puts 'passed hit save model';
    end

    def update
        return false unless valid?

        client = create_db_client
        client.query("update categories set name='#{name}' where id = '#{id}' ")
    end

    def delete
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE category_id = #{id}")
        client.query("DELETE FROM categories WHERE id = #{id}")
    end
    

    def valid?
        return false if @name.nil? 
        true
    end

    def self.get_all_categories
        client = create_db_client
        rawData = client.query("select * from categories")
        categories = Array.new
        rawData.each do | data |
            categories.push(Category.new({
                id: data["id"], 
                name: data["name"]
            }))
        end
        categories
    end

    def self.select_category_by_id(id)
        client = create_db_client
        raw_data = client.query("SELECT * FROM categories where id=#{id} ")
        data = raw_data.each[0]
        item = Category.new({
            id: data["id"], 
            name: data["name"], 
            items: Item.get_items_by_category_id(data["id"])
        })
        item
    end

    def self.get_categories_by_item_id(item_id)
        client = create_db_client
        rawData = client.query("select categories.* from categories left join item_categories on item_categories.category_id = categories.id where item_categories.item_id = #{item_id} ")
        categories = Array.new
        rawData.each do | data |
            categories.push(Category.new({
                id: data["id"], 
                name: data["name"]
            }))
        end
        categories
    end

    def get_category_by_id(id)
        client = create_db_client
        rawData = client.query("select * from categories where id = '#{id}'")
        data = rawData.each[0]
        category = Category.new(data["id"], data["name"])
        category
    end

    def is_checked(categories)
        found = categories.detect{|e| e.id == id}
        return false if found.nil?
        true
    end

end