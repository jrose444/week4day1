require_relative "PolyTreeNode"

class KnightPathFinder
  attr_reader :considered_positions

  def self.valid_moves(pos)
    x, y = pos
    move_arr = []
    [-2, -1, 1, 2].each do |i|
      [-2, -1, 1, 2].each do |j|
        if (i + j).odd?
          if (0..7).include?(x+i) && (0..7).include?(y+j)
            move_arr << ([x+i, y+j])
          end
        end
      end
    end
    move_arr
  end

  def initialize(start_position)
    @position = start_position
    @considered_positions = [start_position]
    @root_node = PolyTreeNode.new(start_position)
    self.build_move_tree
  end

  def new_move_positions(pos)
    valid = KnightPathFinder.valid_moves(pos)
    valid_moves = []
    valid.each do |position|
      if !@considered_positions.include?(position)
        @considered_positions << position
        valid_moves << position
      end
    end
    valid_moves
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?
      check = queue.shift
      
      
      new_move_positions(check.value).each do |position|
        var = PolyTreeNode.new(position)
        var.parent = check 
        queue << var
        # queue << PolyTreeNode.new(position)
      end

    end
  end

  def find_path(end_pos)
    final_node = @root_node.dfs(end_pos)
    self.trace_path_back(final_node)
  end
  
  def trace_path_back(end_pos)
    path = []
    node = end_pos
    until node.parent == nil
      path << node.value
      node = node.parent
    end
    path << @root_node.value
    path.reverse
  end

end