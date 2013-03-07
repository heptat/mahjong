
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

  def tabled_score
    score = 0
    # get counts of the tiles
    tiles = @tabled.inject(Hash.new(0)) { |hash, tile| hash[tile.face] += 1; hash }

    # shouldn't be less than 3 because you can't table that, but can also be 4
    score += (@player == 1 ? 2 : 1) if tiles['north'] >= 3
    score += 1 if tiles['white board'] >= 3

    score
  end

end
