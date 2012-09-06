module MoneyPersistentBank
  class Railtie < Rails::Railtie

    initializer "money_persistent_bank.make_default" do
      require "money"
      require "money/bank/persistent_bank"
      Money.default_bank = Money::Bank::PersistentBank.new(Rails.cache)
    end

  end
end
