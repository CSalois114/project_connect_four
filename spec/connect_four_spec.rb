require "./lib/connect_four.rb"

describe Node do
  describe "#coords" do
    it "returns the coordinates of the node" do
      node = Node.new([1, 1])
      expect(node.coords).to eql([1, 1])
    end
  end

  describe "directional instance variables" do
    it "sets all the directions to proper coordinates" do
      node =                  Node.new([2, 2])
      expect(node.up).to           eql([2, 3]) 
      expect(node.down).to         eql([2, 1])
      expect(node.left).to         eql([1, 2])
      expect(node.right).to        eql([3, 2]) 
      expect(node.left_up).to      eql([1, 3]) 
      expect(node.right_up).to     eql([3, 3]) 
      expect(node.left_down).to    eql([1, 1]) 
      expect(node.right_down).to   eql([3, 1]) 
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


  


