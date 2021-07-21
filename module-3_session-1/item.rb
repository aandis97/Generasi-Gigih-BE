class Item
    attr_accessor :name, :price, :id, :categories

    def initialize(name, price, id, categories = nil)
        @name = name
        @price = price
        @id = id
        @categories = categories
    end
end