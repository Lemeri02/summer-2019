require File.expand_path(File.dirname(__FILE__) + '/neo')
# :reek:TooManyStatements, :reek:UncommunicativeMethodName, :reek:UncommunicativeVariableName
class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  # rubocop:disable Style/SignalException
  def test_rescue_clause # rubocop:disable Metrics/MethodLength
    result = nil
    begin
      fail 'Oops'
    rescue StandardError => e
      result = :exception_handled
    end
    assert_equal :exception_handled, result
    assert_equal true, e.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, e.is_a?(RuntimeError),  'Should be a Runtime Error'
    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'
    assert_equal 'Oops', e.message
  end
  # rubocop:enable Style/SignalException

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => e
      result = :exception_handled
    end
    assert_equal :exception_handled, result
    assert_equal 'My Message', e.message
  end

  # rubocop:disable UselessAssignment
  # rubocop:disable HandleExceptions
  # rubocop:disable Style/SignalException
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
  # rubocop:enable UselessAssignment
  # rubocop:enable HandleExceptions
  # rubocop:enable Style/SignalException

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(MySpecialError) do
      raise MySpecialError, 'New instances can be raised directly.'
    end
  end
end
