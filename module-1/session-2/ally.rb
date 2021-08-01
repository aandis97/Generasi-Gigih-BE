require_relative 'person'

class Ally < Person
    def initialize(name, hitpoint, attack_damage)
        super(name, hitpoint, attack_damage)
        @heal_point = 20
    end

    def healing(healing_person)
        @hitpoint += @heal_point 
        puts "#{healing_person.name} heals #{name}, restoring  #{heal_point} hitpoint"
    end

end