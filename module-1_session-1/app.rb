
require_relative 'person'


jin = Person.new("Jin Sakai", 100, 50, 80)
khotun = Person.new("Khotun Khan", 500, 50)

loop do
    jin.attack(khotun)
    puts khotun
    puts "\n"
    break if khotun.die?
    
    khotun.attack(jin)
    puts jin
    puts "\n"
    break if jin.die?
end

    