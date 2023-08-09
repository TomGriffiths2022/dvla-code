require_relative 'vrn_validator'
require_relative 'colour_validator'
require_relative 'date_of_manufacture_validator'
require_relative 'make_validator'
require_relative 'vehicle'

require 'csv'

def input_from_file
# Receive a file of vehicle data which are to be validated, and if valid write to valid_vehicles.csv file
# If not valid then write to invalid_vehicles.csv file with original data and errors
puts "Analysing vehicles.csv file"
valid_vehicles = []
invalid_vehicles = []
  table = CSV.foreach('vehicles.csv', headers: true, header_converters: :symbol) do |row|
    vrn = row[:vrn]
    make = row[:make]
    colour = row[:colour]
    date_of_manufacture = row[:dateofmanufacture]
    
    # Validation on the individual components of the vehicle
    VrnValidator.validation(vrn) 
    MakeValidator.make_check(make)
    ColourValidator.colour_check(colour)
    DateOfManufactureValidator.date_of_manufacture_validator(date_of_manufacture)
    
    # Validate the row of data
    errors = Vehicle.validated(row)
    if errors.empty?
      # If there are no errors, produce a valid vehicle
      valid_vehicle = Vehicle.new({vrn: vrn, make: make, colour: colour, date_of_manufacture: date_of_manufacture})
      # Add the valid vehicle to the valid_vehicles array
      valid_vehicles << valid_vehicle.vehicle
    else
      # If there are errors, produce an invalid vehicle
      invalid_vehicle = Vehicle.new({vrn: vrn, make: make, colour: colour, date_of_manufacture: date_of_manufacture}, errors: errors)
      # Add the invalid vehicle to the invalid_vehicles array
      invalid_vehicles << invalid_vehicle.vehicle
    end
  end
  write_to_file(valid_vehicles: valid_vehicles)
  write_invalid_vehicles_to_file(invalid_vehicles: invalid_vehicles)
  puts "All vehicles have been validated"
end

def write_to_file(valid_vehicles:)
# Read the valid_vehicles.json file
  file = File.read('valid_vehicles.json')
  array = JSON.parse(file)
  array["valid_vehicles"] = []
# Add each valid_vehicle to the array
  valid_vehicles.each do |vehicle|
    array["valid_vehicles"] << vehicle
  end
# Open the valid_vehicles.json file ready for writing
  File.open("valid_vehicles.json", "w") do |f|
    f.write(JSON.pretty_generate(array))
  end
end

def write_invalid_vehicles_to_file(invalid_vehicles:)
  # Read the invalid_vehicles.json file
  file = File.read('invalid_vehicles.json')
  array = JSON.parse(file)
  array["invalid_vehicles"] = []
# Add each invalid_vehicle to the array
  invalid_vehicles.each do |vehicle|
    array["invalid_vehicles"] << vehicle
  end
  # Open the invalid_vehicles.json file ready for writing
  File.open("invalid_vehicles.json", "w") do |f|
    f.write(JSON.pretty_generate(array))
  end
end

input_from_file
Vehicle.calculate_valid_vehicles
Vehicle.calculate_invalid_vehicles

# Consideration - refactor the writing to file to be more efficient?
# Consideration - use the console interactively if needed more functionality



