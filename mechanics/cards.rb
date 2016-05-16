module Mechanics

  class Card
    attr_accessor :rank, :suit, :color
    def initialize(rank, suit)
      @rank = rank
      @suit = suit
      @color = (suit == '♠' || suit == '♣') ? :white : :red
    end
  end

  class Deck
    attr_accessor :cards

    def initialize
      @ranks = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
      @suits = %w(♠ ♦ ♥ ♣)
      @cards = []
      generate_deck
    end

    def generate_deck
      @suits.each do |suit|
        @ranks.each do |rank|
          @cards << Card.new(rank, suit)
        end
      end
    end
  end

end











