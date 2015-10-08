class Railroad

  INFINITY              = 1.0 / 0
  TOTAL_NUMBER_OF_TOWNS = 5
  TOWNS_MAP             = { 
                           'A' => 0,
                           'B' => 1,
                           'C' => 2,
                           'D' => 3,
                           'E' => 4
                          }

  attr_reader :routes

  def initialize(filename)
    @routes = Array.new(TOTAL_NUMBER_OF_TOWNS) { |k1|
                Array.new(TOTAL_NUMBER_OF_TOWNS) { |k2| k1 == k2 ? 0 : -1 } }

    read_instructions(filename)
    build_routes
  end

  def read_instructions(filename)
    @instructions = []

    IO.read(filename).split(', ').each do |instruction|
      @instructions << instruction.split(//)
    end
  end

  def build_routes
    @instructions.each do |instruction|
      @routes[TOWNS_MAP[instruction[0]]][TOWNS_MAP[instruction[1]]] = instruction[2].to_i
    end
  end

  def get_distance_of(path)
    return 'WRONG NUMBER OF TOWN' if path.length < 2

    total_distance = 0

    (path.length - 1).times do |index|
      distance = get_distance(path[index], path[index + 1])

      return 'NO SUCH ROUTE' unless connected?(distance)

      total_distance += distance
    end
    total_distance
  end

  def number_of_different_routes(from_town, to_town, options = {})
    stop  = options[:max_stop] || options[:exact_stop]
    range = case
    when options[:exact_stop] 
      then ((stop - 1)..stop)
    when options[:max_stop] 
      then (1..stop)
    else (2..INFINITY)
    end

    number_of_routes(from_town, to_town, [], result = [], stop: stop, max_distance: options[:max_distance])

    result_by_options = []

    result.each do |arr|
      if range.include?(arr.count)
        result_by_options << arr
      end
    end
    result_by_options.count
  end

  def number_of_routes(from_town, to_town, route, result, options = {})
    stop         = options[:stop]
    max_distance = options[:max_distance]
    
    route += [from_town]

    result << route if same_town?(from_town, to_town)

    @routes[TOWNS_MAP[from_town]].each_with_index do |distance, index|
      if connected?(distance)
        if stop && (route.count < stop + 1) || (max_distance && (max_distance >= 0))
          max_distance -= distance if max_distance

          number_of_routes(TOWNS_MAP.invert[index], to_town, route, result, stop: stop, max_distance: max_distance)
        end
      end
    end
  end

  def distance_of_shortest_path(from_town, to_town)
    from_town  = TOWNS_MAP[from_town]
    to_town    = TOWNS_MAP[to_town]
    all_towns  = Array.new(TOTAL_NUMBER_OF_TOWNS) { |i| i }
    distances  = []

    all_towns.each { |i| distances[i] = INFINITY }

    distances[from_town] = 0

    if from_town == to_town
      all_towns.delete(from_town)

      distances[from_town] = INFINITY

      @routes[from_town].each_with_index { |distance, index| distances[index] = distance if connected?(distance) }
    end

    until all_towns.empty? do
      nearest_town = all_towns.min { |a, b| distances[a] <=> distances[b]}

      all_towns.delete(nearest_town)

      @routes[nearest_town].each_with_index do |distance, index|
        if connected?(distance)
          alternative      = distances[nearest_town] + (@routes[nearest_town][index] || INFINITY)
          distances[index] = alternative if distances[index] && alternative < distances[index]
        end
      end
    end
    distances[to_town] == INFINITY ? 'NO SUCH ROUTE' : distances[to_town] 
  end

  def same_town?(first_town, second_town)
    get_distance(first_town, second_town) == 0
  end

  def get_distance(from_town, to_town)
    @routes[TOWNS_MAP[from_town]][TOWNS_MAP[to_town]]
  end

  def connected?(distance)
    distance > 0
  end
end
