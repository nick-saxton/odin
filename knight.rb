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

  def bfs(value, starting_vertex)
    starting_vertex.distance = 0
    queue = [starting_vertex]
    while !queue.empty?
      vertex = queue.shift

      if value == vertex.value
        return
      end

      vertex.neighbors.each do |neighbor|
        if neighbor.distance.nil?
          neighbor.distance = vertex.distance + 1
          queue.push(neighbor)
        end
      end
    end
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

  def knight_move(start_coordinates, end_coordinates)
    start_vertex = @vertices[start_coordinates[0]][start_coordinates[1]]
    end_vertex = @vertices[end_coordinates[0]][end_coordinates[1]]

    # Calculate the distance from the start vertex for each other verte
    bfs(end_coordinates, start_vertex)

    if !end_vertex.distance.nil?
      puts "You made it in #{@vertices[end_coordinates[0]][end_coordinates[1]].distance} move(s)! Here's your path: "
      path = [end_vertex]
      current_vertex = end_vertex
      while current_vertex.distance > 0
        closest_neighbor = nil
        current_vertex.neighbors.each do |neighbor|
          if (!neighbor.distance.nil? and (closest_neighbor.nil? or neighbor.distance < closest_neighbor.distance))
          # if (closest_neighbor.nil? and !neighbor.distance.nil?) or (!neighbor.distance.nil? and neighbor.distance < closest_neighbor.distance)
            closest_neighbor = neighbor
          end
        end
        current_vertex = closest_neighbor
        path.unshift(current_vertex)
      end
      path.each do |vertex|
        puts vertex.value.to_s
      end
    end

    # Reset the distances for the next search
    reset_distances
  end

  def reset_distances
    @vertices.each do |column|
      column.each do |vertex|
        vertex.distance = nil
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
    attr_accessor :neighbors, :distance
    attr_reader :column, :row, :value

    def initialize(column, row)
      @column = column
      @row = row
      @value = [column, row]
      @neighbors = []
      @distance = nil
    end

    def to_s
      "#{@value} - distance: #{@distance}"
    end
  end
end

graph = Graph.new
graph.knight_move([0, 0], [1, 2])
graph.knight_move([0, 0], [7, 7])
graph.knight_move([3, 3], [4, 6])
graph.knight_move([3, 3], [4, 3])