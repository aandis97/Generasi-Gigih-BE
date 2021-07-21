require 'mysql2'
require './item'
require './category'

def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "admin123",
        :database => "food_oms_db"
    )

    client
end


def get_all_items
    client = create_db_client
    rawData = client.query("select * from items")
    
    items = Array.new
    rawData.each do | data |
        item = Item.new(data['name'],data['price'].to_s,data['id'])
        items.push(item)
    end

    items
end

def get_all_categories
    client = create_db_client
    items = client.query("select * from items")
    items
end


def get_all_categories_by_item(id)
    client = create_db_client
    rawData = client.query("select categories.* from item_categories join categories on categories.id=item_categories.category_id
        where item_categories.item_id=#{id}")
    
    categories = Array.new
    rawData.each do | data |
        category = Category.new(data['name'],data['id'])
        categories.push(category)
    end
    categories
end

# categories = get_all_categories
# puts categories.each

def get_all_item_with_categories
    client = create_db_client
    rawData = client.query("
        select items.id, items.name, categories.name as category_name, categories.id as category_id
        join item_categories on items.id = item_categories.item_id
        join categories on item_categories.category_id = categories.id
        ")

    items = Array.new

    rawData.each do | data |
        category = Category.new(data['category_name'], data['category_id'])
        item = Item.new(data["name"], data["price"], data["id"], category)
        items.push(item)
    end

    items
end

# items = get_all_item_with_categories
# items.each do |item|
#     puts(item.name)
# end


def create_new_item(name, price)
    client = create_db_client
    items = client.query("insert into items (name, price) values ('#{name}','#{price}')")
end


def update_item(id,name, price, category_id)
    client = create_db_client
    items = client.query("update items set name='#{name}', price='#{price}' where id=#{id}")
end



def select_one_item(id)
    client = create_db_client
    rowData = client.query("select * from items where id=#{id}")
    
    item = nil
    rowData.each do | data |
        categories = get_all_categories_by_item(id)
        item = Item.new(data["name"], data["price"], data["id"], categories)
    end

    item
end


def delete_item(id)
    client = create_db_client
    deleteItem = client.query("DELETE FROM items WHERE id=#{id}")
    deleteItemCategories = client.query("DELETE FROM item_categories WHERE item_id=#{id}")
end