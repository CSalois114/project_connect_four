require "./lib/connect_four.rb"

describe Node do
  describe "#coords" do
    it "returns the coordinates of the node" do
      node = Node.new([1, 1])
      expect(node.coords).to eql([1, 1])
    end
  end
end

describe Board do
  describe "@nodes" do
    it "contains the nodes in a hash with the coordinates as the keys" do
      board = Board.new
      expect(board.nodes[[4, 5]].coords).to  eql([4, 5])
    end

    it "returns nil if the node doesn't exist" do
      board = Board.new
      expect(board.nodes[[1, 15]]).to  be nil
    end
  end

  describe "#take_turn(colomn, symbol)" do
    it "plays the symbol given in the bottom most available spot in colomn and returns that node" do
      board = Board.new
      expect(board.take_turn(3, :x)).to           eql(board.nodes[[3, 1]])
      expect(board.nodes[[3, 1]].symbol).to  eql(:x)

      expect(board.take_turn(3, :o)).to           eql(board.nodes[[3, 2]])
      expect(board.nodes[[3,2]].symbol).to   eql(:o)
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


  


