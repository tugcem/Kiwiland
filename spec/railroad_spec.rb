require './railroad.rb'

describe Railroad do
  before(:all) do
    @kiwiland = Railroad.new 'input.txt'
  end

  it 'should be successfully initialized' do
    expect(@kiwiland).to be_a Railroad
  end

  it 'should return distance of the route A-B-C to 9' do
    expect(@kiwiland.get_distance_of(['A', 'B', 'C'])).to eq 9
  end

  it 'should return distance of the route A-D to 5' do
    expect(@kiwiland.get_distance_of(['A', 'D'])).to eq 5
  end

  it 'should return distance of the route A-D-C to 13' do
    expect(@kiwiland.get_distance_of(['A', 'D', 'C'])).to eq 13
  end

  it 'should return distance of the route A-E-B-C-D to 22' do
    expect(@kiwiland.get_distance_of(['A', 'E', 'B', 'C', 'D'])).to eq 22
  end

  it 'should return distance of the route A-E-D to NO SUCH ROUTE' do
    expect(@kiwiland.get_distance_of(['A', 'E', 'D'])).to eq 'NO SUCH ROUTE'
  end

  it 'should return number of different routes from C to C with a maximum 3 stops to 2' do
    expect(@kiwiland.number_of_different_routes('C', 'C', max_stop: 3)).to eq 2
  end

  it 'should return number of different routes from A to C with exact 4 stops to 3' do
    expect(@kiwiland.number_of_different_routes('A', 'C', exact_stop: 4)).to eq 3
  end

  it 'should return distance of shortest path between A to C to 9' do
    expect(@kiwiland.distance_of_shortest_path('A', 'C')).to eq 9
  end

  it 'should return distance of shortest path between B to B to 9' do
    expect(@kiwiland.distance_of_shortest_path('B', 'B')).to eq 9
  end

  it 'should return number of different routes from C to C with a distance of less than 30 to 7' do
    expect(@kiwiland.number_of_different_routes('C', 'C', max_distance: 30)).to eq 7
  end
end