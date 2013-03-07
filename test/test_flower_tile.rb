
require_relative '../lib/flower_tile'
require 'test/unit'

class TestFlowerTile < Test::Unit::TestCase

  def setup
    @cat_flower = FlowerTile.new('cat')
    @player_one_flower = FlowerTile.new('player one', 1)
  end

  def test_cat_flower_tile_face
    assert_equal 'cat flower', @cat_flower.face
  end

  def test_cat_flower_tile_player
    assert_equal nil, @cat_flower.player
  end

  def test_player_one_flower_tile_face
    assert_equal 'player one flower', @player_one_flower.face
  end

  def test_player_one_flower_tile_player
    assert_equal 1, @player_one_flower.player
  end

  def test_tile_must_table
    assert_equal true, @cat_flower.must_table?
  end

  def test_tile_cat_flower_table_score
    assert_equal true, @cat_flower.table_score?
  end

end
