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
    @writer.add_rate('USD', 'AZN', 123)
    @writer.export_rates
    assert_nil @reader.get_rate('USD', 'AZN')
    @reader.import_rates
    assert_equal 123, @reader.get_rate('USD', 'AZN')
  end

  def test_clear
    @writer.add_rate('USD', 'AZN', 123)
    @writer.export_rates

    @reader.import_rates
    refute_nil @reader.get_rate('USD', 'AZN')

    @writer.clear

    @reader.import_rates
    assert_nil @reader.get_rate('USD', 'AZN')
  end
end
