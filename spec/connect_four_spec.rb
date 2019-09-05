require "./lib/connect_four.rb"

describe Node do
  describe "#coords" do
    it "returns the coordinates of the node" do
      node = Node.new([1, 1])
      expect(node.coords).to eql([1, 1])
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
          current_node = current_node.up
        end

        expect(node.winner?).to              be true
        expect(node.up.winner?).to           be true
        expect(node.up.up.winner?).to        be true
        expect(node.up.up.up.winner?).to     be true

        expect(node.up.up.up.up.winner?).to  be false
      end

      it "works horizontally" do
        board = Board.new
        node = board.nodes[[1, 1]]
        current_node = node
        4.times do
          current_node.symbol = :o
          current_node = current_node.right
        end

        expect(node.winner?).to                          be true
        expect(node.right.winner?).to                    be true
        expect(node.right.right.winner?).to              be true
        expect(node.right.right.right.winner?).to        be true

        expect(node.right.right.right.right.winner?).to  be false
      end

      it "works diagonally" do
        board = Board.new
        node = board.nodes[[1, 1]]
        current_node = node
        4.times do
          current_node.symbol = :o
          current_node = current_node.right_up
        end

        expect(node.winner?).to                                      be true
        expect(node.right_up.winner?).to                             be true
        expect(node.right_up.right_up.winner?).to                    be true
        expect(node.right_up.right_up.right_up.winner?).to           be true

        expect(node.right_up.right_up.right_up.right_up.winner?).to  be false
      end
    end
  end

end

describe Board do
  describe "#propagate_node_children" do
    it "sets all the children in the node tree to allow navigating by children" do
      board = Board.new
      node =                           board.nodes[[2,2]]
      expect(node.up).to           eql(board.nodes[[2, 3]]) 
      expect(node.down).to         eql(board.nodes[[2, 1]])
      expect(node.left).to         eql(board.nodes[[1, 2]])
      expect(node.right).to        eql(board.nodes[[3, 2]]) 

      expect(node.left_up).to      eql(board.nodes[[1, 3]]) 
      expect(node.right_up).to     eql(board.nodes[[3, 3]]) 
      expect(node.left_down).to    eql(board.nodes[[1, 1]]) 
      expect(node.right_down).to   eql(board.nodes[[3, 1]]) 
 
      
    end
  end

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

  describe "#play(colomn, symbol)" do
    it "plays the symbol given in the bottom most available spot in colomn and returns that node" do
      board = Board.new
      expect(board.play(3, :x)).to           eql(board.nodes[[3, 1]])
      expect(board.nodes[[3, 1]].symbol).to  eql(:x)

      expect(board.play(3, :o)).to           eql(board.nodes[[3, 2]])
      expect(board.nodes[[3,2]].symbol).to   eql(:o)
    end
  end
end


  


