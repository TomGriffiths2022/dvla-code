require_relative 'vrn_validator'
require_relative 'colour_validator'
require_relative 'date_of_manufacture_validator'
require_relative 'make_validator'
require_relative 'vehicle'

require 'pry'
require 'csv'

def input_from_file
# Receive a file of vehicle data which are to be validated, and if valid write to valid_vehicles.csv file
# If not valid then write to invalid_vehicles.csv file with original data and errors
puts "Analysing vehicles.csv file"
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
      write_to_file(valid_vehicle: valid_vehicle.vehicle)
    else
      # If there are errors, produce an invalid vehicle
      invalid_vehicle = Vehicle.new({vrn: vrn, make: make, colour: colour, date_of_manufacture: date_of_manufacture}, errors: errors)
      write_invalid_vehicles_to_file(invalid_vehicle: invalid_vehicle.vehicle)
    end
  end
    puts "All vehicles have been validated"
end

def write_to_file(valid_vehicle:)
  # Create the headers for the data
  headers = ["vrn", "make", "colour", "dateOfManufacture"]
  CSV.open('valid_vehicles.csv', 'a') do |csv|
    row = CSV::Row.new(headers, [])
    row["vrn"] = valid_vehicle["vrn"]
    row["make"] = valid_vehicle["make"]
    row["colour"] = valid_vehicle["colour"]
    row["dateOfManufacture"] = valid_vehicle["date_of_manufacture"]
    csv << row
    end
  end


def write_invalid_vehicles_to_file(invalid_vehicle:)
  # Create the headers for the data, including errors
  headers = ["vrn", "make", "colour", "dateOfManufacture", "errors"]
  CSV.open('invalid_vehicles.csv', 'a+') do |csv|
    row = CSV::Row.new(headers, [])
    row["vrn"] = invalid_vehicle["vrn"]
    row["make"] = invalid_vehicle["make"]
    row["colour"] = invalid_vehicle["colour"]
    row["dateOfManufacture"] = invalid_vehicle["date_of_manufacture"]
    row["errors"] = invalid_vehicle["errors"].join(',')
    csv << row
    end
end

input_from_file
Vehicle.calculate_valid_vehicles
Vehicle.calculate_invalid_vehicles



