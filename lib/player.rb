class Player
  attr_accessor :turn
  attr_reader :wins

  def initialize
    @turn = false
    @wins = 0
  end
  
  def won
    @wins += 1
  end
end

