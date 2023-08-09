module MakeValidator
  # Validates the make is one of the acceptable values
  #
  # @param [String] make
  #
  # @return [Boolean]

  ACCEPTABLE_MAKES = %w[BMW Audi VW Mercedes]
  
  def self.make_check(make)
    # Checks that the incoming make is one of the acceptable values, if not return false
    ACCEPTABLE_MAKES.any?{ |vehicle_make| vehicle_make.casecmp(make)==0 }
  end
end