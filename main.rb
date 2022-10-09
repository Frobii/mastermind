# frozen_string_literal: true

require 'colorize' # a ruby gem which simplifies making terminal text colored
require './color_numbers'
require './play_game'
require './computer'
require './player'

def player_vs_computer
  player1 = Player.new
  computer = Computer.new

  computer.pick_numbers
  computerSolution = computer.randomPicks

  i = 1
  until i == 13
    puts "\n"
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

def computer_vs_player
  cpu = Computer.new

  p1 = Player.new

  cpu.initialize_game(p1.create_code)

  cpu.order_clues(p1.playerCode, cpu.newGuess)
end

def choose_and_play

  def replay_decision()
    puts "\n"
    puts "Would you like to play again? y/n".bold

    replayChoice = gets.chomp.to_s.upcase
  
    if replayChoice == "Y"
      puts "\n"
      choose_and_play()
    elsif replayChoice == "N"
      puts "\n"
      puts "Thanks for playing!".bold.light_blue
    else 
      puts "\n"
      puts "Please make a valid input".red
      replay_decision()
    end
  end

  puts "\n"

  puts "Choose your game mode".bold.blue

  puts "\n"

  puts "Enter A ".bold + "- Guess a CPU generated code"
  puts "Enter B ".bold + "- Create a code for the CPU to guess"

  puts "\n"

  modeChoice = gets.chomp.to_s.upcase

  if modeChoice == "A"
    player_vs_computer()
  elsif modeChoice == "B"
    computer_vs_player()
  else
    puts "\n"
    puts "Please make a valid input".red
    choose_and_play()
  end

  replay_decision()

end

choose_and_play()
