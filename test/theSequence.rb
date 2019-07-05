# this file is meant to serve as skill test
#!/usr/bin/env ruby
@primary_job = '' # the variable that stores the job letter
@dep_job = '' # the variable that stores the dependency job letter
@entered_jobs = '' # the string that stores processed input
@shadow = '' # the string that stores raw input, in the order that enters from keyboard
             # @shadow will be processed and used to find circular dependencies
             # with the help of Floyd's cycle detection algorithm ("hare and tortoise")
@slow = ''
@quick = '' # @slow and @quick are the 2 vars to be compared for equality.
            # @slow will cycle through @shadow one index at the time whilst @quick will do by 2 indexes at the time

def capture_primary_job
  # guard clauses are used within this method
  puts 'Please enter the PRIMARY job letter: '
  puts '(Enter \'0\' if there is no primary job left)'
  @primary_job = gets.chomp
  # the following block repeats until only one letter is entered
  while @primary_job.length > 1
  # an error message will follow due to introduction of more than one character
  puts 'The job should be entered as one letter only. Please enter again: ' if @primary_job.length > 1
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

def swap_last_two
  # the conditional checks if the primary_job and dep_job values are UNIQUE in the string
  # if unique, they can swap so the dependency job will precede the primary job
  temp_swap = '' # initializing local var for stability
  if @dep_job != '0' && @entered_jobs.count(@primary_job) == 1 && @entered_jobs.count(@dep_job) == 1
  temp_swap = @entered_jobs[-1]
  @entered_jobs[-1] = @entered_jobs[-2]
  @entered_jobs[-2] = temp_swap
  end
end

def insert_dependency
  # this function kicks in when freshly introduced primary_job exists already from a previous capture
  # the line below will delete the freshly appended primary_job if its value is already in string ()
  # so only the letter with a lower index will stay
  find_index = 0 # initializing local var for stability
  @entered_jobs.delete(@entered_jobs[-1]) #if @entered_jobs.count(@primary_job) > 1
  @entered_jobs.delete(@entered_jobs[-1]) #if @entered_jobs.count(@primary_job) > 1
  find_index = @entered_jobs.index(@primary_job) # @primary_job != '0'
  # @entered_jobs.insert((find_index - 1), @dep_job) if @entered_jobs.count(@primary_job) > 1
  puts find_index
  puts @entered_jobs
end

def self_dependency_check
  # this function checks dep_job against primary_job for identical values (self dependency)
  puts 'A job can\'t depend on itself, please enter another letter' if @entered_jobs[-1] == @dep_job && @primary_job != '0'
  capture_dependency_job if @entered_jobs[-1] == @dep_job && @primary_job != '0'
  @entered_jobs << @dep_job
end

def circular_dependency_detector
  c_quick = ''
  i = 0
  @shadow.each_char { |c_slow| @slow << c_slow }
  @quick = while c_quick != ''
             c_quick = @shadow[i]
             @quick << c_quick
             i += 2
           end
  while @slow[i] != '' && @quick[i] != '' #check if iteration is in range
    if @slow[i] == @quick[i]
      puts "/!'\\' ERROR! The jobs can't have circular dependencies "
    end
    break if i == 20 # endless loop breaker
  end

end

#===================== M A I N =====================================
# main body of the program
while @primary_job != '0'
  capture_primary_job
  #@shadow << @primary_job if @primary_job != '0'
  puts @entered_jobs if @primary_job == '0' # displays the final form of ordered string when kill switch '0' is entered
  capture_dependency_job if @primary_job != '0' # I could have written && @primary_job != @dep_job in order to avoid
                                                # self dependency first hand. I prefered though to have entered data
                                                # saved in string in order to avoid losing it along iterations
  #@shadow << @dep_job if @primary_job != '0'
  @entered_jobs << @primary_job if @primary_job != '0'
  self_dependency_check
  @entered_jobs[-1] = '' if @dep_job == '0'
  # the line below will swap values, so the dependency will be positioned in front of primary job.
  swap_last_two
  insert_dependency #if @dep_job != '0' #&& @entered_jobs.count(@primary_job) > 1# || @entered_jobs.count(@dep_job) > 1)
  #circular_dependency_detector
  #puts @entered_jobs if @primary_job == '0' # displays the final form of ordered string when kill switch '0' is entered
end
#insert_dependency