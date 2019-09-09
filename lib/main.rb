require_relative "board"

@board = Board.new
@player1_symbol = :x
@player2_symbol = :o

def take_turn(player_symbol)
  @board.display
  puts "Player #{player_symbol}, enter the column number where"
  puts "you would like to place your next piece."
  
  #asks player until an existing, unfilled column is given
  column = @board.get_valid_column(gets.chomp.to_i) 
  #set_lowest_empty_node_symbol returns the node whos symbol it set, making it the last_played 
  @board.last_played = @board.set_lowest_empty_node_symbol(column, player_symbol)
end

until @board.nodes.values.all? {|node| node.symbol}    #until the game board is full
  take_turn(@player1_symbol)
  break if @board.winner?

  take_turn(@player2_symbol)
  break if @board.winner?
end
@board.display
puts @board.winner? ? "Player #{@board.last_played.symbol} wins!" : "Tie Game"