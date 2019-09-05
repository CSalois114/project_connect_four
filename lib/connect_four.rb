class Node
  attr_accessor :up, :down, :left, :right, :left_up, :right_up, :left_down, :right_down, :symbol
  attr_reader :coords
  def initialize(coords)
    @coords = coords
    @symbol = nil

    @up =         [@coords[0]    , @coords[1] + 1]
    @down =       [@coords[0]    , @coords[1] - 1]
    @left =       [@coords[0] - 1, @coords[1]    ]
    @right =      [@coords[0] + 1, @coords[1]    ]
    @left_up =    [@coords[0] - 1, @coords[1] + 1]
    @right_up =   [@coords[0] + 1, @coords[1] + 1]  
    @left_down =  [@coords[0] - 1, @coords[1] - 1]
    @right_down = [@coords[0] + 1, @coords[1] - 1]
  end

end

class Board 
  attr_reader :nodes

  def initialize
    @nodes = {}
    (1..7).each {|x| (1..6).each {|y| @nodes[[x,y]] = Node.new([x,y])}}
  end

  def display
    system("clear") || system("cls")
    puts " 1 2 3 4 5 6 7"
    (1..6).reverse_each do |y| 
      puts "|#{(1..7).map {|x| @nodes[[x,y]].symbol ? @nodes[[x,y]].symbol : " "}.join("|")}|"
    end
    puts " 1 2 3 4 5 6 7 "
  end

  def play(colomn, symbol)
    node = @nodes[[colomn, 1]]
    while node.symbol
      node = @nodes[node.up]
      break if !node 
    end
    node.symbol = symbol if node
    node
  end

  def winner?(node)
    return false unless node.symbol 
    [ get_line_length(node){|node| [self.nodes[node.up], self.nodes[node.down]] }, 
      get_line_length(node){|node| [self.nodes[node.left], self.nodes[node.right]] },
      get_line_length(node){|node| [self.nodes[node.left_up], self.nodes[node.right_down]] },
      get_line_length(node){|node| [self.nodes[node.left_down], self.nodes[node.right_up]] }
      ].any? {|line_length| line_length >= 4 }
  end 

  private 

  def get_line_length(node)
    length = 1
    current_node = node
    while yield(current_node)[0]
      current_node = yield(current_node)[0]
      current_node.symbol == node.symbol ? length += 1 : break
    end
    current_node = node
    while yield(current_node)[1]
      current_node = yield(current_node)[1]
      current_node.symbol == node.symbol ? length += 1 : break
    end
    length
  end
end


