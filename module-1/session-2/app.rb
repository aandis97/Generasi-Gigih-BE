require_relative 'hero'
require_relative 'ally'
require_relative 'mongol_villains'

jin = Hero.new("Jin Sakai", 100, 50)
yuna = Ally.new("Yuna", 90, 45)
sensei_ishikawa = Ally.new("Sensei Ishikawa", 80, 60)

mongol_acher = MongolArcher.new("Mongol Archer", 80, 40)
mongol_spearman = MongolSpearman.new("Mongol Archer", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)

villains = [mongol_acher, mongol_spearman, mongol_swordsman]

jin_teams = [jin, yuna, sensei_ishikawa]

i = 1;
until (jin.die? || villains.empty?) do
    puts "=========== Turn #{i} ==========="
    puts "\n"
    
    jin_teams.each do |jin_team|
        puts jin_team
    end
    puts "\n"

    villains.each do |villain|
        puts villain
    end
    puts "\n"

    puts "As #{jin.name}, what do you want to do this turn?"
    puts "1) Attact Ennemy \n"
    puts "2) Heal an ally \n"
    turn_number  = gets.chomp.to_i
    # puts "\n"

    if turn_number == 1
        puts "Which enemy you want to attack?"
        villains.each_with_index do |villain, index|
            puts "#{index+1}) #{villain.name} "
        end
        attact_number  = gets.chomp.to_i
        
        jin.attack(villains[attact_number-1])
    else
        if jin_teams.empty?
            puts "there is no ally to heal"
        else
            puts "Which ally you want to heal?"

            jin_teams.each_with_index do |jin_team, index|
                if jin_team.name!='Jin Sakai' 
                    puts "#{index+1}) #{jin_team.name} " 
                end
            end
            
            heal_number  = gets.chomp.to_i
            jin_teams[heal_number].healing(jin)
        end
    end
    jin_teams.each do |jin_team|        
        if jin_team.name!='Jin Sakai' 
            jin_team.attack(villains[rand(villains.size)])
        end
    end
    puts "\n"

    villains.each do |villain|
        villains.delete(villain) if villain.die? || villain.flee?
    end
    puts "\n"

    
    jin_teams.each do |jin_team|
        jin_team.delete(jin_team) if jin_team.die? 
    end
    puts "\n"

    
    villains.each do |villain|        
        villain.attack(jin_teams[rand(jin_teams.size)])
    end
    puts "\n"

    i+=1
end