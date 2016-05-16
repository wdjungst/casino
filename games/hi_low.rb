require 'colorize'
require_relative '../lib/utils'
require_relative '../mechanics/cards'

module Games
  include Mechanics
  include Utils

  class HiLow
    attr_accessor :player

    def initialize(player)
      @cont = true
      @player = player
      @cards = Mechanics::Deck.new.cards
    end

    def play
      while @cont
        menu
      end
    end

    def menu
      color = player.bankroll >= 5 ? :white : :light_black
      puts "Welcome to Hi Low"
      puts "1: Deal".colorize(color)
      puts "2: Walk Away"
      case gets.to_i
        when 1
          if color == :light_black
            puts "You don't have enough to play"
            menu
          else
            deal
          end
        when 2
          walk_away
        else
          puts "Bad selection.  Choose 1 or 2"
      end
    end

    def deal
      if @cards.length < 2
        @cards = Mechanics::Deck.new
      end

      dealer_card = @cards.slice!(rand(0..(@cards.length - 1)))
      #puts "#{dealer_card.rank} of #{dealer_card.suit.colorize(dealer_card.color)}"
      puts "High or Low? (hi, low)"
      valid = false
      until valid
        bet = gets.strip.downcase
        valid = bet =~ /hi|low/
      end
      card = @cards.slice!(rand(0..(@cards.length - 1)))
      #puts "#{card.rank} of #{card.suit.colorize(card.color)}"
      win_lose(dealer_card, bet, card)
    end

    def dealer_wins
      player.bankroll -= 5
      puts "You Lose"
      puts "Your balance is #{Utils.money(player.bankroll)}".colorize(:red)
    end

    def player_wins
      player.bankroll += 5
      puts "You win"
      puts "Your balance is #{Utils.money(player.bankroll)}".colorize(:green)
    end

    def print_card(card)
      card = <<-CARD
        ------------
        |#{card.rank}          |
        |           |
        |           |
        |     #{card.suit.colorize(card.color)}     |
        |           |
        |           |
        |          #{card.rank}|
        -------------
      CARD
      puts card
    end

    def reveal_cards(dealer_card, player_card)
      puts "DEALER CARD:"
      print_card(dealer_card)
      puts "YOUR CARD:"
      print_card(player_card)
    end

    def win_lose(dealer_card, bet, card)
      reveal_cards(dealer_card, card)
      case bet
      when 'hi'
        if dealer_card.rank > card.rank
          dealer_wins
        elsif dealer_card.rank < card.rank
          player_wins
        else
          dealer_card.rank > card.rank ? dealer_wins : player_wins
        end
      when 'low'
        if dealer_card.rank > card.rank
          player_wins
        elsif dealer_card.rank < card.rank
          dealer_wins
        else
          dealer_card.rank < card.rank ? dealer_wins : player_wins
        end
      end
    end

    def walk_away
      @cont = false
    end
  end
end
