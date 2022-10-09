module Color_Numbers
    def add_color(array)
        array.map do |number|
        case number
            when '0'
                "#{number.light_blue} "
            when '1'
                "#{number.red} " # add spaces to make the output easier to read
            when '2'
                "#{number.cyan} "
            when '3'
                "#{number.yellow} "
            when '4'
                "#{number.blue} "
            when '5'
                "#{number.green} "
            when '6'
                "#{number.magenta} "
            end
        end
    end
end