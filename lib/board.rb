require_relative "node"

class Board 
  attr_accessor :last_played
  attr_reader :nodes

  def initialize
    @nodes = {}
    (1..7).each {|x| (1..6).each {|y| @nodes[[x,y]] = Node.new([x,y])}}
    @last_played = nil
  end

  def display
    system("clear") || system("cls")
    puts " 1 2 3 4 5 6 7"
    (1..6).reverse_each do |y|  #puts each row of the board
      puts "|#{(1..7).map {|x| @nodes[[x,y]].symbol ? @nodes[[x,y]].symbol : " "}.join("|")}|"
    end
    puts " 1 2 3 4 5 6 7"
  end

  def set_lowest_empty_node_symbol(column, symbol)
    node = @nodes[[column, 1]]  #sets node to the bottom node in that column
    while node.symbol           #searches up the column until a node with no symbol is found
      node = @nodes[offset_coords(node.coords, [0, 1])]
      break if !node            #breaks if all nodes in column are full
    end

    if node
      node.symbol = symbol 
      @last_played = node
    end
    node
  end

  def winner?(node=@last_played)
    return false unless node.symbol 
    [ get_line_length(node, [[ 0,  1], [0, -1]]), 
      get_line_length(node, [[-1,  0], [1,  0]]),
      get_line_length(node, [[-1,  1], [1, -1]]),
      get_line_length(node, [[-1, -1], [1,  1]])
      ].any? {|line_length| line_length >= 4 }
  end 

 def get_valid_column(entry) 
    until entry <= 7 && entry >= 1 && !@nodes[[entry, 6]].symbol 
      puts "Invalid entry."
      puts "Be sure to enter a column that is not yet full."
      entry = gets.chomp.to_i
    end
    entry
  end

  private 

  def get_line_length(node, offsets)
    length = 1
    #offsets here being the coordinate difference between the starting node and the two directions to test
    #for a horizontal line length test, offests would be [ [-1, 0], [1, 0] ]
    offsets.each do |offset|
      current_node = node
      #while the next node in offset direction exists, add 1 to line length if its the same symbol
      while @nodes[offset_coords(current_node.coords, offset)]
        current_node = @nodes[offset_coords(current_node.coords, offset)]
        current_node.symbol == node.symbol ? length += 1 : break
      end
    end
    length
  end

  def offset_coords(node_coords, offset)
    #offset is the difference between the current node and the next node you're trying to get to
    #if youre trying to get the node above the current node its offest is [0, 1], below it is [0, -1]
    [node_coords[0] + offset[0], node_coords[1] + offset[1]]
  end

end