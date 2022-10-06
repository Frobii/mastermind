class Computer
    include Color_Numbers
    include Play_Game
  
    attr_accessor :randomPicks
    attr_reader :randomGuess
  
    def pick_numbers
      @randomPicks = []
      i = 0
      until i == 4
        @randomPicks.push(rand(1..6).to_s)
        i += 1
      end
    end
  
    def random_guess
      @randomGuess = []
  
      @randomGuess.push(rand(1..6).to_s) until @randomGuess.length == 4
  
      @randomGuess
    end
  
    def re_guess
      @reGuess = []
  
      @reGuess.push(rand(1..6).to_s) - @randomGuess until @reGuess.length == 4
  
      @reGuess
    end
  
    def decrementRandom(array)
      case array.length
      when 4
        rand(0..3)
      when 3
        rand(0..2)
      when 2
        rand(0..1)
      end
    end
  
    def fillGuess(guess, deletions)
      guess = guess.push(rand(1..6).to_s) - deletions until guess.length == 4
      p guess
    end
  
    # replaces incorrect characters & positions with new numbers
    def check_guess(guess, clues)
      deleteArray = []
  
      correctPositions = clues.count('●')
      correctCharacters = clues.count('○')
      correctTotal = correctCharacters + correctPositions
  
      i = 0
  
      until i == 4 - correctTotal
        deleteArray.push(guess.pop)
        i += 1
      end
  
      fillGuess(guess, deleteArray)
  
      guess
    end
end