
require_relative 'tile'
require_relative 'flower_tile'

class Hand

  attr_reader :player, :tabled

  def initialize(player, tiles)
    @player = player
    @tiles = tiles
    @tabled = []
  end

  def size
    @tiles.size
  end

  def draw(tile)
    if tile.must_table?
      @tabled << tile
    else
      @tiles << tile
    end
    self.size
  end

  def table(face)
    tabled_tiles = @tiles.map { |tile| tile if tile.face == face }
    # TODO this doesn't feel right, must be a way to do this with map
    tabled_tiles.compact!
    if tabled_tiles.count == 3 || tabled_tiles.count == 4
      tabled_tiles.each do |tile|
        @tabled << tile
        @tiles.delete(tile)
      end
      tabled_tiles_count = tabled_tiles.count
    else
      tabled_tiles_count = 0
    end
  end

  # TODO now I think that tabled tiles should be stored as an array of
  # (matching) tile sets
  def tabled_score
    score = 0
    # sort the array but it's probably already in order considering how the
    # tiles are put int
    @tabled.each do |tile|
      if tile.table_score?
        score = 1
      end
    end
    score
  end

end
