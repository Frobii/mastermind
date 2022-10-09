module Play_Game
    attr_reader :guess, :clues, :pos1, :pos2, :pos3, :pos4
  
    def human_play(solution)
      puts 'Enter four numbers between 1-6:'
      @guess = gets.chomp.to_s.split('')
      puts "\n"
  
      if @guess.join.to_i >= 7000 || @guess.join.to_i < 1000
        puts "\n"
        puts 'Invalid Input'.red
        puts "\n"
        human_play(solution)
        return
      end
  
      @clues = ''
      @pos1 = false # these are used to ensure that a correct number doesn't add multiple black clues
      @pos2 = false
      @pos3 = false
      @pos4 = false
  
      i = 0
      until i == 4
        if solution[i] == guess[i] # checks for the right number in the right position
          @clues += '● '
        elsif solution[0] == guess[i] && guess[0] != solution[0] && @pos1 == false # checks for the right number in the wrong position
          @clues += '○ '
          @pos1 = true
        elsif solution[1] == guess[i] && guess[1] != solution[1] && @pos2 == false
          @clues += '○ '
          @pos2 = true
        elsif solution[2] == guess[i] && guess[2] != solution[2] && @pos3 == false
          @clues += '○ '
          @pos3 = true
        elsif solution[3] == guess[i] && guess[3] != solution[3] && @pos4 == false
          @clues += '○ '
          @pos4 = true
        end
  
        i += 1
  
        if i == 4 # on the last iteration, print the result of the @guess
          puts @clues
          return @clues
        end
      end
    end
  
    def computer_play(solution, guess)
      puts "\n"
  
      if guess.join.to_i >= 7000 || guess.join.to_i < 1000
        puts "\n"
        puts 'Invalid Input'.red
        puts "\n"
        human_play(solution)
        return
      end
  
      @clues = ''
      @pos1 = false
      @pos2 = false
      @pos3 = false
      @pos4 = false
  
      i = 0
      until i == 4
        if solution[i] == guess[i]
          @clues += '● '
        elsif solution[0] == guess[i] && guess[0] != solution[0] && @pos1 == false
          @clues += '○ '
        elsif solution[1] == guess[i] && guess[1] != solution[1] && @pos2 == false
          @clues += '○ '
        elsif solution[2] == guess[i] && guess[2] != solution[2] && @pos3 == false
          @clues += '○ '
        elsif solution[3] == guess[i] && guess[3] != solution[3] && @pos4 == false
          @clues += '○ '
        end
  
        i += 1
  
        if i == 4 # on the last iteration, print the result of the @guess
          puts @clues
          return @clues
        end
      end
    end
end