class Node
  attr_accessor :symbol
  attr_reader :coords
  def initialize(coords)
    @coords = coords
    @symbol = nil
  end
end