# frozen_string_literal: true

# rubocop: disable Style/GlobalVars

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:ClassVariable

class Mouse
  @total = 0
  # Class variables are prefixed with two '@' characters.

  def initialize(name)
    @name = name
    # Instance variables are prefixed with one '@' character.
    @total += 1
  end

  attr_reader :name

  def self.count
    @total
  end
end

# :reek:UncommunicativeMethodName
# :reek:UncommunicativeVariableName
# :reek:InstanceVariableAssumption
class AboutVariableScope < Neo::Koan
  # :reek:InstanceVariableAssumption
  def bark
    @noise = 'RUFF'
  end

  def test_noise_is_not_available_in_the_current_scope
    assert_raise(NameError) do
      @noise
    end
  end

  def test_we_can_get_noise_by_calling_method
    assert_equal 'RUFF', bark
  end

  @inaccessible = 'Outside our universe'
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal nil, defined? @inaccesible
  end

  # ------------------------------------------------------

  def test_blocks_can_access_variables_outside_scope
    test = 'Hi'
    2.times do
      test = 'Hey'
    end
    assert_equal 'Hey', test
  end

  def test_block_variables_cannot_be_accessed_outside_scope
    2.times do
      x
    end
    assert_equal nil, x.defined?
  end

  # ------------------------------------------------------

  def test_instance_variable
    oscar = Mouse.new('Oscar')
    assert_equal 'Oscar', oscar.name
  end

  # :reek:UncommunicativeVariableName
  def test_class_variable
    (1..9).each { |i| Mouse.new(i.to_s) }
    # Things may appear easier than they actually are.
    assert_equal 10, Mouse.count
  end

  # Meditate on the following:
  # What is the difference between a class variable and instance variable?

  # ------------------------------------------------------

  $anywhere = 'Anywhere'
  # Global variables are prefixed with the '$' character.

  def test_global_variables_can_be_accessed_from_any_scope
    assert_equal 'Anywhere', $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope
    # From within a method
    $anywhere = 'Here'
    assert_equal 'Here', $anywhere
  end

  def test_global_variables_retain_value_from_last_change
    # What is $anywhere?
    assert_equal 'Here', $anywhere
  end

  # :reek:UncommunicativeVariableName
  def test_global_variables_can_be_changed_from_any_scope_2
    # From within a block
    $anywhere = 'Hey'
    2.times do
      $anywhere
    end
    assert_equal 'Hey', $anywhere
  end
end

# rubocop: enable Style/GlobalVars
