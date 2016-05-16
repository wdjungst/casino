require_relative '../lib/utils'

module Players
  include Utils

  class Player
    attr_accessor :name, :bankroll

    def initialize(name, bankroll)
      @name = name
      @bankroll = bankroll
    end

    def welcome
      puts "Hello #{name} welcome to the casino"
      puts "Here is #{Utils.money(bankroll)} in chips to play with"
    end
  end
end
