# method to add students

@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  #array for spellcheck
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
  name = gets[0...-1].capitalize
  # get name etc
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
    # push to array
    @students << {name: name, cohort: cohort.to_sym}
    word = "student"
    if @students.count != 1
      word << "s"
    end
    puts "Now we have #{@students.count} #{word}"
    name = gets[0...-1].capitalize
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

  @students.each { |x|
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

def print_footer()

  word = "student"
  if @students.length() != 1
    word << "s"
  end
  puts "Overall, we have #{@students.count} great " + word
  puts "-------------"
end

# blahblah



def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
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
    else
      puts "I don't know what you mean, try again"      
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu