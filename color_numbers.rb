module Color_Numbers
    def add_color(array)
        array.map do |number|
        case number
            when '1'
                "#{number.red} " # add spaces to make the output easier to read
            when '2'
                "#{number.yellow} "
            when '3'
                "#{number.blue} "
            when '4'
                "#{number.green} "
            when '5'
                "#{number.cyan} "
            when '6'
                "#{number.magenta} "
            end
        end
    end
end