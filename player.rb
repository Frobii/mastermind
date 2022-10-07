class Player
    include Play_Game
    include Color_Numbers
  
    attr_reader :playerCode
  
    def create_code
      puts 'Enter a four digit code of numbers 1-6 for the computer to crack: '
      @playerCode = gets.chomp.to_s.split('')
  
      if @playerCode.join.to_i >= 7000 || @playerCode.join.to_i < 1111 || @playerCode[1].to_i > 6
        puts "\n"
        puts 'Invalid Input'.red
        puts "\n"
        create_code()
      end
  
      @playerCode
    end
end