class Person
    attr_reader :name, :hitpoint, :attack_damage, :deflect_number
    
    def initialize(name, hitpoint, attack_damage, deflect_number=0)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
        @deflect_number = deflect_number
    end
    
    def to_s
        return "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack"
    end

    def attack(other_person)
        other_person.take_damage(@attack_damage)
        puts "#{@name} attack #{other_person.name} with #{@attack_damage} points"
    end
    
    def take_damage(damage)
        deflect = rand(100)
        if @deflect_number!=0 && deflect<=@deflect_number
            puts "#{@name} deflects the attack"
        else
            @hitpoint -= damage
        end
    end


    def die?
        if @hitpoint <= 0
            puts "#{@name} dies"
            true
        end
    end

end
