# FIND

# Find the Ruby API
  # https://ruby-doc.org/

# Find free online version of "Programming Ruby: The Pragmatic Programmer's Guide"
  # http://ruby-doc.com/docs/ProgrammingRuby/

# Find a method that substitutes part of a string
  # sub() - to replace first instance
  # gsub() - to replace all instances

# Find information about ruby regular expressions
  # https://www.rubyguides.com/2015/06/ruby-regex/

# Find information about ruby ranges
  # https://www.techotopia.com/index.php/Ruby_Ranges

# DO

# Print the string 'Hello, world.'
puts 'Hello, world.'

# For the string 'Hello, Ruby.", find the index of the word "Ruby."
"Hello, Ruby.".index("Ruby.")

# Print your name ten times
10.times{puts "Jake"}

# Print the string "This is sentence number 1." where the number 1 changes from 1 to 10
(1..10).each{|i| puts "This is sentence number #{i}."}

# Run a ruby program from a file
  # Just run this file: ruby day_1.rb

# Write program for number guessing game
num = rand(10) + 1 # random number from 1 to 10
print "Enter guess>"
guess = gets.chomp.to_i
while(guess != num) do
  puts "Too low!" if guess < num
  puts "Too high!" if guess > num
  print "Guess again>"
  guess = gets.chomp.to_i
end
puts "You guessed it! It was #{num}!"
