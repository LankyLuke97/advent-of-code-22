class LinkedList # actually, probably easier to implement a circular linked list
    def initialize
        @head = nil
        @length = 0
    end

    def append(value)
        @length += 1
        if @head
            tail = findTail
            tail.next = value
            tail.next.next = @head
        else 
            @head = value
            @head.next = @head
        end
    end

    def findTail
        node = @head
        return node if !node.next
        
        while(node = node.next)
            return node if node.next == @head # If next node is head, it's the tail
        end
    end

    def appendAfter(target, value)
        node = find(target)

        return unless node
        oldNext = node.next
        node.next = value
        node.next.next = oldNext
        # puts to_a.inspect
        # puts "Old next: #{oldNext}"
        # puts "node.next: #{node.next}"
        # puts "node.next.next: #{node.next.next}"

    end

    def find(target)
        node = @head

        return false if !node.next
        return node if node.value == target.value
        
        while (node = node.next)
            return node if node.value == target.value
        end
    end

    def findIndex(target)
        index = 0
        node = @head

        return index if node.value == target.value
        
        while (node = node.next)
            index += 1
            return index if node.value == target.value
        end
    end

    def delete(value)
        @length -= 1
        if @head.value == value
            findTail.next = @head.next
            @head = @head.next
            return
        end
        node      = findBefore(value)
        node.next = node.next.next
    end

    def move(index)
        node = @head

        while node.value[1] != index
            node = node.next
        end

        toMove = node

        shift = toMove.value[2]
        if shift == 0 
            return
        end
        
        node      = findBefore(toMove)
        node.next = node.next.next
        if toMove == @head
            @head = node.next
        end

        (1..shift).each do |s|
            node = node.next
        end

        appendAfter(node, toMove)
    end

    def findBefore(target)
        node = @head

        return false if !node.next
        return node  if node.next.value == target.value

        while (node = node.next)
            return node if node.next.value == target.value
        end
    end

    def print
        node = @head
        puts node.value.inspect
        current = node.next
        while (current != @head)
                current = current.next
        end
    end

    def to_a
        node = @head
        list = Array.new [node.value]
        current = node.next
        while (current.value != @head.value)
            list << current.value
            current = current.next
        end
        return list
    end
end

class Node
    attr_accessor :next
    attr_reader   :value

    def initialize(value)
        @value = Array(value)
        @next  = nil
    end

    def to_s
        "Node with value: #{@value}"
    end
end

filename = ARGV.length() == 0 ? "input.txt" : ARGV[0].to_s
lines = File.readlines(filename)

zeroNode = nil
list = LinkedList.new

lines.each_with_index do |line, index|
    decrypted = line.to_i * 811589153
    move = decrypted % (lines.size - 1)
    node = Node.new([decrypted, index, move])
    if line.to_i == 0
        zeroNode = node
    end
    list.append(node)
end

(1..10).each do |i|
    (0..lines.size - 1).each do |i|
        list.move(i)
    end
end

answer = 0
zeroIndex = list.findIndex(zeroNode)
ordered = list.to_a
[(1000+zeroIndex) % ordered.size, (2000+zeroIndex) % ordered.size, (3000+zeroIndex) % ordered.size].each do |n|
    puts "#{n}: #{ordered[n][0]}"
    answer += ordered[n][0]
end
puts answer