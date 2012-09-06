require "rails/railtie"

module MoneyPersistentBank
  class Railtie < Rails::Railtie
    initializer "money_persistent_bank.make_default" do
      require "money"
      require "money/bank/persistent_bank"
      Money.default_bank = Money::Bank::PersistentBank.new(Rails.cache)
    end

    initializer "money_persistent_bank.middleware" do
      app.config.middleware.use Synchronization
    end
  end

  # Updates rates from the cache on each request
  class Synchronization
    def initialize app, bank = Money.default_bank
      @app = app
      @bank = bank
    end

    def call env
      @bank.import_rates
      @app.call env
    end
  end
end
