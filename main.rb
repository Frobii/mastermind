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

cpu.initialize_game(p1.create_code)

cpu.order_clues(p1.playerCode, cpu.newGuess)
