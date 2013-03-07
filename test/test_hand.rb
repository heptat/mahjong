
require_relative '../lib/hand'

# rake file can't run minitest tests....
# require 'minitest/unit'
# so just use test/unit for now
require 'test/unit'

# class TestHand < MiniTest::Unit::TestCase
class TestHand < Test::Unit::TestCase

  def setup
    one_dot = Tile.new('one dot', false)
    north = Tile.new('north', true, 1)
    @hand = Hand.new(1, [one_dot, north])
  end

  def test_hand_player
    assert_equal 1, @hand.player
  end

  def test_hand_size
    assert_equal 2, @hand.size
  end

  def test_hand_size_after_drawing_a_tile
    size = @hand.draw(Tile.new('white board', true))
    assert_equal 3, size
    size = @hand.draw(Tile.new('one dot', false))
    assert_equal 4, size
    assert_equal 4, @hand.size
  end

  def test_tabling_a_tile
    @hand.draw(Tile.new('two dot', false))
    @hand.draw(Tile.new('two dot', false))
    @hand.draw(Tile.new('two dot', false))
    # this will table the 3 "two dot" tiles
    tabled_tile_count = @hand.table('two dot')
    assert_equal 2, @hand.size
    assert_equal 3, @hand.tabled.size
    assert_equal 3, tabled_tile_count
    @hand.tabled.each do |tile|
      assert_equal 'two dot', tile.face
    end
  end

  def test_illegal_tabling_a_tile
    @hand.draw(Tile.new('two dot', false))
    tabled_tile_count = @hand.table('two dot')
    assert_equal 3, @hand.size
    assert_equal 0, @hand.tabled.size
    assert_equal 0, tabled_tile_count
  end

  def test_hand_size_after_drawing_flower
    size = @hand.draw(FlowerTile.new('cat'))
    assert_equal 2, size
    # flower tile should be automatically tabled
    assert_equal 1, @hand.tabled.size
    # is this test worth doing?
    # tabled_tile = @hand.tabled.find { |tile| tile.face == 'cat flower' }
    # assert_equal 'cat flower', tabled_tile.face
  end

  # TODO tests for legal and illegal tabling



  def test_hand_tabled_score_for_player_1
    # really, a hand will be created by drawing one tile at a time and
    # redrawing until hand.size = 13 (or 14 for player 1), this logic will be
    # else where
    hand = Hand.new(1, [
      Tile.new('one dot', false),
      Tile.new('one dot', false),
      Tile.new('one dot', false),
      Tile.new('north', true),
      Tile.new('north', true),
      Tile.new('north', true),
      Tile.new('two dot', false),
      Tile.new('white board', true),
      Tile.new('white board', true),
      Tile.new('white board', true),
      ])

      assert_equal 0, hand.tabled_score

      # no score...yet...dots don't count for a score until gaming
      hand.table('one dot')
      hand.table('one dot')
      hand.table('one dot')

      assert_equal 0, hand.tabled_score

      hand.table('north')
      hand.table('north')
      hand.table('north')

      assert_equal 2, hand.tabled_score

      hand.table('white board')
      hand.table('white board')
      hand.table('white board')

      assert_equal 3, hand.tabled_score
  end

  def test_hand_tabled_score_for_player_2
    # really, a hand will be created by drawing one tile at a time and
    # redrawing until hand.size = 13 (or 14 for player 1), this logic will be
    # else where
    hand = Hand.new(2, [
      Tile.new('one dot', false),
      Tile.new('one dot', false),
      Tile.new('one dot', false),
      Tile.new('north', true),
      Tile.new('north', true),
      Tile.new('north', true),
      Tile.new('two dot', false),
      Tile.new('white board', true),
      Tile.new('white board', true),
      Tile.new('white board', true),
      ])

      assert_equal 0, hand.tabled_score

      # no score...yet...dots don't count for a score until gaming
      hand.table('one dot')
      hand.table('one dot')
      hand.table('one dot')

      assert_equal 0, hand.tabled_score

      hand.table('north')
      hand.table('north')
      hand.table('north')

      assert_equal 1, hand.tabled_score

      hand.table('white board')
      hand.table('white board')
      hand.table('white board')

      assert_equal 2, hand.tabled_score
  end

end
