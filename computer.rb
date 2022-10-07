class Computer
    include Color_Numbers
    include Play_Game
  
    attr_accessor :newGuess, :codeToCrack, :clues, :clues1, :clues2, :clues3, :cpuGuess1, :cpuGuess2, :cpuGuess3, :pos1, :pos2, :pos3, :pos4, :twoClueGuess, :twoClueGuess2, :oneClueGuess1, :oneClueGuess2, :last2, :i, :returnedClues
    attr_reader :newGuess, :codeToCrack, :clues, :clues1, :clues2, :clues3, :cpuGuess1, :cpuGuess2, :cpuGuess3, :pos1, :pos2, :pos3, :pos4, :twoClueGuess, :twoClueGuess2, :oneClueGuess1, :oneClueGuess2, :last2, :i, :returnedClues
  
  def return_clues(solution, guess)
    @clues = ''
    @pos1 = false # these are used to ensure that a correct number doesn't add multiple black clues
    @pos2 = false
    @pos3 = false
    @pos4 = false
    @i = 0
    until @i == 4
      if solution[i] == guess[i]
        @clues += '● ' # checks for the right number in the right position
      elsif solution[0] == guess[i] && guess[0] != solution[0] && @pos1 == false
        @clues += '○ '
        @pos1 = true
      elsif solution[1] == guess[i] && guess[1] != solution[1] && @pos2 == false
        @clues += '○ '
        @pos2 = true
      elsif solution[2] == guess[i] && guess[2] != solution[2] && @pos3 == false
        @clues += '○ '
        @pos3 = true
      elsif solution[3] == guess[i] && guess[3] != solution[3] && @pos4 == false
        @clues += '○ ' # checks for the right number in the wrong position
        @pos4 = true
      end
      @i += 1
    end
    @clues
  end

  def two_one_one(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    # we must find our two clue variable
    if clues1.length == 4
      @twoClueGuess = cpuGuess1.dup
    elsif clues2.length == 4
      @twoClueGuess = cpuGuess2.dup
    elsif clues3.length == 4
      @twoClueGuess = cpuGuess3.dup
    end

    # we must find both one clue variables
    if clues1.length == 2
      @oneClueGuess1 = cpuGuess1.dup
      clues1 = []
    # making our clues include nothing makes it so the next conditional won't assign a variable to it again
    elsif clues2.length == 2
      @oneClueGuess1 = cpuGuess2.dup
      clues2 = []
    elsif clues3.length == 2
      @oneClueGuess1 = cpuGuess3.dup
      clues3 = []
    end

    if clues1.length == 2
      @oneClueGuess2 = cpuGuess1.dup
    elsif clues2.length == 2
      @oneClueGuess2 = cpuGuess2.dup
    elsif clues3.length == 2
      @oneClueGuess2 = cpuGuess3.dup
    end
  end

  # a method for finding all four clues when one guess returns two clues and the others return one
  def two_one_one(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    # we must find our two clue variable
    if clues1.length == 4
      @twoClueGuess = cpuGuess1.dup
    elsif clues2.length == 4
      @twoClueGuess = cpuGuess2.dup
    elsif clues3.length == 4
      @twoClueGuess = cpuGuess3.dup
    end

    # we must find both one clue variables
    if clues1.length == 2
      @oneClueGuess1 = cpuGuess1.dup
      clues1 = []
    # making our clues include nothing makes it so the next conditional won't assign a variable to it again
    elsif clues2.length == 2
      @oneClueGuess1 = cpuGuess2.dup
      clues2 = []
    elsif clues3.length == 2
      @oneClueGuess1 = cpuGuess3.dup
      clues3 = []
    end

    if clues1.length == 2
      @oneClueGuess2 = cpuGuess1.dup
    elsif clues2.length == 2
      @oneClueGuess2 = cpuGuess2.dup
    elsif clues3.length == 2
      @oneClueGuess2 = cpuGuess3.dup
    end

    # we need to check which half of the guess is giving us 2 clues, or if it's a combination of both
    @last2 = @twoClueGuess.pop(2)
    @twoClueGuess[2] = @twoClueGuess[0]
    @twoClueGuess[3] = @twoClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @twoClueGuess)
    # assign the two guaranteed clues to the @newGuess which we will eventually return with 4 guaranteed clues
    if @returnedClues.length == 0
      @newGuess = @last2.dup
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + @returnedClues
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[0] = @twoClueGuess[0]
      @newGuess[1] = @last2[0]
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @twoClueGuess
      @newGuess.pop(2)
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    # do the same thing with our one clue guesses to figure out which half of it is correct
    @last2 = @oneClueGuess1.pop(2)
    @oneClueGuess1[2] = @oneClueGuess1[0]
    @oneClueGuess1[3] = @oneClueGuess1[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess1)
    # add just one digit to @newGuess as we only have one correct clue here
    if @returnedClues.length == 0
      @newGuess[2] = @last2[0]
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[2] = @oneClueGuess1[0]
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess2.pop(2)
    @oneClueGuess2[2] = @oneClueGuess2[0]
    @oneClueGuess2[3] = @oneClueGuess2[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess2)

    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    return @newGuess
  end


  def two_two_zero(codeToCrack, clues1, clues2, clues3,  cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    # find both guesses with two clues to start our comparisons
    if clues1.length == 4
      @twoClueGuess = cpuGuess1.dup
      clues1 = [] # ensures the same guess isn't assigned twice in the next conditional
    elsif clues2.length == 4
      @twoClueGuess = cpuGuess2.dup
      clues2 = []
    elsif clues3.length == 4
      @twoClueGuess = cpuGuess3.dup
      clues3 = []
    end

    if clues1.length == 4
      @twoClueGuess2 = cpuGuess1.dup
    elsif clues2.length == 4
      @twoClueGuess2 = cpuGuess2.dup
    elsif clues3.length == 4
      @twoClueGuess2 = cpuGuess3.dup
    end

    @last2 = @twoClueGuess.pop(2)
    @twoClueGuess[2] = @twoClueGuess[0]
    @twoClueGuess[3] = @twoClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @twoClueGuess)
    if @returnedClues.length == 0
      @newGuess = @last2.dup
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[0] = @twoClueGuess[0]
      @newGuess[1] = @last2[0]
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @twoClueGuess
      @newGuess.pop(2)
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @twoClueGuess2.pop(2)
    @twoClueGuess2[2] = @twoClueGuess2[0]
    @twoClueGuess2[3] = @twoClueGuess2[0]

    @returnedClues = return_clues(codeToCrack, @twoClueGuess2)
    if @returnedClues.length == 0
      @newGuess[2] = @last2[0]
      @newGuess[3] = @last2[1]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[2] = @twoClueGuess2[0]
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess[2] = @twoClueGuess2[0]
      @newGuess[3] = @twoClueGuess2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    return @newGuess
  end

  def three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    if clues1.length == 6
      @threeClueGuess = cpuGuess1.dup
    elsif clues2.length == 6
      @threeClueGuess = cpuGuess2.dup
    elsif clues3.length == 6
      @threeClueGuess = cpuGuess3.dup
    end

    if clues1.length == 2
      @oneClueGuess = cpuGuess1.dup
    elsif clues2.length == 2
      @oneClueGuess = cpuGuess2.dup
    elsif clues3.length == 2
      @oneClueGuess = cpuGuess3.dup
    end

    @last2 = @threeClueGuess.pop(2)
    @threeClueGuess[2] = @threeClueGuess[0]
    @threeClueGuess[3] = @threeClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @threeClueGuess)
    if @returnedClues.length == 2
      @newGuess = @last2.dup
      @newGuess[2] = @threeClueGuess[0]
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @threeClueGuess
      @newGuess.pop(2)
      @newGuess[2] = @last2[0]
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess.pop(2)
    @oneClueGuess[2] = @oneClueGuess[0]
    @oneClueGuess[3] = @oneClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess)
    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end
    return @newGuess
  end

  def two_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    if clues1.length == 4
      @twoClueGuess = cpuGuess1.dup
    elsif clues2.length == 4
      @twoClueGuess = cpuGuess2.dup
    elsif clues3.length == 4
      @twoClueGuess = cpuGuess3.dup
    end

    @last2 = @twoClueGuess.pop(2)
    @twoClueGuess[2] = @twoClueGuess[0]
    @twoClueGuess[3] = @twoClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @twoClueGuess)
    if return_clues(codeToCrack, @twoClueGuess).length == 0
      @newGuess = @last2
      @newGuess[2] = @last2[0]
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif return_clues(codeToCrack, @twoClueGuess).length == 8
      @newGuess = @twoClueGuess
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end
    return @newGuess
  end

  def two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []

    if clues1.length == 4
      @twoClueGuess = cpuGuess1.dup
    elsif clues2.length == 4
      @twoClueGuess = cpuGuess2.dup
    elsif clues3.length == 4
      @twoClueGuess = cpuGuess3.dup
    end

    if clues1.length == 2
      @oneClueGuess = cpuGuess1.dup
    elsif clues2.length == 2
      @oneClueGuess = cpuGuess2.dup
    elsif clues3.length == 2
      @oneClueGuess = cpuGuess3.dup
    end

    @last2 = @twoClueGuess.pop(2)
    @twoClueGuess[2] = @twoClueGuess[0]
    @twoClueGuess[3] = @twoClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @twoClueGuess)
    if @returnedClues.length == 0
      @newGuess = @last2
      @newGuess[2] = @last2[0]
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif return_clues(codeToCrack, @twoClueGuess).length == 6
      @newGuess = @twoClueGuess
      @newGuess.pop
      @newGuess[3] = "0"
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess.pop(2)
    @oneClueGuess[2] = @oneClueGuess[0]
    @oneClueGuess[3] = @oneClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess)
    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end
    return @newGuess
  end


  def three_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    @newGuess = []
  
    if clues1.length == 6
      @threeClueGuess = cpuGuess1.dup
    elsif clues2.length == 6
      @threeClueGuess = cpuGuess2.dup
    elsif clues3.length == 6
      @threeClueGuess = cpuGuess3.dup
    end
  
    @last2 = @threeClueGuess.pop(2)
    @threeClueGuess[2] = @threeClueGuess[0]
    @threeClueGuess[3] = @threeClueGuess[0]
  
    @returnedClues = return_clues(codeToCrack, @threeClueGuess)
    if @returnedClues.length == 2
      @newGuess = @last2
      @newGuess[2] = @last2[0]
      @newGuess[3] = @threeClueGuess[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 6
      @newGuess = @threeClueGuess
      @newGuess[3] = @last2[0]
      puts @newGuess.join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end
    return @newGuess
  end

  # a huge conditional is used to check the result of the first 3 guesses in order to assign the corresponding method which solves the code
  def check_result(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    if clues1.length == 4 && clues2.length == 2 && clues3.length == 2
      @newGuess = two_one_one(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 4 && clues3.length == 2
      @newGuess = two_one_one(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 2 && clues3.length == 4
      @newGuess = two_one_one(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 4 && clues2.length == 4 && clues3.length == 0
      @newGuess = two_two_zero(codeToCrack, clues1, clues2, clues3,  cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 4 && clues2.length == 0 && clues3.length == 4
      @newGuess = two_two_zero(codeToCrack, clues1, clues2, clues3,  cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 4 && clues3.length == 4
      @newGuess = two_two_zero(codeToCrack, clues1, clues2, clues3,  cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 6 && clues2.length == 2 && clues3.length == 0
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 6 && clues2.length == 0 && clues3.length == 2
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 6 && clues3.length == 0
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 0 && clues3.length == 6
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 6 && clues3.length == 2
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 2 && clues3.length == 6
      @newGuess = three_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 4 && clues2.length == 0 && clues3.length == 0
      @newGuess = two_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 4 && clues3.length == 0
      @newGuess = two_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 0 && clues3.length == 4
      @newGuess = two_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 4 && clues2.length == 2 && clues3.length == 0
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 4 && clues2.length == 0 && clues3.length == 2
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 4 && clues3.length == 0
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 2 && clues2.length == 0 && clues3.length == 4
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 4 && clues3.length == 2
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 2 && clues3.length == 4
      @newGuess = two_one_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 6 && clues2.length == 0 && clues3.length == 0
      @newGuess = three_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 6 && clues3.length == 0
      @newGuess = three_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)
    elsif clues1.length == 0 && clues2.length == 0 && clues3.length == 6
      @newGuess = three_zero_zero(codeToCrack, clues1, clues2, clues3, cpuGuess1, cpuGuess2, cpuGuess3)

    elsif clues1.length == 8
      @newGuess = cpuGuess1
    elsif clues2.length == 8
      @newGuess = cpuGuess2
    elsif clues3.length == 8
      @newGuess = cpuGuess3
    end
  end

  def initialize_game(playerCode)
    @codeToCrack = playerCode
    
    puts "\n"
    puts 'code to crack: ' + @codeToCrack.join("")
    sleep 0.5
    puts "\n"
    sleep 0.25

    @cpuGuess1 = %w[1 1 2 2]
    @clues1 = return_clues(@codeToCrack, @cpuGuess1)
    puts @cpuGuess1.join("") + " " + @clues1

    if @clues1.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!"
      return
    end

    puts "\n"
    sleep 0.25

    @cpuGuess2 = %w[3 3 4 4]
    @clues2 = return_clues(@codeToCrack, @cpuGuess2)
    puts cpuGuess2.join("") + " " + @clues2

    if @clues2.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!"
      return
    end

    puts "\n"
    sleep 0.25

    @cpuGuess3 = %w[5 5 6 6]
    @clues3 = return_clues(@codeToCrack, @cpuGuess3)
    puts @cpuGuess3.join("") + " " + @clues3


    if @clues3.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!"
      return
    end

    puts "\n"
    sleep 0.25

    @newGuess = check_result(@codeToCrack, @clues1, @clues2, @clues3, @cpuGuess1, @cpuGuess2, @cpuGuess3)

  end
end


# STILL NEED TO ADD ORDER_CLUES FROM v2cpu.rb
