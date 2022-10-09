class Computer
    include Color_Numbers
    include Play_Game
  
    attr_accessor :newGuess, :codeToCrack, :clues, :clues1, :clues2, :clues3, :cpuGuess1, :cpuGuess2, :cpuGuess3, :pos1, :pos2, :pos3, :pos4, :twoClueGuess, :twoClueGuess2, :oneClueGuess1, :oneClueGuess2, :last2, :i, :returnedClues, :randomPicks
    attr_reader :newGuess, :codeToCrack, :clues, :clues1, :clues2, :clues3, :cpuGuess1, :cpuGuess2, :cpuGuess3, :pos1, :pos2, :pos3, :pos4, :twoClueGuess, :twoClueGuess2, :oneClueGuess1, :oneClueGuess2, :last2, :i, :returnedClues, :randomPicks
  
  def pick_numbers
    @randomPicks = []
    i = 0
    until i == 4
      @randomPicks.push(rand(1..6).to_s)
      i += 1
    end
  end  

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
      puts add_color(@newGuess).join("") + " " + @returnedClues
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[0] = @twoClueGuess[0]
      @newGuess[1] = @last2[0]
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @twoClueGuess
      @newGuess.pop(2)
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[2] = @oneClueGuess1[0]
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess2.pop(2)
    @oneClueGuess2[2] = @oneClueGuess2[0]
    @oneClueGuess2[3] = @oneClueGuess2[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess2)

    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[0] = @twoClueGuess[0]
      @newGuess[1] = @last2[0]
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @twoClueGuess
      @newGuess.pop(2)
      @newGuess[2] = "0"
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[2] = @twoClueGuess2[0]
      @newGuess[3] = @last2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess[2] = @twoClueGuess2[0]
      @newGuess[3] = @twoClueGuess2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 4
      @newGuess = @threeClueGuess
      @newGuess.pop(2)
      @newGuess[2] = @last2[0]
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess.pop(2)
    @oneClueGuess[2] = @oneClueGuess[0]
    @oneClueGuess[3] = @oneClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess)
    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif return_clues(codeToCrack, @twoClueGuess).length == 8
      @newGuess = @twoClueGuess
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif return_clues(codeToCrack, @twoClueGuess).length == 6
      @newGuess = @twoClueGuess
      @newGuess.pop
      @newGuess[3] = "0"
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    end

    @last2 = @oneClueGuess.pop(2)
    @oneClueGuess[2] = @oneClueGuess[0]
    @oneClueGuess[3] = @oneClueGuess[0]

    @returnedClues = return_clues(codeToCrack, @oneClueGuess)
    if @returnedClues.length == 0
      @newGuess[3] = @last2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 2
      @newGuess[3] = @oneClueGuess[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
      puts "\n"
      sleep 0.25
    elsif @returnedClues.length == 6
      @newGuess = @threeClueGuess
      @newGuess[3] = @last2[0]
      puts add_color(@newGuess).join("") + " " + return_clues(codeToCrack, @newGuess)
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

    
  def order_clues(codeToCrack, newGuess)

    @initialWhiteClues = return_clues(codeToCrack, newGuess).count('●')

    @inputGuess = newGuess.dup

    newGuess[0] = @inputGuess[1]
    newGuess[1] = @inputGuess[0]
    # by swapping our first two digits we have a point of comparison
    newGuess[2] = '0'
    newGuess[3] = '0'
    # the last two digits are numbers which can't possibly return a clue
    # this gives us a better understanding of the clues which are returned from our swap

    @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

    if @initialWhiteClues == 4
      newGuess = @inputGuess

      puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
      puts "\n"
      sleep 0.25

    elsif @twoDigitWhiteClues == 2

      # after returning two white clues from the swap check if there were 0 clues pre-swap
      if @initialWhiteClues == 0
        # because there were 0 clues pre-swap and we have two guaranteed clues in the first half, we can assume that the back half needs to be swapped too
        newGuess[2] = @inputGuess[3]
        newGuess[3] = @inputGuess[2]
                
        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        puts "\n"
        sleep 0.25

      end

      # there can't possibly be a case for @initialWhiteClues == 1 if our swap returns two clues

      if @initialWhiteClues == 2
        # there were two white clues prior to the swap but the swap still returned two white clues
        # this means the back half of the original guess was correct and now our front half is correct too
        newGuess[2] = @inputGuess[2]
        newGuess[3] = @inputGuess[3]

        @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        puts "\n"
        sleep 0.25

        if @twoDigitWhiteClues == 2
          newGuess[2] = @inputGuess[3]
          newGuess[3] = @inputGuess[2]
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

        end
      end

    elsif @twoDigitWhiteClues == 1

      if @initialWhiteClues == 0
        newGuess[0] = @inputGuess[2]

        @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

        newGuess[2] = "0"
        newGuess[3] = "0"
        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        newGuess.pop(2)
        puts "\n"
        sleep 0.25

        if @twoDigitWhiteClues == 0
          newGuess[0] = @inputGuess[1]
          newGuess[1] = @inputGuess[2]

          @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if @twoDigitWhiteClues == 0
            newGuess[0] = @inputGuess[1]
            newGuess[1] = @inputGuess[2]

            @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

            newGuess[2] = "0"
            newGuess[3] = "0"
            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            newGuess.pop(2)
            puts "\n"
            sleep 0.25

            if @twoDigitWhiteClues == 2
              newGuess[2] = @inputGuess[0]
              newGuess[3] = @inputGuess[3]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

              if return_clues(codeToCrack, newGuess).count('●') == 2
                newGuess[2] = @inputGuess[3]
                newGuess[3] = @inputGuess[0]

                puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
                puts "\n"
                sleep 0.25

              end
            end

          elsif @twoDigitWhiteClues == 1
            newGuess[0] = @inputGuess[1]
            newGuess[1] = @inputGuess[3]
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[0] = @inputGuess[1]
              newGuess[1] = @inputGuess[3]
              newGuess[2] = @inputGuess[2]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25
              
            end

          elsif @twoDigitWhiteClues == 2
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[3]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[3]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end
          end

        elsif @twoDigitWhiteClues == 1
          newGuess[0] = @inputGuess[3]

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[1]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[2]
              newGuess[3] = @inputGuess[1]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end
          end

        elsif @twoDigitWhiteClues == 2
          newGuess[2] = @inputGuess[3]
          newGuess[3] = @inputGuess[1]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

        end

      elsif @initialWhiteClues == 1
        # there has to be one clue in either half
        newGuess[0] = @inputGuess[2]

        newGuess[2] = "0"
        newGuess[3] = "0"
        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        newGuess.pop(2)
        puts "\n"
        sleep 0.25

        if return_clues(codeToCrack, newGuess).count('●') == 0
          newGuess[0] = @inputGuess[1]
          newGuess[1] = @inputGuess[2]

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 1
            newGuess[1] = @inputGuess[3]
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[2]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end

          elsif return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[3]
            newGuess[3] = @inputGuess[0]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[0]
              newGuess[3] = @inputGuess[3]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25
              
            end
          end

        elsif return_clues(codeToCrack, newGuess).count('●') == 1
          newGuess[0] = @inputGuess[3]
          newGuess[2] = @inputGuess[1]
          newGuess[3] = @inputGuess[2]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[0] = @inputGuess[3]
            newGuess[2] = @inputGuess[2]
            newGuess[3] = @inputGuess[1]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

          end

        elsif return_clues(codeToCrack, newGuess).count('●') == 2
          newGuess[2] = @inputGuess[1]
          newGuess[3] = @inputGuess[3]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[3]
            newGuess[3] = @inputGuess[1]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

          end
        end
      elsif @initialWhiteClues == 2
        newGuess[0] = @inputGuess[2]

        @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

        newGuess[2] = "0"
        newGuess[3] = "0"
        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        newGuess.pop(2)
        puts "\n"
        sleep 0.25

        if @twoDigitWhiteClues == 0
          newGuess[0] = @inputGuess[1]
          newGuess[1] = @inputGuess[2]

          @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if @twoDigitWhiteClues == 2
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[3]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[3]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end

          elsif @twoDigitWhiteClues == 1
            newGuess[1] = @inputGuess[3]
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[2]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end
          end

        elsif @twoDigitWhiteClues == 1
          newGuess[0] = @inputGuess[3]
          newGuess[1] = @inputGuess[0]
          newGuess[2] = @inputGuess[2]
          newGuess[3] = @inputGuess[1]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[1]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[0] = @inputGuess[0]
              newGuess[1] = @inputGuess[3]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end
          end

        elsif @twoDigitWhiteClues == 2
          newGuess[2] = @inputGuess[0]
          newGuess[3] = @inputGuess[3]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[3]
            newGuess[3] = @inputGuess[0]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

          end
        end
      end

    elsif @twoDigitWhiteClues == 0
      # as both combinations of the first two digits returned no clues we can assume that the halves need to be swapped
      # by swapping the halves and creating conditionals for each possiblity we can crack our code

      if @initialWhiteClues == 0

        newGuess[0] = @inputGuess[2]
        newGuess[1] = @inputGuess[3]
        newGuess[2] = @inputGuess[0]
        newGuess[3] = @inputGuess[1]

        @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        puts "\n"
        sleep 0.25

        if @twoDigitWhiteClues == 0
          # if 0 is returned again we can assume that each halve needs its digits swapped to crack the code
          newGuess[0] = @inputGuess[3]
          newGuess[1] = @inputGuess[2]
          newGuess[2] = @inputGuess[1]
          newGuess[3] = @inputGuess[0]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

        elsif @twoDigitWhiteClues == 2
          # if 2 is returned we can try swapping the digits of just one half
          newGuess[0] = @inputGuess[2]
          newGuess[1] = @inputGuess[3]
          newGuess[2] = @inputGuess[1]
          newGuess[3] = @inputGuess[0]
          @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')
          
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25
          
          if @twoDigitWhiteClues == 0
            # if 0 is returned again we can swap the digits of the other half to get our answer
            newGuess[0] = @inputGuess[3]
            newGuess[1] = @inputGuess[2]
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[1]
            
            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25
            
          elsif @twoDigitWhiteClues == 2
            newGuess[0] = @inputGuess[3]
            newGuess[1] = @inputGuess[2]
            
            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25
            
          end
        end
        
      elsif @initialWhiteClues == 1
        # we lost a clue due to the swap, swap them back and swap a digit from the first half with one from the second half
        
        newGuess[0] = @inputGuess[2]
        newGuess[1] = @inputGuess[1]
        
        @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')
        
        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)

        puts "\n"
        sleep 0.25
        
        if @twoDigitWhiteClues == 2
          # we found the correct combination for the first half, guess the second half with the remaining digits
          newGuess[2] = @inputGuess[0]
          newGuess[3] = @inputGuess[3]

          @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if @twoDigitWhiteClues == 2
            # swap the second half digits if we are still returning 2 clues from our correct second half
            newGuess[2] = @inputGuess[3]
            newGuess[3] = @inputGuess[0]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

          end

        elsif @twoDigitWhiteClues == 1
          newGuess[0] = @inputGuess[3]
          newGuess[1] = @inputGuess[1]

          @twoDigitWhiteClues = return_clues(codeToCrack, newGuess).count('●')

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if @twoDigitWhiteClues == 0
            newGuess[0] = @inputGuess[2]
            newGuess[1] = @inputGuess[0]
            newGuess[2] = @inputGuess[3]
            newGuess[3] = @inputGuess[1]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[0] = @inputGuess[2]
              newGuess[1] = @inputGuess[0]
              newGuess[2] = @inputGuess[1]
              newGuess[3] = @inputGuess[3]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end

          elsif @twoDigitWhiteClues == 2
            newGuess[2] = @inputGuess[0]
            newGuess[3] = @inputGuess[2]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[2]
              newGuess[3] = @inputGuess[0]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end

          end

        elsif @twoDigitWhiteClues == 0
          newGuess[0] = @inputGuess[0]
          newGuess[1] = @inputGuess[2]

          newGuess[2] = "0"
          newGuess[3] = "0"
          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          newGuess.pop(2)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') == 2
            newGuess[2] = @inputGuess[1]
            newGuess[3] = @inputGuess[3]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[3]
              newGuess[3] = @inputGuess[1]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end

          elsif return_clues(codeToCrack, newGuess).count('●') == 1
            newGuess[1] = @inputGuess[3]
            newGuess[2] = @inputGuess[2]
            newGuess[3] = @inputGuess[1]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') == 2
              newGuess[2] = @inputGuess[1]
              newGuess[3] = @inputGuess[2]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

            end
          end
        end

      elsif @initialWhiteClues == 2
        # these nested conditionals contain every combination of swapping 2 digits
        newGuess = @inputGuess.dup
        newGuess[2] = @inputGuess[3]
        newGuess[3] = @inputGuess[2]

        puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
        puts "\n"
        sleep 0.25

        if return_clues(codeToCrack, newGuess).count('●') != 4
          newGuess = @inputGuess.dup
          newGuess[0] = @inputGuess[2]
          newGuess[2] = @inputGuess[0]

          puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
          puts "\n"
          sleep 0.25

          if return_clues(codeToCrack, newGuess).count('●') != 4
            newGuess = @inputGuess.dup
            newGuess[0] = @inputGuess[3]
            newGuess[3] = @inputGuess[0]

            puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
            puts "\n"
            sleep 0.25

            if return_clues(codeToCrack, newGuess).count('●') != 4
              newGuess = @inputGuess.dup
              newGuess[1] = @inputGuess[2]
              newGuess[2] = @inputGuess[1]

              puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
              puts "\n"
              sleep 0.25

              if return_clues(codeToCrack, newGuess).count('●') != 4
                newGuess = @inputGuess.dup
                newGuess[1] = @inputGuess[3]
                newGuess[3] = @inputGuess[1]

                puts add_color(newGuess).join("") + " " + return_clues(codeToCrack, newGuess)
                puts "\n"
                sleep 0.25

              end
            end
          end
        end

      end

    end
    
    if return_clues(codeToCrack, newGuess).count('●') == 4
      puts "The CPU cracked your code!".green
    end

    newGuess
  end

  def initialize_game(playerCode)
    @codeToCrack = playerCode
    
    puts "\n"
    puts 'You have entered the code '.bold + add_color(@codeToCrack).join("") + "for the CPU to crack".bold
    sleep 0.5
    puts "\n"
    sleep 0.25

    @cpuGuess1 = %w[1 1 2 2]
    @clues1 = return_clues(@codeToCrack, @cpuGuess1)
    puts add_color(@cpuGuess1).join("") + " " + @clues1

    if @clues1.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!".green
      return
    end

    puts "\n"
    sleep 0.25

    @cpuGuess2 = %w[3 3 4 4]
    @clues2 = return_clues(@codeToCrack, @cpuGuess2)
    puts add_color(@cpuGuess2).join("") + " " + @clues2

    if @clues2.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!".green
      return
    end

    puts "\n"
    sleep 0.25

    @cpuGuess3 = %w[5 5 6 6]
    @clues3 = return_clues(@codeToCrack, @cpuGuess3)
    puts add_color(@cpuGuess3).join("") + " " + @clues3

    if @clues3.count('●') == 4
      puts "\n"
      puts "The CPU cracked your code!".green
      return
    end

    puts "\n"
    sleep 0.25

    @newGuess = check_result(@codeToCrack, @clues1, @clues2, @clues3, @cpuGuess1, @cpuGuess2, @cpuGuess3)

  end
end
