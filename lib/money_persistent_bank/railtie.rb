module MoneyPersistentBank
  class Railtie < Rails::Railtie

    initializer "money_persistent_bank.default_storage" do
      require "money/bank/persistent_bank"
      Money::Bank::PersistentBank.default_storage = Rails.cache
    end

    initializer "money_persistent_bank.make_default" do
      require "money"
      require "money/bank/persistent_bank"
      Money.default_bank = Money::Bank::PersistentBank.instance
    end

  end
end
