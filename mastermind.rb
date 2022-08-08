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

        i = 0
        until i == 4
            if solution[i] == guess[i] # checks for the right number in the right position
                clues += "● "
            end

            i += 1

            if i == 4 # on the last iteration, print the result of the guess
                puts clues
            end
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