require "rails/railtie"

module MoneyPersistentBank
  class Railtie < Rails::Railtie
    initializer "money_persistent_bank" do |app|
      require "money"
      require "money/bank/persistent_bank"
      bank = Money::Bank::PersistentBank.new(Rails.cache)
      Money.default_bank = bank
      app.config.middleware.use Synchronization, bank
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
