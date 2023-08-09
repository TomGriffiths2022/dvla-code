module ColourValidator
  # Validates the colour is one of the acceptable values
  #
  # @param [String] colour
  #
  # @return [Boolean]

  ACCEPTABLE_COLOURS = %w[White Black Red Blue]

  def self.colour_check(colour)
    # Checks that the incoming colour is one of the acceptable values, if not return false
    ACCEPTABLE_COLOURS.any?{ |vehicle_colour| vehicle_colour.casecmp(colour)==0 }
  end

end