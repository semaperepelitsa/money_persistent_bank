module MoneyPersistentBank
  class Railtie < Rails::Railtie

    initializer "money_persistent_bank.default_storage" do
      Money::Bank::PersistentBank.default_storage = Rails.cache
    end

    initializer "money_persistent_bank.make_default" do
      Money.default_bank = Money::Bank::PersistentBank.instance
    end

  end
end
