require "./lib/board.rb"

describe Board do
  
  describe "@nodes" do
    it "contains the nodes in a hash with the coordinates as the keys" do
      board = Board.new
      expect(board.nodes[[4, 5]].class).to   eql(Node)
      expect(board.nodes[[4, 5]].coords).to  eql([4, 5])
    end

    it "returns nil if the node doesn't exist" do
      board = Board.new
      expect(board.nodes[[1, 15]]).to  be nil
    end
  end

  describe "#set_lowest_empty_node_symbol(column, symbol)" do
    it "plays the symbol given in the bottom most available spot in column and returns that node" do
      board = Board.new
      expect(board.set_lowest_empty_node_symbol(3, :x)).to   eql(board.nodes[[3, 1]])
      expect(board.nodes[[3, 1]].symbol).to                  eql(:x)

      expect(board.set_lowest_empty_node_symbol(3, :o)).to   eql(board.nodes[[3, 2]])
      expect(board.nodes[[3,2]].symbol).to                   eql(:o)
    end
  end

  describe "#get_valid_column" do 
    it "returns the x coordinate of the column if it has room" do 
      board = Board.new
      expect(board.get_valid_column(1)).to    eql(1)
    end
    it "doesn't return initial input if column is full or doesn't exist" do
      allow($stdout).to receive(:write)

      board = Board.new
      6.times {board.set_lowest_empty_node_symbol(1, :x)}
      allow(board).to receive(:gets).and_return("2\n")

      expect{board.get_valid_column(1)}.to output(
        "Invalid entry.\n" +
        "Be sure to enter a column that is not yet full.\n"
      ).to_stdout

      expect{board.get_valid_column(10)}.to output(
        "Invalid entry.\n" +
        "Be sure to enter a column that is not yet full.\n"
      ).to_stdout
    end
  end

  describe "#display" do
    it "displays the current board" do
      allow($stdout).to receive(:write)
      board = Board.new
      3.times {board.set_lowest_empty_node_symbol(1, :x)}
      2.times {board.set_lowest_empty_node_symbol(5, :o)}

      expect{board.display}.to output(
        " 1 2 3 4 5 6 7\n"  +
        "| | | | | | | |\n" +
        "| | | | | | | |\n" +
        "| | | | | | | |\n" +
        "|x| | | | | | |\n" +
        "|x| | | |o| | |\n" +
        "|x| | | |o| | |\n" +
        " 1 2 3 4 5 6 7\n"
      ).to_stdout
    end
  end



  describe "#winner?" do
    context "returns true if the node is part of a winning connect four line" do
      it "works vertically" do
        board = Board.new
        node = board.nodes[[1, 1]]
        current_node = node
        4.times do
          current_node.symbol = :x
          current_node = board.nodes[[current_node.coords[0], current_node.coords[1] + 1]]
        end
        expect(board.winner?(node)).to               be true
        expect(board.winner?(board.nodes[[2,1]])).to be false
      end

      it "works horizontally" do
        board = Board.new
        node = board.nodes[[1, 1]]
        current_node = node
        4.times do
          current_node.symbol = :o
          current_node = board.nodes[[current_node.coords[0] + 1, current_node.coords[1]]]
        end
        expect(board.winner?(node)).to               be true
        expect(board.winner?(board.nodes[[1,2]])).to be false
      end

      it "works diagonally" do
        board = Board.new
        node = board.nodes[[1, 1]]
        current_node = node
        4.times do
          current_node.symbol = :o
          current_node = board.nodes[[current_node.coords[0] + 1, current_node.coords[1] + 1]]
        end
        expect(board.winner?(node)).to               be true
        expect(board.winner?(board.nodes[[1,2]])).to be false
      end
    end
  end
end


  


