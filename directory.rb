# method to add students

def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  # create empty array
  students = []
  months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
  	]
  # get the first name
  name = gets[0...-1].capitalize
  while !name.empty? do
  	puts "Cohort?"
  	cohort = gets[0...-1].capitalize
    while !months.include? cohort
      puts "Typo. Try again. Cohort?"
  	  cohort = gets[0...-1].capitalize
    end
  	if cohort.length == 0
  	  cohort = "WHATEVER"
  	end
    students << {name: name, cohort: cohort.to_sym}
    word = "student"
    if students.count > 1
      word << "s"
    end
    puts "Now we have #{students.count} #{word}"
    name = gets[0...-1].capitalize
  end
  students
end

# methods to print

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(names)

# using each

#  names.each_with_index do |student, index|
#  	if student[0] == "D" && student.length < 12
#      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end

# using while

#  name_index = 0
#  while name_index < names.length do
#    puts ((name_index + 1).to_s + ". " + names[name_index][:name] + " (" + names[name_index][:cohort].to_s + " cohort)").center(50)
#    name_index += 1
#  end

# puts according to cohort

  months = {
      January: [],
      February: [],
      March: [],
      April: [],
      May: [],
      June: [],
      July: [],
      August: [],
      September: [],
      October: [],
      November: [],
      December: []
  }

  names.each { |x|
    months[x[:cohort]].push(x[:name])
  }

  months.each { |k,v|
    if v != []
  	  puts k.to_s + " cohort:"
  	  puts v
  	  puts "-------------"
    end
  }

end

def print_footer(names)
  word = "student"
  if names.length() > 1
    word << "s"
  end
  puts "Overall, we have #{names.count} great " + word
end

# calling methods

students = input_students

if students.count > 0
  print_header
  print(students)
  print_footer(students)
end
