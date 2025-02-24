filename = ARGV.length() == 0 ? "input.txt" : ARGV[0].to_s
lines = File.readlines(filename)
blueprints = []

lines.each do |line|
    blueprints << line.scan(/\d+/).map(&:to_i)
end

answer = 1

blueprints.each do |blueprint|
    if blueprint[0] > 3
        next
    end
    resources = [[0, 0, 0, 0, 1, 0, 0, 0]] # ore, clay, obsidian, geodes, repeat for robot types
    costs = [[blueprint[1], 0, 0, 0], [blueprint[2], 0, 0, 0], [blueprint[3], blueprint[4], 0, 0], [blueprint[5], 0, blueprint[6], 0]]
    maxCosts = costs.transpose.map(&:max)
    maxCosts[3] = 10000

    (32..1).step(-1).each do |i|
        newResources = Array.new
        currentMax = resources.max_by{|resource| resource[3]}[3]
        resources.each do |resource|
            have = resource[0..3]
            make = resource[4..7]
            costs.each_with_index do |cost, increase|
                unless cost.zip(have).any? {|c, h| c > h }
                    newMake = make.dup
                    newMake[increase] += 1
                    if newMake[increase] > maxCosts[increase]
                        next
                    end
                    r = have.zip(make).map {|h, m| h + m}.zip(cost).map { |n, c| n - c} + newMake
                    if (((i - 1) * i) / 2) + r[3] + i * r[7] < currentMax
                        next
                    end
                    newResources.append(r)
                end
            end
            r = have.zip(make).map {|h, m| h + m} + make
            newResources.append(r)
        end
        newResources = newResources.sort_by { |arr| -(arr[3] + arr[7] + arr[6]) }
        newResources = newResources[0..100000]
        resources = newResources.dup
    end

    max = resources.max_by{|resource| resource[3]}[3]
    answer *= max
end

puts answer