# method to add students

def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  # create empty array
  students = []
  # get the first name
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

# methods to print

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(names)
  names.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# calling methods

students = input_students
print_header
print(students)
print_footer(students)
