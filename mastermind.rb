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
    attr_reader :guess

    def play_round(solution)
        puts "Enter four numbers between 1-6:"
        @guess = gets.chomp.to_s.split("")
        puts "\n"

        if @guess.join.to_i >= 7000 || @guess.join.to_i < 1000
            puts "\n"
            puts "Invalid Input".red
            puts "\n"
            play_round(solution)
            return
        end

        clues = ""
        i = 0
        
        until i == 4
            if solution[i] == @guess[i] # checks for the right number in the right position
                clues += "● "
            elsif solution[0] == @guess[i] && @guess[0] != solution[0]  # checks for the right number in the wrong position
                clues += "○ "
            elsif solution[1] == @guess[i] && @guess[1] != solution[1]
                clues += "○ "
            elsif solution[2] == @guess[i] && @guess[2] != solution[2]
                clues += "○ "
            elsif solution[3] == @guess[i] && @guess[3] != solution[3]
                clues += "○ "
            end

            i += 1

            if i == 4 # on the last iteration, print the result of the @guess
                puts clues
                return clues
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

    def random_guess()
        @randomGuess = []
        i = 0
        until i == 4
            @randomGuess.push(rand(1..6).to_s)
            i += 1
        end
        return @randomGuess
    end

end

class Player
    include Play_Game
    include Color_Numbers
end


def player_vs_computer()
    player1 = Player.new
    computer = Computer.new

    computer.pick_numbers()
    computerSolution = computer.randomPicks

    i = 1
    until i == 13
        puts "Guess #{i} / 12".green
        if player1.play_round(computerSolution) == "● ● ● ● "
            puts "\n"
            puts player1.add_color(player1.guess).join("")
            puts "\n"
            puts "You cracked the code!".green
            break
        end
        puts "\n"
        puts player1.add_color(player1.guess).join("")
        puts "\n"
        if i == 12
            puts "You couldn't crack the code in time.".red
        end
        i += 1
    end

end

player_vs_computer()