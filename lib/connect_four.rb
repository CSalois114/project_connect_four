class Node
  attr_accessor :children, :symbol
  attr_reader :coords
  def initialize(coords)
    @coords = coords
    @symbol = nil

    @children = {
      up:         nil
      down:       nil
      left:       nil
      right:      nil

      left_up:    nil
      right_up:   nil  
      left_down:  nil
      right_down: nil
    }
  end

  def winner?
    return false unless @symbol 
    [ get_line_length{|node| [node.up, node.down] }, 
      get_line_length{|node| [node.left, node.right] },
      get_line_length{|node| [node.left_up, node.right_down] },
      get_line_length{|node| [node.left_down, node.right_up] }
      ].any? {|line_length| line_length >= 4 }
  end 

 private 

  def get_line_length()
    length = 1
    current_node = self
    while yield(current_node)[0]
      current_node = yield(current_node)[0]
      current_node.symbol == self.symbol ? length += 1 : break
    end
    current_node = self
    while yield(current_node)[1]
      current_node = yield(current_node)[1]
      current_node.symbol == self.symbol ? length += 1 : break
    end
    length
  end

end

class Board 
  attr_accessor :nodes

  def initialize
    @nodes = {}
    (1..7).each {|x| (1..6).each {|y| @nodes[[x,y]] = Node.new([x,y])}}
    propagate_node_children
  end

  private

  def propagate_node_children
    @nodes.each do |coords, node|
      node.up =         @nodes[ [coords[0] +  0, coords[1] +   1] ]
      node.down =       @nodes[ [coords[0] +  0, coords[1] +  -1] ]
      node.left =       @nodes[ [coords[0] + -1, coords[1] +   0] ]
      node.right =      @nodes[ [coords[0] +  1, coords[1] +   0] ]
      node.left_up =    @nodes[ [coords[0] + -1, coords[1] +   1] ]
      node.right_up =   @nodes[ [coords[0] +  1, coords[1] +   1] ]
      node.left_down =  @nodes[ [coords[0] + -1, coords[1] +  -1] ]
      node.right_down = @nodes[ [coords[0] +  1, coords[1] +  -1] ]   
    end
  end
end

