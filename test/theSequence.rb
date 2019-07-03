# this file is meant to serve as skill test
#!/usr/bin/env ruby
@primary_job = '' # the variable that stores the job letter
@dep_job = '' # the variable that stores the dependency job letter
@entered_jobs = '' # the variable that stores raw input
@ordered_jobs = '' # the variable that stores the ordered jobs

def capture_primary_job
  # guard clauses are used within this method
  puts 'Please enter the primary job letter: '
  @primary_job = gets.chomp
  # the following block repeats until only one letter is entered
  while @primary_job.length > 1
  # an error message will follow due to introduction of more than one character
  puts 'The job should be entered as one letter only. Please enter again: '\
  if @primary_job.length > 1
  @primary_job = gets.chomp if @primary_job.length > 1
  end
end

def capture_dependency_job
  # guard clauses are used within this method
  puts 'Please now enter the dependency job letter: '
  puts '(Enter \'0\' if there is no dependency.)'
  @dep_job = gets.chomp
  # the following block repeats until only one letter is entered
  while @dep_job.length > 1 # an error message will follow due to introduction of more than one character
    puts 'The dep job should be entered as one letter only. Please enter again: ' if @dep_job.length > 1
    @dep_job = gets.chomp if @dep_job.length > 1
  end

end

while @primary_job != '0'
  capture_primary_job
  @entered_jobs << @primary_job if @primary_job != '0'
  puts @entered_jobs if @primary_job == '0' # displays the final form of ordered string when kill switch '0' is entered
  capture_dependency_job if @primary_job != '0'
  puts 'A job can\'t depend on itself, please enter another letter' if @entered_jobs[-1] == @dep_job && @primary_job != '0'
  capture_dependency_job if @entered_jobs[-1] == @dep_job && @primary_job != '0'
  @entered_jobs << @dep_job
  @entered_jobs[-1] = '' if @dep_job == '0' # it cuts the '0' trailing in the string
#puts @entered_jobs
end
