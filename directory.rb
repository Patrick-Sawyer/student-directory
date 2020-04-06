# open csv file

@students = []

def load_students(filename = "students.csv")
  file = File.open(filename,"r")
  file.readlines.each{ |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  }
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

# method to add students

def input_students
  puts "-------------"
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"

  # array for spellcheck

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
  name = STDIN.gets[0...-1].capitalize

  # get name etc

  while !name.empty? do
  	puts "Cohort?"
  	cohort = STDIN.gets[0...-1].capitalize
    while !months.include? cohort
      puts "Typo. Try again. Cohort?"
  	  cohort = STDIN.gets[0...-1].capitalize
    end
  	if cohort.length == 0
  	  cohort = "WHATEVER"
  	end

    # push to array

    @students << {name: name, cohort: cohort.to_sym}
    word = "student"
    if @students.count != 1
      word << "s"
    end
    puts "Now we have #{@students.count} #{word}"
    name = STDIN.gets[0...-1].capitalize
  end
end

# methods to print

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list()

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

  @students.each { |student|
    months[student[:cohort]].push(student[:name])
  }

  months.each { |k,v|
    if v != []
  	  puts k.to_s + " cohort:"
  	  puts v
  	  puts "-------------"
    end
  }

end

def print_footer()

  word = "student"
  if @students.length() != 1
    word << "s"
  end
  puts "Overall, we have #{@students.count} great " + word
  puts "-------------"
end

# menu

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save to students.csv"
  puts "4. Load students.csv"
  puts "9. Exit"
  puts "-------------"
end

def show_students()
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"      
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

# saving

def save_students
  file = File.open("students.csv", "w")
  @students.each { |student|
    student_data = [student[:name]],[student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  file.close
end

# call menu method

try_load_students
interactive_menu



