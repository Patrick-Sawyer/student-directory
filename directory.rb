# open csv fil

require 'csv'

@students = []

def load_students(filename = "students.csv")
  if File.exists?(filename)
    @students = []
    file = File.open(filename,"r")
    CSV.parse(file) do |row|
      @students << {name: row[0], cohort: row[1].to_sym}
    end
    puts "Loaded #{@students.count} from #{filename}"
    puts "-------------"
  else
    puts "No such file"
    puts "-------------"
  end
end

def add(name,cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first
  if filename == nil
    load_students
    return
  end
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

# method to add students

def input
  STDIN.gets[0...-1].capitalize
end

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

  name = input

  # get name etc

  while !name.empty? do
  	puts "Cohort?"
  	cohort = input
    while !months.include? cohort
      puts "Typo. Try again. Cohort?"
  	  cohort = input
    end

    # push to array

    add(name,cohort)
    word = "student"
    if @students.count != 1
      word << "s"
    end
    puts "Now we have #{@students.count} #{word}. Type another or press Enter"
    name = input
  end
end

# methods to print

def print_header
  puts "-------------"
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
  puts "3. Save"
  puts "4. Load"
  puts "5. Print source code to screen"
  puts "9. Exit"
  puts "-------------"
end

def show_students()
  print_header
  print_students_list
  print_footer
end

def source_code
  puts File.open("directory.rb","r").read
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
      puts "Which file would you like to load?"
      filename = STDIN.gets.chomp
      load_students(filename)
    when "5"
      source_code
    when "9"
      puts "-------------"
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
  puts "Which file would you like to write on?"
  filename = STDIN.gets.chomp
  CSV.open(filename, "wb") do |csv|
  	@students.each { |student|
  		csv << [student[:name],student[:cohort]]
  	}
  end
  puts "Save successful"
  puts "-------------"
end

# call menu method

try_load_students
interactive_menu



