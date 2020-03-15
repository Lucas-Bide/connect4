class Board
  attr :board, :players, :ongoing, :winner
  attr_reader :board
  @@WHITE_COMBO = '☺ ☺ ☺ ☺ '  # ☺ ☻
  @@BLACK_COMBO = '☻ ☻ ☻ ☻ '
  @@SHORTCUT = {@@WHITE_COMBO => :white, @@BLACK_COMBO => :black}
  

  def initialize
    @board = Array.new(6) { Array.new(7, "  ") }
    @players = {white: nil, black: nil}
    @ongoing = true
  end

  def game_over?
    if @ongoing
      if horizontal_win? || vertical_win? || diagonal_win? || !board.join("").include?("  ") 
        #or !(board.inject([]) {|r, v| r + v }).include?("  ") 
        @ongoing = false;
        true
      else
        false
      end    
    end
  end

  def make_move column
    if @ongoing && (0..6).include?(column) && @board[0][column] == "  "
      
      piece = @players[:white].turn ? '☺ ' : '☻ '
      row = 5
      until row < 0
        if @board[row][column] == '  '
          @board[row][column] = piece
          break
        else
          row -= 1
        end
      end      
    end
  end

  def moves
    moves = []
    @board[0].each_with_index { |v, i| moves << i if v == "  " }
    moves
  end

  def set_players p1, p2
    @players[:white] = p1
    @players[:black] = p2
  end

  private

  def combo? combos
    combo = combos[@@WHITE_COMBO] || combos[@@BLACK_COMBO]
    if combo
      @players[@@SHORTCUT[combo]].won
      true
    else
      false
    end
  end

  def diagonal_win?
    diagonals = @board.diagonals.select { |a| a.length > 3}
    diagonals.each do |a| 
      if combo? a.join("")
        return true
      end
    end
    false      
  end

  def horizontal_win?
    i = 5
    while i >= 0
      if @board[i].join("") == "  " * 7
        break
      end
      if combo? @board[i].join("")
        return true
      end
        i -= 1
    end
    false
  end

  def vertical_win?
    transposed = @board.transpose
    for i in (0..6)
      if combo? transposed[i].join("")
        return true
      end
    end
    false
  end

end
# Below's source: https://gist.github.com/EvilScott/1755729
class Array
  def diagonals
    [self, self.map(&:reverse)].inject([]) do |all_diags, matrix|
      ((-matrix.count + 1)..matrix.first.count).each do |offet_index|
        diagonal = []
        (matrix.count).times do |row_index|
          col_index = offet_index + row_index
          diagonal << matrix[row_index][col_index] if col_index >= 0
        end
        all_diags << diagonal.compact if diagonal.compact.count > 1
      end
      all_diags
    end
  end
end
