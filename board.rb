require './tile.rb'

class Board
  ADJACENT_TILES = [
    [1, 0], [0, 1], [-1, 0], [0, -1],
    [1, 1], [-1, -1], [1, -1], [-1, 1]
  ].freeze

  def initialize(size:, difficulty:)
    @difficulty = difficulty
    @size = size
    @mines = []
    create_board
    set_mines
  end

  def touch(row:, column:)
    return 'invalid_move' if [row, column].any? { |selected| selected >= size }
    return 'mine'     if @tiles[column][row].is_mine
    return 'revealed' if @tiles[column][row].revealed
    @tiles[column][row].pick
    return 'all_revealed' if all_tiles_revealed?
  end

  def pretty_print(final: false)
    board = ''
    size.times do |column|
      size.times do |row|
        if tiles[column][row].is_mine
          final ? board << '💥' : board << '❔'
        elsif tiles[column][row].revealed == false
          board << '❔'
        else
          board << ⭕️ # surrounding_mines_count(tiles[column][row])
        end
      end
      board << "\n"
    end
    board
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

  def all_tiles_revealed?
    revealed_tiles_count == (total_tiles_count - @mines.count)
  end

  def revealed_tiles_count
    tiles.flatten.select { |tile| tile.revealed == true }.count
  end

  def total_tiles_count
    tiles.flatten.count
  end

  # def surrounding_mines_count(selected_tile)
  #   count = ADJACENT_TILES.count do |row, column|
  #     found_tile = tiles[selected_tile.column + column][selected_tile.row + row]
  #     found_tile.is_mine unless found_tile.nil?
  #   end
  #   binding.pry
  #   count.to_s
  # end

  attr_accessor :size, :tiles, :difficulty
end
