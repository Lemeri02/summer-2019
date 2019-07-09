require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutVariableScope < Neo::Koan
  def bark
    # rubocop:disable Lint/UselessAssignment
    noise = 'RUFF'
    # rubocop:enable Lint/UselessAssignment
  end

  def test_noise_is_not_available_in_the_current_scope
    assert_raise(NameError) do
      noise
    end
  end

  def test_we_can_get_noise_by_calling_method
    assert_equal 'RUFF', bark
  end
  
  # rubocop:disable Lint/UselessAssignment
  inaccessible = 'Outside our universe'
  # rubocop:enable Lint/UselessAssignment
  def test_defs_cannot_access_variables_outside_scope
    # defined? does not return true or false
    assert_equal nil, defined? inaccesible
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
      x = 0
    end
    assert_equal nil, defined? x
  end

  # ------------------------------------------------------

  class Mouse
    attr_reader @name
    # rubocop:disable all
    @@total = 0
    # rubocop:enable all
    # Class variables are prefixed with two '@' characters.
    # rubocop:disable Naming/UncommunicativeMethodParamName
    def initialize(n)
      # rubocop:enable Naming/UncommunicativeMethodParamName
      @name = n
      # Instance variables are prefixed with one '@' character.
      # rubocop:disable all
      @@total += 1
      # rubocop:enable all
    end

    def name
      @name
    end

    def Self.count
      @@total
    end
  end

  def test_instance_variable
    oscar = Mouse.new('Oscar')
    assert_equal 'Oscar', oscar.name
  end

  def test_class_variable
    (1..9).each { |i| Mouse.new(i.to_s) }
    assert_equal 10, Mouse.count
  end
  # rubocop:disable Style/GlobalVars
  $anywhere = 'Anywhere'
  # rubocop:enable Style/GlobalVars
  # Global variables are prefixed with the '$' character.

  def test_global_variables_can_be_accessed_from_any_scope
    assert_equal 'Anywhere', $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope
    # From within a method
    # rubocop:disable Style/GlobalVars
    $anywhere = 'Here'
    # rubocop:enable Style/GlobalVars
    assert_equal 'Here', $anywhere
  end

  def test_global_variables_retain_value_from_last_change
    # What is $anywhere?
    assert_equal 'Here', $anywhere
  end

  def test_global_variables_can_be_changed_from_any_scope_2
    # From within a block
    2.times do
      $anywhere = 'Hey'
    end

    assert_equal 'Hey', $anywhere
  end
end
