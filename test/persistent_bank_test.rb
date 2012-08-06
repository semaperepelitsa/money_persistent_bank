require "bundler/setup"
require 'minitest/autorun'
require 'money'
require "yaml"
$:.unshift(File.expand_path('../../lib', __FILE__))
require "money_persistent_bank"
require "active_support/cache"

STORAGE = ActiveSupport::Cache::MemoryStore.new
Money::Bank::PersistentBank.default_storage = STORAGE

class PersistentBankTest < MiniTest::Unit::TestCase
  include Money::Bank

  def test_instance
    assert_equal PersistentBank, PersistentBank.instance.class
  end

  def setup
    STORAGE.clear
  end

  def test_persistance
    pb = PersistentBank.new
    pb.add_rate('USD', 'AZN', 123)

    assert_nil PersistentBank.new.get_rate('USD', 'AZN')

    pb.save!
    assert_equal 123, PersistentBank.new.get_rate('USD', 'AZN')
  end

  def test_destroy
    PersistentBank.instance.add_rate('USD', 'AZN', 123)
    PersistentBank.instance.save!

    refute_nil PersistentBank.instance.get_rate('USD', 'AZN')
    refute_nil PersistentBank.new.get_rate('USD', 'AZN')
    PersistentBank.instance.destroy

    assert_nil PersistentBank.instance.get_rate('USD', 'AZN')
    assert_nil PersistentBank.new.get_rate('USD', 'AZN')
  end

  def test_updating_rates
    assert_nil PersistentBank.instance.get_rate('USD', 'AZN')
    PersistentBank.new.tap{|b| b.add_rate('USD', 'AZN', 123)}.save!
    assert_equal 123, PersistentBank.instance.get_rate('USD', 'AZN')
  end

  def test_rates_also_trigger_update
    assert_nil PersistentBank.instance.get_rate('USD', 'AZN')
    PersistentBank.new.tap{|b| b.add_rate('USD', 'AZN', 123)}.save!
    assert_equal({ "USD_TO_AZN" => 123 }, PersistentBank.instance.rates)
  end
end
