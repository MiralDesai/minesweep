class Tile
  def initialize(row:, column:, is_mine: false)
    @row = row
    @column = column
    @revealed = false
    @is_mine = is_mine
  end

  def pick
    @revealed = true
  end

  attr_accessor :row, :column, :is_mine, :revealed
end
