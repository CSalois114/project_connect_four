require "./lib/node.rb"

describe Node do
  it "is expected to respond to :symbol and return its :coords" do
    node = Node.new([1,1])
    expect(node).to         respond_to(:symbol)
    expect(node.coords).to  eql([1,1])
  end  
end
  