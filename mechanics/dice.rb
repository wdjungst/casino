module Mechanics
  module Dice
    def self.roll
      die = []
      die << rand(1..6) << rand(1..6)
    end
  end
end
