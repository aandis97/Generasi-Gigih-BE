class Person
    attr_reader :name, :hitpoint, :attack_damage
    
    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
        @alive = true
    end
    
    def to_s
        return "#{@name}"
    end

    def print_stats
        puts "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack"
    end

    def attack(other_person)
        puts "#{@name} attack #{other_person.name} with #{@attack_damage} points"
        other_person.take_damage(@attack_damage)
    end
    
    def take_damage(damage) 
        @hitpoint -= damage
        if @hitpoint <= 0
            die
        end
    end

    def take_healing(heal_point)
        @hitpoint += heal_point
    end

    def die
        puts "#{@name} dies"
        @alive = false
    end

    def die?
        !@alive
    end

    def removed?
        die?
    end

end
