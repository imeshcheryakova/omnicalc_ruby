class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    @text_capitalize_all = []
    @text.split.each do |word|
      @text_capitalize_all.push(word.capitalize)
    end
    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.count

    @occurrences = @text_capitalize_all.count(@special_word.capitalize)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    if @apr>1
      @monthly_rate = @apr/12/100
    else
      @monthly_rate = @apr/12
      @apr = @apr*100
    end

    @denominator=((@monthly_rate+1)**(@years*12))-1
    @fraction=@monthly_rate/@denominator
    @rateandfraction=@fraction+@monthly_rate


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @rateandfraction*@principal

  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)


    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    #Median calculation for even array

    @count_middle=@count/2
    @position1=@count_middle-0.5
    @position2=@count_middle+0.5
    @number1=@sorted_numbers[@position1]
    @number2=@sorted_numbers[@position2]

    #Median calculation for odd array
    @count_middle_even=@count/2

    if @count%2 == 0
      @median = (@number1+@number2)/2
    else
      @median=@sorted_numbers[@count_middle_even]
    end

# Sum calculation without using .sum
    @sum=0
    @numbers.each do |integer|
      @sum=@sum+integer
    end

    @mean = @sum/@count

# Variance calculation

    @sum_distances=0
    @numbers.each do |element|
      @sum_distances=(@sum_distances+(element-@mean)**2)

    end

    @variance = @sum_distances/@count

    @standard_deviation = Math.sqrt(@variance)

    #Mode calculation

    number_with_largest_count = 0
    largest_count_so_far = 0

    @numbers.each do |number|
      if @numbers.count(number)>largest_count_so_far
        number_with_largest_count = number
        largest_count_so_far = @numbers.count(number)
      end
    end

    if largest_count_so_far==1
     @mode ="no mode"
    else
      @mode = number_with_largest_count
    end

  end
end
