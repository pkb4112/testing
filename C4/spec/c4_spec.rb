require "c4"
require "matrix"


describe "GameBoard" do
  describe "attributes" do
    subject do
      GameBoard.new(Array.new(6){Array.new(7){'*'}})
    end
      it {is_expected.to respond_to(:matrix)}
      it {expect(subject.matrix[1][1]).to eql('*')}
    end

 describe ".check_location" do
   context "Given the player provided x,y location" do 
     let(:game) {GameBoard.new(Array.new(6){Array.new(7){'*'}})}
      it "Returns true if the location is in bounds and unplayed previously" do
        expect(game.check_location([5,5])).to eql(true)
      end

      it "Returns false if the location is out of bounds" do
        expect(game.check_location([9,9])).to eql(false)

      end  

      let(:played_game) {GameBoard.new(Array.new(6){Array.new(7){'X'}})}

      it "Returns false if the location has been played previously" do
        expect(played_game.check_location([5,5])).to eql(false)
      end

    end
  end

  describe ".place_piece" do
    let(:game) {GameBoard.new(Array.new(6){Array.new(7){'*'}})}
    let(:player_1) {Player.new("",1)}
    let(:player_2) {Player.new("",2)}
    context "Given the players previously selected x,y location" do
      it "Places an 'X' in the 4,4 location for Player 1" do
        game.place_piece([4,4],player_1)
        expect(game.matrix[4][4]).to eql('X')
      end
      it "Places an 'O' in the 5,5 location for Player 2" do
       game.place_piece([5,5],player_2)
        expect(game.matrix[5][5]).to eql('O')
      end
    end
  end
end


describe "Player" do

  describe "attributes" do
    subject do
      Player.new('PKB',1)
    end

    it {is_expected.to respond_to(:name)}
    it {is_expected.to respond_to(:player_num)}

  end
  describe ".win?" do
    let(:player1) do 
      player1=Player.new('name',1)
    end
    let!(:game) do 
      GameBoard.new(Array.new(6){Array.new(7){"*"}})
    end
    context "Given an array of all pieces placed by the player" do
     it "Returns false if less than 4 pieces have been placed" do
        player1.pieces = [[0,1],[0,2],[0,3]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(false)
      end
      it "Returns true if 4 pieces placed in a horizontal row" do
        player1.pieces = [[1,0],[2,0],[3,0],[4,0]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(true)
      end
       it "Returns true if 4 pieces placed in a vertical row" do
        player1.pieces = [[1,1],[1,2],[1,3],[1,4]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(true)
      end
      it "Returns true if 4 pieces placed in a right-hand diagonal" do
        player1.pieces = [[1,1],[2,2],[3,3],[4,4]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(true)
      end
      it "Returns true if 4 pieces placed in a left-hand diagonal" do
        player1.pieces = [[1,4],[2,3],[3,2],[4,1]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(true)
      end
      it "Returns false if 4 pieces placed non-consecutively" do
        player1.pieces = [[1,0],[4,2],[3,0],[5,0]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(false)
      end
      it "Returns false if a piece is checked out of bounds" do
        player1.pieces = [[1,1],[4,5],[6,5],[5,5]]
        player1.pieces.each {|i|  game.matrix[i[1]][i[0]] = 'X'}
        expect(player1.win?(game)).to eql(false)
      end
    end
end
end
