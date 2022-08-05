class Computer
attr_reader :randomPicks

    def pick_numbers()
        @randomPicks = []
        i = 0
        until i == 6
            @randomPicks.push(rand(1..6))
            i += 1
        end
    end
            
end


computer = Computer.new

computer.pick_numbers()


p computer.randomPicks