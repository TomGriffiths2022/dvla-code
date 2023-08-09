module VrnValidator
  # Validates the vrn is in the correct format and length
  #
  # @param [String] vrn
  #
  # @return [Boolean]

  def self.validation(vrn)
    # regex will match the vrn input and compare against permitted values
    # as per the brief. The \s? in the regex indicates that there could be an optional whitespace
    # between the digits and the final set of letters
    # if vrn does not match this exactly, format and length then it returns false
    vrn.match?(/^[A-Za-z]{2}[0-9]{2}\s?[A-Za-z]{3}$/)      # returns true if the vrn is valid
  end
end

# Testing considerations - different formats of vrn
