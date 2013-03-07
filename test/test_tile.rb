
require_relative '../lib/tile'
require 'test/unit'

class TestTile < Test::Unit::TestCase

  def setup
    @one_dot = Tile.new('one dot', false)
    @north = Tile.new('north', true, 1)
  end

  def test_one_dot_tile_face
    assert_equal 'one dot', @one_dot.face
  end

  def test_one_dot_tile_player
    assert_equal nil, @one_dot.player
  end

  def test_north_tile_has_correct_face
    assert_equal 'north', @north.face
  end

  def test_north_tile_has_no_player
    assert_equal 1, @north.player
  end

  def test_tile_must_table
    assert_equal false, @north.must_table?
  end

  def test_tile_one_dot_table_score
    assert_equal false, @one_dot.table_score?
  end

  def test_tile_north_table_score
    assert_equal true, @north.table_score?
  end

end
