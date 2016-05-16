require 'colorize'
require_relative '../lib/utils'

module Games
  include Utils

  class Slots
    attr_accessor :player

    def initialize(player)
      @player = player
      @cont = true
      @symbols = %w(Δ  ҉Ӝ Ք ♞ ♫ ☂)
    end

    def play
      while @cont
        menu
      end
    end

    def menu
      color = player.bankroll >= 5 ? :white : :light_black
      puts "Welcome to Slots"
      puts "1: Spin".colorize(color)
      puts "2: Walk Away"
      case gets.to_i
        when 1
          if color == :light_black
            puts "You don't have enough to play"
            menu
          else
            spin
          end
        when 2
          walk_away
        else
          puts "Bad selection.  Choose 1 or 2"
      end
    end

    def spin
      shift = rand(1..20)
      shift.times do |i|
        @sym1 = @symbols.sample
        @sym2 = @symbols.sample
        @sym3 = @symbols.sample
      puts "#{@sym1} | #{@sym2} | #{@sym3}"
      end
      puts "\n==================="
      puts "#{@sym1.colorize(:green)} | #{@sym2.colorize(:green)} | #{@sym3.colorize(:green)}"
      win_lose(@sym1, @sym2, @sym3)
    end

    def win_lose(sym1, sym2, sym3)
      if sym1 == sym2 && sym2 == sym3
        5.times { system('say ah yeah dingdingding') }
        player.bankroll += 100
        puts "You WIN!!!!!! DING DING DING DING".colorize(:yellow)
        puts "Balance: #{Utils.money(player.bankroll)}".colorize(:green)
      else
        @player.bankroll -= 5
        puts "You lose".colorize(:yellow)
        puts "Balance: #{Utils.money(player.bankroll)}".colorize(:red)
      end
    end

    def walk_away
      @cont = false
    end

  end
end
