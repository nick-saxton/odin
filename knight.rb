class Graph
  def initialize
    @vertices = []

    (0..7).each do |i|
      column = []
      (0..7).each do |j|
        column << Vertex.new(i, j)
      end
      @vertices << column
    end

    build_graph
  end

  def build_graph
    # All of the possible jumps a knight can make
    possible_moves = [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]

    # Go through each vertex and then based on the potential moves that could be made from that
    # position, populate the vertex's list of neighboring vertices
    @vertices.each do |column|
      column.each do |vertex|
        column = vertex.column
        row = vertex.row
        possible_moves.each do |move|
          potential_column = column + move[0]
          potential_row = row + move[1]
          if (potential_column >= 0 and potential_column <= 7) and (potential_row >= 0 and potential_row <= 7)
            vertex.neighbors << @vertices[potential_column][potential_row]
          end
        end
      end
    end
  end

  def to_s
    str = ""
    (0..7).each do |i|
      (0..7).each do |j|
        str += "#{@vertices[i][j]}\n"
      end
    end
    str
  end
  
  class Vertex
    attr_accessor :neighbors
    attr_reader :column, :row

    def initialize(column, row)
      @column = column
      @row = row
      @neighbors = []
    end

    def to_s
      str = "Vertex (#{@column}, #{@row}): "
      @neighbors.each_with_index do |neighbor, index|
        if index != 0
          str += ", "
        end
        str += "(#{neighbor.column}, #{neighbor.row})"
      end

      str
    end
  end
end

graph = Graph.new
puts graph