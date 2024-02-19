require 'Set'

filename = ARGV.length() == 0 ? "input.txt" : ARGV[0].to_s
jets = File.readlines(filename)[0]
jetsIndex = 0
rocksIndex = 0

seen = Hash.new
rocks = [[30], [8, 28, 8], [28, 4, 4], [16, 16, 16, 16], [24, 24]]
chamber = [127]
ITERATIONS = 1000000000000

sim = 0
cycleHeight = 0
(0..ITERATIONS).each do |sim|
    hash = "#{chamber[-1]}|#{rocksIndex}|#{jetsIndex}"
    if seen.include? hash
        before = seen.keys.find_index(hash)
        sizePerCycle = chamber.size - 1 - seen[hash]
        numCycles = ((ITERATIONS - sim - 1) / (sim - 1 - before)).floor + 1
        numRemaining = (ITERATIONS - sim - 1) % (sim - 1 - before)
        if numRemaining == 0
            puts "#{chamber.size - 1 + ((chamber.size - 1 - seen[hash]) * numCycles)}"
            break
        end
        cycleHeight = sizePerCycle * numCycles
        
    end
    seen[hash] = chamber.size - 1

    rock = rocks[rocksIndex]
    rocksIndex = (rocksIndex + 1) % rocks.size

    (1..3).each do 
        jet = jets[jetsIndex]
        jetsIndex = (jetsIndex + 1) % jets.size

        if jet == '>'
            unless rock.any? {|layer| layer & 1 > 0}
                rock = rock.map { |layer| layer >> 1}
            end
        elsif jet == '<'
            unless rock.any? {|layer| layer & 64 > 0}
                rock = rock.map { |layer| layer << 1}
            end
        end
    end


    jet = jets[jetsIndex]
    jetsIndex = (jetsIndex + 1) % jets.size
    if jet == '>'
        unless rock.any? {|layer| layer & 1 > 0}
            rock = rock.map { |layer| layer >> 1}
        end
    elsif jet == '<'
        unless rock.any? {|layer| layer & 64 > 0}
            rock = rock.map { |layer| layer << 1}
        end
    end

    chamberIndex = -1
    while true
        canFall = true
        rock.each_with_index do |layer, index|
            if chamberIndex + index >= 0
                break
            end
            if layer & chamber[chamberIndex + index] > 0
                canFall = false
                break
            end
        end

        unless canFall
            chamberIndex += 1
            rock.each_with_index do |layer, index|
                if chamberIndex + index >= 0
                    chamber << layer
                else
                    chamber[chamberIndex + index] = chamber[chamberIndex + index] | layer
                end
            end
            break
        end

        jet = jets[jetsIndex]
        jetsIndex = (jetsIndex + 1) % jets.size

        if jet == '>'
            unless rock.any? {|layer| layer & 1 > 0}
                interacts = false
                rock.each_with_index do |layer, index|
                    if index + chamberIndex == 0
                        break
                    end

                    if (layer >> 1) & chamber[chamberIndex + index] > 0
                        interacts = true
                        break
                    end
                end

                unless interacts
                    rock = rock.map { |layer| layer >> 1}
                end
            end
        elsif jet == '<'
            unless rock.any? {|layer| layer & 64 > 0}
                interacts = false
                rock.each_with_index do |layer, index|
                    if index + chamberIndex == 0
                        break
                    end

                    if (layer << 1) & chamber[chamberIndex + index] > 0
                        interacts = true
                        break
                    end
                end

                unless interacts
                    rock = rock.map { |layer| layer << 1}
                end
            end
        end

        chamberIndex -= 1
    end
    sim += 1
end