
class Tile

  attr_reader :player, :face

  def initialize(face, table_score, player = nil)
    @face = face
    @player = player
    @table_score = table_score
    @must_table = false
  end

  def must_table?
    return @must_table
  end

  def table_score?
    return @table_score
  end

end
