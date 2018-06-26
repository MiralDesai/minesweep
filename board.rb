require './tile.rb'

class Board
  def initialize(size:, difficulty:)
    @difficulty = difficulty
    @size = size
    @mines = []
    create_board
    set_mines
  end

  def touch(row:, column:)
    return 'mine'     if @tiles[column][row].is_mine?
    return 'revealed' if @tiles[column][row].revealed
    @tiles[y][x].pick
  end

  def pretty_print

  end

  private

  def create_board
    @tiles = Array.new(size) { |column| Array.new(size) { |row| Tile.new(row: row, column: column) } }
  end

  def set_mines
    mine_count = ((size * size) * mine_percentage).round
    mine_count.times.each do
      row = rand(size)
      column = rand(size)

      if !@mines.include?(@tiles[column][row])
        @tiles[column][row].is_mine = true
        @mines << @tiles[column][row]
      end
    end
  end

  def mine_percentage
    { easy: 0.25, medium: 0.50, hard: 0.75 }[difficulty.to_sym]
  end

  attr_accessor :size, :tiles, :difficulty
end
