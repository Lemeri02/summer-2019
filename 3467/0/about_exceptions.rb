# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Lint/HandleExceptions, Metrics/MethodLength
# rubocop:disable Naming/RescuedExceptionsVariableName
# rubocop:disable Style/SignalException
# rubocop:disable Lint/UselessAssignment
# rubocop:disable Naming/MethodName

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:TooManyStatements
class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  # :reek:UncommunicativeMethodName
  def test_exceptions_inherit_from_Exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  # :reek:TooManyStatements
  def test_rescue_clause
    result = nil
    begin
      raise 'Oops'
    rescue StandardError => err
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, err.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, err.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', err.message
  end

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => err
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', err.message
  end

  def test_ensure_clause
    result = nil
    begin
      fail 'Oops'
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(MySpecialError) do
      raise MySpecialError, 'New instances can be raised directly.'
    end
  end
end
# rubocop:enable Naming/MethodName
# rubocop:enable Lint/HandleExceptions, Metrics/MethodLength
# rubocop:enable Naming/RescuedExceptionsVariableName
# rubocop:enable Style/SignalException
# rubocop:enable Lint/UselessAssignment
# rubocop:enable Lint/UnneededCopDisableDirective
