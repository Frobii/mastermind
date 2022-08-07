require "colorize" # a ruby gem which allows color to be output in the terminal

module Color_Numbers
    def add_color(array)
        array.map! { |number|
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

class Computer
    include Color_Numbers

    attr_reader :randomPicks
    attr_writer :randomPicks

    def pick_numbers()
        @randomPicks = []
        i = 0
        until i == 6
            @randomPicks.push(rand(1..6).to_s)
            i += 1
        end
    end

end


computer = Computer.new

computer.pick_numbers()

roundPicks = computer.add_color(computer.randomPicks)

puts roundPicks.join("")