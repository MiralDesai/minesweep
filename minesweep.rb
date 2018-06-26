require './board.rb'
require 'pry'

class Minesweep
  def initialize(size:, difficulty:)
    @difficulty = difficulty
    @board = Board.new(size: size.to_i, difficulty: difficulty)
    @status = 'in_progress'
    play
  end

  def play
    until status != 'in_progress' do
      puts 'Select coordinates: '
      # move(column: gets.chomp)
    end
  end

  def move(row:, column:)
    selected = board.touch(row: row, column: column)
    # if selected == 'mine' game over
    # if selected == 'revealed' already selected
    board.pretty_print
  end

  attr_accessor :difficulty, :board, :status
end
Minesweep.new(size: ARGV[0], difficulty: ARGV[1])
