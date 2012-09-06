require "bundler/setup"
require 'minitest/autorun'
require 'money'
require "yaml"
$:.unshift(File.expand_path('../../lib', __FILE__))
require "money_persistent_bank"
require "active_support/cache"

class PersistentBankTest < MiniTest::Unit::TestCase
  include Money::Bank

  def setup
    @storage = ActiveSupport::Cache::MemoryStore.new
    @writer = PersistentBank.new(@storage)
    @reader = PersistentBank.new(@storage)
  end

  def test_persistance
    @writer.writing{ @writer.add_rate('USD', 'AZN', 123) }
    assert_nil @reader.get_rate('USD', 'AZN')
    assert_equal 123, @reader.reading{ @reader.get_rate('USD', 'AZN') }
  end

  def test_clear
    @writer.writing { |b| b.add_rate('USD', 'AZN', 123) }

    refute_nil @reader.reading { |b| b.get_rate('USD', 'AZN') }
    @writer.clear

    assert_nil @reader.reading { |b| b.get_rate('USD', 'AZN') }
  end
end
