#!/usr/bin/env ruby
gem 'minitest', '>=5.0.0'
require_relative 'test_helper'
require_relative '../lib/board'

class BoardTest < MiniTest::Test
  def test_occupy_square_square_exists
    board = Board.new(8)
    board.occupy_square(0,0)
    found, status = board.get_status_square(0,0)
    assert_equal :found, found
    assert_equal :occupied, status
  end

  def test_occupy_square_with_white_square_exists
    board = Board.new(8)
    board.occupy_square_with(0,0, :white)
    found, status = board.get_status_square(0,0)
    assert_equal :found, found
    assert_equal :white, status
  end

  def test_occupy_square_rank_doesnt_exists
    board = Board.new(8)
    found, status = board.get_status_square(8,7)
    assert_equal :not_found, found
    assert_equal nil, status
  end

  def test_occupy_square_file_doesnt_exists
    board = Board.new(8)
    found, status = board.get_status_square(7,8)
    assert_equal :not_found, found
    assert_equal nil, status
  end

  def test_traverse_all_square
    board = Board.new (8)
    counter = 0
    board.traverse_all_squares() {|_,_,_| counter = counter + 1}
    assert_equal 64, counter
  end

  def test_traverse_rank
    board = Board.new (8)
    counter = 0
    board.traverse_rank(1) {|_,_| counter = counter + 1}
    assert_equal 8, counter
  end

  def test_traverse_file
    board = Board.new (8)
    counter = 0
    board.traverse_file(1) {|_,_| counter = counter + 1}
    assert_equal 8, counter
  end

  def test_traverse_rank_between_files
    board = Board.new(8)
    counter = 0
    board.traverse_rank_between_files(2,3,6) {|_,_| counter = counter + 1}
    assert_equal 4, counter
  end

  def test_traverse_file_between_ranks
    board = Board.new(8)
    counter = 0
    board.traverse_file_between_ranks(2, 3, 6) {|_,_| counter = counter + 1}
    assert_equal 4, counter
  end
end
