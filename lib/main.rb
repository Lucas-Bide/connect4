require_relative "player"
require_relative "board"

class Main

  def initialize
    puts "Welcome to Connect Four!?\n"
    start_game
  end

  def display_board board
    puts
    board.board.each { |a| puts "|" + a.join("|") + "|" }
    puts "‾‾‾" * 7 + "‾" 
  end

  def start_game
    p1 = Player.new
    p1.turn = true
    p2 = Player.new  
    board = Board.new
    board.set_players p1, p2

    while !board.game_over?
      display_board board
      available_moves = board.moves
      puts "Player #{p1.turn == true ? 1 : 2}, choose an available column: " + available_moves.join("-")
      answer = gets.chomp
      while answer.length != 1 || !available_moves.join("").include?(answer)
        puts "I'm losing my patience, but I can go on forever. Enter a correct option. Scroll up if you need to." 
        puts "I put effort into the same concept for tictactoe. I can't be bothered, now. I'm just practicing RSpec with this project."
        answer = gets.chomp
      end
      board.make_move(answer.to_i)
      p1.turn = p1.turn ? false : true
      system("clear") || system("cls")
    end

    display_board board
    puts "Game over!"
    puts "Player #{p1.wins == 1 ? 1 : 2} wins! Run the script again if you want another go. Or implement the loop yourself ;P."
  end
end

a = Main.new