
require_relative 'tile'

class FlowerTile < Tile

  def initialize(face, player = nil)
    super(face + ' flower', true, player)
    @must_table = true
  end

end
