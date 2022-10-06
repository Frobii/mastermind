# frozen_string_literal: true

require 'colorize' # a ruby gem which simplifies making terminal text colored

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

module Play_Game
  attr_reader :guess, :clues

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
    i = 0

    until i == 4
      if solution[i] == @guess[i] # checks for the right number in the right position
        @clues += '● '
      elsif solution[0] == @guess[i] && @guess[0] != solution[0] # checks for the right number in the wrong position
        @clues += '○ '
      elsif solution[1] == @guess[i] && @guess[1] != solution[1]
        @clues += '○ '
      elsif solution[2] == @guess[i] && @guess[2] != solution[2]
        @clues += '○ '
      elsif solution[3] == @guess[i] && @guess[3] != solution[3]
        @clues += '○ '
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
    i = 0

    until i == 4
      if solution[i] == guess[i] # checks for the right number in the right position
        @clues += '● '
      elsif solution[0] == guess[i] && guess[0] != solution[0] # checks for the right number in the wrong position
        @clues += '○ '
      elsif solution[1] == guess[i] && guess[1] != solution[1]
        @clues += '○ '
      elsif solution[2] == guess[i] && guess[2] != solution[2]
        @clues += '○ '
      elsif solution[3] == guess[i] && guess[3] != solution[3]
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

class Player
  include Play_Game
  include Color_Numbers

  attr_reader :playerCode

  def create_code
    puts 'Enter a four digit code of numbers 1-6 for the computer to crack: '
    @playerCode = gets.chomp.to_s.split('')

    if @playerCode.join.to_i >= 7000 || @playerCode.join.to_i < 1111
      puts "\n"
      puts 'Invalid Input'.red
      puts "\n"
      create_code
      return
    end

    @playerCode
  end
end

def player_vs_computer
  player1 = Player.new
  computer = Computer.new

  computer.pick_numbers
  computerSolution = computer.randomPicks

  i = 1
  until i == 13
    puts "Guess #{i} / 12".green
    if player1.human_play(computerSolution) == '● ● ● ● '
      puts "\n"
      puts player1.add_color(player1.guess).join('')
      puts "\n"
      puts 'You cracked the code!'.green
      break
    end
    puts "\n"
    puts player1.add_color(player1.guess).join('')
    puts "\n"
    puts "You couldn't crack the code in time.".red if i == 12
    i += 1
  end
end

player_vs_computer()

cpu = Computer.new

p1 = Player.new

p1.create_code

p cpu.random_guess

cpu.computer_play(p1.playerCode, cpu.randomGuess)

cpu.check_guess(cpu.randomGuess, cpu.clues)
