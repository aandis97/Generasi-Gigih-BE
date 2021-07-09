require_relative 'person'

class Hero < Person
    def initialize(name, hitpoint, attack_damage, deflect_number=0)
        super(name, hitpoint, attack_damage, deflect_number)
        @deflect_percemtage = 0.8
    end

    def take_damage(damage)
        if rand < @deflect_percemtage
            puts "#{@name} deflects the attack."
        else
            @hitpoint -= damage
        end
    end
end
