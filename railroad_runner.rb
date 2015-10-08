require './railroad.rb'

class RailroadRunner

  railroad = Railroad.new(ARGF.filename)

  puts "Output#1:#{railroad.get_distance_of ['A', 'B', 'C']}"
  puts "Output#2:#{railroad.get_distance_of ['A', 'D'] }"
  puts "Output#3:#{railroad.get_distance_of ['A', 'D', 'C']}"
  puts "Output#4:#{railroad.get_distance_of ['A', 'E', 'B', 'C', 'D']}"
  puts "Output#5:#{railroad.get_distance_of ['A', 'E', 'D']}"
  puts "Output#6:#{railroad.number_of_different_routes 'C', 'C', max_stop: 3}"
  puts "Output#7:#{railroad.number_of_different_routes 'A', 'C', exact_stop: 4}"
  puts "Output#8:#{railroad.distance_of_shortest_path 'A', 'C'}"
  puts "Output#9:#{railroad.distance_of_shortest_path 'B', 'B'}"
  puts "Output#10:#{railroad.number_of_different_routes 'C', 'C', max_distance: 30}"
end