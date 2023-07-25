require 'pry'
require 'date'
module DateOfManufactureValidator
  # Validates the date_of_manufacture is valid and not in the future
  #
  # @param [Date] date_of_manufacture
  #
  # @return [Boolean] if validated
  # @return [String] as an error message

  def self.date_of_manufacture_validator(date_of_manufacture)
    current_year = Date.today.year # setting current_year as this year
    lower_limit_year = 1900 #as per the brief
    future_error_message = "Cannot be registered in the future"
    invalid_error = "Date_of_manufacture #{date_of_manufacture} is not valid"
  
    
    incoming_date_of_manufacture = Date.parse(date_of_manufacture) #parsing the string as a date
    incoming_year_of_manufacture = incoming_date_of_manufacture.year #extracting the year
    
    #using Proc to store the block of code in a variable for the case statement
    within_range = Proc.new{|incoming_year_of_manufacture| (incoming_year_of_manufacture >= lower_limit_year && incoming_year_of_manufacture < current_year)}
   
    case incoming_year_of_manufacture #case statement to determine the year
    when incoming_year_of_manufacture > current_year # and if the calculation gives a year greater than now
      future_error_message
    when within_range
      true
    else
      invalid_error #for dates less than the lower_limit year
    end
  end
end
