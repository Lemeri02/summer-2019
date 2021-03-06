require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = {}
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { one: 'uno', two: 'dos' }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { one: 'uno' }
    assert_equal 'uno', hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
  end

  def test_changing_hashes
    hash = { one: 'uno', two: 'dos' }
    hash[:one] = 'eins'

    expected = { one: 'eins', two: 'dos' }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  def test_hash_is_unordered
    hash_one = { one: 'uno', two: 'dos' }
    hash_two = { two: 'dos', one: 'uno' }

    assert_equal true, hash_one == hash_two
  end

  def test_hash_keys
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.key?(:one)
    assert_equal true, hash.key?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.values.size
    assert_equal true, hash.value?('uno')
    assert_equal true, hash.value?('dos')
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { 'jim' => 53, 'amy' => 20, 'dan' => 23 }
    new_hash = hash.merge('jim' => 54, 'jenny' => 26)

    assert_equal true, hash != new_hash

    expected = { 'jim' => 54, 'amy' => 20, 'dan' => 23, 'jenny' => 26 }
    assert_equal true, expected == new_hash
  end

  # :reek:TooManyStatements
  def test_default_value
    hashone = {}
    hashone[:one] = 1

    assert_equal 1, hashone[:one]
    assert_equal nil, hashone[:two]

    hashtwo = Hash.new('dos')
    hashtwo[:one] = 1

    assert_equal 1, hashtwo[:one]
    assert_equal 'dos', hashtwo[:two]
  end

  # rubocop:disable Metrics/AbcSize
  # :reek:TooManyStatements, :reek:FeatureEnvy
  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal %w[uno dos], hash[:one]
    assert_equal %w[uno dos], hash[:two]
    assert_equal %w[uno dos], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end
  # rubocop:enable Metrics/AbcSize

  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_default_value_with_block
    hash = Hash.new { |_hash, key| hash[key] = [] }

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal ['uno'], hash[:one]
    assert_equal ['dos'], hash[:two]
    assert_equal [], hash[:three]
  end
end
