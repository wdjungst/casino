require_relative 'players/player'
require_relative 'lib/utils'
Dir[File.dirname(__FILE__) + '/mechanics/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/games/*.rb'].each {|file| require file }

class Casino
  include Mechanics
  include Players
  include Utils
  include Games

  attr_accessor :player
  def initialize
    @player = get_player
    player.welcome
  end

  def get_player
    puts 'What is your name?'
    name = gets.strip
    puts 'How much money do you have?'
    bankroll = gets.to_f
    Players::Player.new(name, bankroll)
  end

  def play
    game_menu
  end

  def game_menu
    puts "Select a game:
      1: Slots
      2: Hi/Low
      3: Check balance
      4: Exit"
    case gets.to_i
    when 1
      slots
    when 2
      hi_low
    when 3
      puts "\n\nYou have #{Utils.money(player.bankroll)}\n\n"
    when 4
      leave_casino
    else
      puts "\n\nIncorrect choice choose 1-4\n\n"
      game_menu
    end
  end

  def slots
    game = Slots.new(player)
    game.play
  end

  def hi_low
    game = HiLow.new(player)
    game.play
  end

  def leave_casino
    puts "\n\nThank you for playing here is your #{Utils.money(player.bankroll)} in exchange for your chips\n\n"
    exit
  end
end

@game = Casino.new

while true
  @game.play
end
