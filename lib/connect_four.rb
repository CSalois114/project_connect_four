class Node
  attr_accessor :symbol
  attr_reader :coords
  def initialize(coords)
    @coords = coords
    @symbol = nil
  end
end

class Board 
  attr_reader :nodes

  def initialize
    @nodes = {}
    (1..7).each {|x| (1..6).each {|y| @nodes[[x,y]] = Node.new([x,y])}}
  end

  def start_game
    last_played = nil
    until nodes.values.all? {|node| node.symbol}
      [:x, :o].each do |player_symbol|
        display
        puts "Player #{player_symbol}, enter the colomn number where"
        puts "you would like to place your next piece."
        colomn = get_valid_colomn(gets.chomp.to_i)
        last_played = take_turn(colomn, player_symbol)
        break if winner?(last_played)
      end
      break if winner?(last_played)
    end
    display
    puts winner?(last_played) ? "Player #{last_played.symbol} wins!" : "Tie Game"
  end
  

  def display
    system("clear") || system("cls")
    puts " 1 2 3 4 5 6 7"
    (1..6).reverse_each do |y| 
      puts "|#{(1..7).map {|x| @nodes[[x,y]].symbol ? @nodes[[x,y]].symbol : " "}.join("|")}|"
    end
    puts " 1 2 3 4 5 6 7 "
  end

  def take_turn(colomn, symbol)
    node = @nodes[[colomn, 1]]
    while node.symbol
      node = @nodes[offset_coords(node.coords, [0, 1])]
      break if !node 
    end
    node.symbol = symbol if node
    node
  end

  def winner?(node)
    return false unless node.symbol 
    [ get_line_length(node, [[ 0,  1], [0, -1]]), 
      get_line_length(node, [[-1,  0], [1,  0]]),
      get_line_length(node, [[-1,  1], [1, -1]]),
      get_line_length(node, [[-1, -1], [1,  1]])
      ].any? {|line_length| line_length >= 4 }
  end 


  private 

  def get_line_length(node, offsets)
    length = 1
    offsets.each do |offset|
      current_node = node
      # while the next node in offset direction exists, add 1 to line length if same symbol
      while @nodes[offset_coords(current_node.coords, offset)]
        current_node = @nodes[offset_coords(current_node.coords, offset)]
        current_node.symbol == node.symbol ? length += 1 : break
      end
    end
    length
  end

  def offset_coords(node_coords, offset)
    [node_coords[0] + offset[0], node_coords[1] + offset[1]]
  end

  def get_valid_colomn(entry) 
    until entry <= 7 && entry >= 1 && !@nodes[[entry, 6]].symbol 
      puts "Invalid entry."
      puts "Be sure to enter a colomn that is not yet full."
      entry = gets.chomp.to_i
    end
    entry
  end
end



  
    
