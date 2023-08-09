require_relative 'vrn_validator'
require 'rspec/expectations'
include RSpec::Matchers

# a unit test method to check different vrns, and determine if they are valid or invalid
def validation_test(valid)
  if valid == true
    return 'VRN valid'
  else
    return 'VRN invalid'
  end
end

  tests = { #batch of inputs against what is expected of the validation
    'BA72TGH' => 'VRN valid',
    'CK61VBM' => 'VRN valid',
    'AB55 CDE' => 'VRN valid',
    'ABCDEFG' => 'VRN invalid',
    '1111111' => 'VRN invalid',
    'AA00AAA' => 'VRN valid',
    'QA54BUN' => 'VRN valid',
    'IG55XYZ' => 'VRN valid',
    'JN34NLA' => 'VRN valid',
    'TK54TOM' => 'VRN valid',
    'UA55ATY' => 'VRN valid',
    'ZW34NLA' => 'VRN valid',
    '34AB567' => 'VRN invalid',
    'AQ72PLV' => 'VRN valid',
    'CI62JET' => 'VRN valid',
    ',B54THN' => 'VRN invalid',
    '?!45?!&' => 'VRN invalid',
    'AB12345' => 'VRN invalid',
    'AB55CDEF' => 'VRN invalid',
    '""' => 'VRN invalid'
  }

  tests.each_pair do |key, value|
    #trims the input if it has any whitespace within the string
    trimmed_key = key.chomp.upcase.gsub(' ', '')
    #gives the result of the validation as a boolean
    result = VrnValidator.validation(trimmed_key)
    #performs the above unit test
    validated = validation_test(result)
    #output of the test compared to the given input
    puts "Given input #{key} returns #{validated}"
    #expectation of the result of the test to equal what is expected
        expect(validated).to eq("#{value}") 
  end
