require './board.rb'
require './io.rb'
require 'pry'

class Minesweep
  def initialize(size:, difficulty:)
    @difficulty = difficulty
    @board = Board.new(size: size.to_i, difficulty: difficulty)
    @status = 'in_progress'
    play
  end

  def play
    IO.output(board.pretty_print)
    IO.output(board.pretty_print(final: true)) # debugging
    IO.output('Welcome to minesweep! Game will begin now')
    until status != 'in_progress' do
      IO.output('Select coordinates(row then column) e.g 0,0:')
      output = STDIN.gets.chomp.split(',')
      check_move(move(column: output.first.to_i, row: output.last.to_i))
      IO.output('Game status: ' + status)
    end
    IO.output('Better luck next time... sucker! 😢') if status == 'game_over_lose'
    IO.output('🏆🏆🏆 WINNER WINNER CHICKEN DINNER! 🏆🏆🏆') if status == 'game_over_win'
    IO.output(board.pretty_print(final: true))
  end

  def move(row:, column:)
    selected = board.touch(row: row, column: column)
  end

  private

  def check_move(move_result)
    IO.output('⚠️ Move invalid ⚠️') if move_result == 'invalid_move'
    @status = 'game_over_lose' if move_result == 'mine'
    @status = 'game_over_win' if move_result == 'all_revealed'
    IO.output('Already chosen') if move_result == 'revealed'
    IO.output(board.pretty_print)
  end

  attr_accessor :difficulty, :board, :status
end
Minesweep.new(size: ARGV[0], difficulty: ARGV[1])
