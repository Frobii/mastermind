require "colorize" # a ruby gem which simplifies making terminal text colored

module Color_Numbers
    def add_color(array)
        array.map { |number|
            if number == "1"
                number.red + " " # add spaces to make the output easier to read
            elsif number == "2"
                number.yellow + " "
            elsif number == "3"
                number.blue + " "
            elsif number == "4"
                number.green + " "
            elsif number == "5"
                number.cyan + " "
            elsif number == "6"
                number.magenta + " "
            end
        }
    end
end

module Play_Game
    def play_round(solution)
        puts "Enter four numbers:"
        guess = gets.chomp.to_s.split("")

        clues = "Clues: "

        if (solution - guess).length == 3
            puts clues + "●"
        elsif (solution - guess).length == 2
            puts clues + "● ●"
        elsif (solution - guess).length == 1
            puts clues + "● ● ●"
        elsif (solution - guess).length == 0
            puts "The code has been cracked!"
        end

    end

end

class Computer
    include Color_Numbers

    attr_reader :randomPicks
    attr_writer :randomPicks

    def pick_numbers()
        @randomPicks = []
        i = 0
        until i == 4
            @randomPicks.push(rand(1..6).to_s)
            i += 1
        end
    end

end

class Player
    include Play_Game
end


computer = Computer.new

computer.pick_numbers()

computerSolution = computer.randomPicks # used for the play_round method

puts computer.add_color(computer.randomPicks).join("")


player1 = Player.new

player1.play_round(computerSolution)