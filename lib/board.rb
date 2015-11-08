class Board
  def initialize(boardsize)
    @boardsize = boardsize
    @squares = Array.new(boardsize) {Array.new(boardsize, :empty)}
  end
  
  def occupy_square(rank, file)
    occupy_square_with(rank,file, :occupied)
  end

  def occupy_square_with(rank, file, key)
    @squares[rank][file] = key
  end

  def get_status_square(rank, file)
    if check_inside(rank, file)
      [:found, @squares[rank][file]]
    else
      [:not_found, nil]
    end
  end

  def check_inside(rank, file)
    inside(rank) && inside(file)
  end

  def inside(number)
    number >= 0 && number < @boardsize
  end

  def traverse_all_squares(&block)
    @squares.each_with_index do |rank, rank_index|
      rank.each_with_index do |square, file_index|
        block.call(square, rank_index, file_index)
      end      
    end
  end

  def traverse_rank(rank, &block)
    @squares[rank].each_with_index do |square, file_index|
      block.call(square, file_index)
    end
  end

  def traverse_file(file, &block)
    @squares.each_with_index do |rank, rank_index|
      rank.each_with_index do |square, file_index|
        block.call(square, rank_index) if file == file_index
      end
    end
  end

  def traverse_rank_between_files(rank, initial_file, final_file, &block)
    @squares[rank][initial_file..final_file].each_with_index do |square, file|
      block.call(square, file)
    end
  end

  def traverse_file_between_ranks(file, initial_rank, final_rank, &block)
    @squares[initial_rank..final_rank].each_with_index do |rank, rank_index|
      square = rank[file]
      block.call(square, rank_index)
    end
  end
end
