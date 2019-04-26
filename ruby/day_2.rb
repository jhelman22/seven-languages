# FIND

# Find out how to access files with and without code blocks. What is the benefit of the code block?
  # Using File.open
  # Without a block, we open a file that is always open for our use throughout the code.
    # It will only close if we tell it to or the program terminates
    # also what is returned by File.open is the File object
  # By using a block, the file is automatically closed after the block executes
    # what is returned by File.open{} is the result of the block

# How would you translate a hash into array?
  # if we want to maintain key-value pairs, simply call `.to_a` on the hash
    # This will return a multidimensional array, where each "row" contains the key-value pair
  # if we just want the keys of the hash as an array, simply call `.keys` on the hash
  # if we just want the values of the hash as an array, simply call `.values` on the hash

# Can to translate arrays to hashes?
  # Yes, but they have to be a very specific form
  # They have to be a multi-dimensional array as mentioned above
  # for example:
    # arr = [[:a,1],[:b,2],[:c,3]]
    # puts Hash[arr]
  # This will print {:a => 1, :b => 2, :c => 3}

# Can you iterate through a hash?
  # Yes, we can use iterators like `each` or `map` but unlike an array
  # the block will have two arguments: one for the key and one for the value
  # example:
    # {a:1,b:2,c:3}.each{|k,v| puts "Key: #{k}, Value: #{v}"}

# You can use Ruby arrays as stacks. What other common data structures do arrays support?
  # Queues - FIFO
  # Sets
  # Matrices

# DO

# Print the contents of an array of sixteen numbers, four numbers at a time, using just `each`.
arr = (1..16).to_a.shuffle

arr.each_with_index{|a,i| print "#{a}#{((i+1) % 4 == 0) ? "\n" : ","}" }

# Now, do the same with `each_slice` in `Enumerable`.
arr.each_slice(4){|a| puts a.join(",")}

# The `Tree` class was interesting, but it did not allow you to specify 
# a new tree with a clean user interface. Let the initializer accept a 
# nested structure of hashes. You should be able to specify a tree 
# like this: {'grandpa' => { 'dad' => { 'child 1' => {}, 'child 2' => {}}, 'uncle' => { 
# 'child 3' => {}. 'child 4' => {}}}}

class Tree
  attr_accessor :children, :node_name

  def self.build_from_hash(hash)
    node_name = hash.keys.first
    children = hash[node_name].map do |child, their_children|
      Tree.build_from_hash(child => their_children)
    end
    new(node_name, children)
  end

  def initialize(name, children=[])
    @node_name = name
    @children = children
  end

  def visit_all(&block)
    visit(&block)
    children.each{|c| c.visit_all(&block)}
  end

  def visit(&block)
    block.call(self)
  end
end

tree = Tree.build_from_hash({
  grandpa:{
    dad:{
      child_one: {},
      child_two: {}
    },
    uncle: {
      child_three: {},
      child_four: {}
    } 
  }
})

puts "Visiting top of tree..."
tree.visit{|n| puts n.node_name}
puts "Visiting entire tree..."
tree.visit_all{|n| puts n.node_name}


# Write a simple `grep` that will print the lines of a file having any occurrences of a 
# phrase anywhere in that line. You will need to do a simple regex match and read lines 
# from a file. If you want, include line numbers.

print "Enter phrase to search for>"
phrase = gets.chomp

File.open("#{__dir__}/day_2.txt").each_with_index do |line, line_number|
  puts "#{line_number}: #{line}" if line.include?(phrase)
end
