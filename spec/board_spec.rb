require "./lib/board"
require "./lib/player"

RSpec.describe Board do  
  describe "#make_move" do
    
    before(:each) do
      w_piece = double("player")
      b_piece = double("player")
      allow(w_piece).to receive(:turn?) { true }
      allow(b_piece).to receive(:turn?) { false }
      @board = Board.new 
      @board.set_players [w_piece, b_piece]
      @mock_board = Array.new(6) { Array.new(7, "  ") }
    end

    context "The column isn't full" do
      it "Sets a piece in the lowest free space in the column" do
        @mock_board[5][0] = '☺ '
        @board.make_move(0)
        expect(@board).to have_attributes(:board => @mock_board)
      end
    end

    context "The column is full" do
      it "Doesn't set pieces in a full column" do
        6.times { |i| @mock_board[i][0] = '☺ '}
        6.times { @board.make_move(0) }
        expect(@board).to have_attributes(:board => @mock_board)
      end
    end
  end

  describe "#game_over?" do
    
    before(:each) do
      @w_piece = Player.new
      b_piece = Player.new
      @board = Board.new 
      @board.set_players [@w_piece, b_piece]
    end

    context "Stalemate" do
      it "returns true" do
        7.times do |col|
          3.times do
            @board.make_move col
            @board.make_move col
            @w_piece.turn = @w_piece.turn? ? false : true
          end
        end
        expect(@board.game_over?).to be true
      end
    end

    context "Someone wins" do
      it "returns true for vertical win" do
        4.times { @board.make_move 0 }
        expect(@board.game_over?).to be true
      end
    
      it "returns true for horizontal win" do
        4.times { |i| @board.make_move i }
        expect(@board.game_over?).to be true
      end
  
      it "returns true for diagonal win" do
        4.times { |i| i.times { @board.make_move(i+3) } }
        @w_piece.turn = false
        4.times { |i| @board.make_move(i+3) }
        expect(@board.game_over?).to be true
      end
    end
  
    context "Not over yet" do
      it "returns false" do
        7.times do |i| 
          @board.make_move(i)
          @w_piece.turn = @w_piece.turn? ? false : true
        end
        expect(@board.game_over?).to be false
      end
    end
  end
  
  describe "#" do
    
  end

end