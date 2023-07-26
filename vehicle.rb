class Vehicle

  attr_accessor :vehicle

  def self.validated(vehicle)
    # creates an array with all error messages for any vehicle
    errors = []
    errors << "Invalid VRN" if VrnValidator.validation(vehicle[:vrn]) != true
    errors << "Invalid make" if MakeValidator.make_check(vehicle[:make]) != true
    errors << "Invalid colour" if ColourValidator.colour_check(vehicle[:colour]) != true
    errors << DateOfManufactureValidator.date_of_manufacture_validator(vehicle[:dateofmanufacture]) unless DateOfManufactureValidator.date_of_manufacture_validator(vehicle[:dateofmanufacture]) == true
    errors
  end

  def initialize(vehicle, errors: nil)
    vehicle_object = Hash.new()
    # If errors are present, use them in the vehicle object
    if errors
      vehicle_object["vrn"] = vehicle[:vrn]
      vehicle_object["make"] = vehicle[:make]
      vehicle_object["colour"] = vehicle[:colour]
      vehicle_object["date_of_manufacture"] = vehicle[:date_of_manufacture]
      vehicle_object["errors"] = errors
    else
      # If no errors are present, then omit them from the object
      vehicle_object["vrn"] = vehicle[:vrn].upcase.gsub(/\s+/, "").insert(4, ' ') #removes whitespace from within the vrn then inserts the whitespace in the correct position (index 4 of the string)
      vehicle_object["make"] = (vehicle[:make].casecmp('BMW')==0 || vehicle[:make].casecmp('VW')==0) ? vehicle[:make].upcase : vehicle[:make].capitalize # if the make of the vehicle matches either BMW or VW (irrespective of case) then upcase the string, else capitalise the string
      vehicle_object["colour"] = vehicle[:colour].capitalize
      vehicle_object["date_of_manufacture"] = Date.parse(vehicle[:date_of_manufacture]).strftime('%a, %-d %B %Y')
    end
    @vehicle = vehicle_object
  end

  def self.calculate_valid_vehicles
    # Calculates the valid vehicles extracted from the original vehicles.csv
    number_of_valid_vehicles = CSV.read('valid_vehicles.csv').count
    puts "Number of valid vehicles in 'vehicles.csv' file is #{number_of_valid_vehicles}"
  end
  
  def self.calculate_invalid_vehicles
    # Calculates the invalid vehicles extracted from the original vehicles.csv
    number_of_invalid_vehicles = CSV.read('invalid_vehicles.csv').count
    puts "Number of invalid vehicles in 'vehicles.csv' file is #{number_of_invalid_vehicles}"
  end
end

#Testing consideration for entire app - testing comes from unit tests and create api for functional testing
#Improvement - get headers in csv output files to be present
#Improvement- use db for data as it will prevent potential duplication (primary keys VRN?)
#Improvement - check for duplication of data
#Questions for BA - can they have multiple colours, are all fields mandatory, different formats of vrn etc.
#Unit test individual functions