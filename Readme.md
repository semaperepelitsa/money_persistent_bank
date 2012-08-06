# Money Persistent Bank

["Money" gem][money] provides VariableExchange which is useful for converting money from one currency to another. This gem provides PersistentBank which can save rates to a local storage and automatically load from it in another place.

This can be useful in a Rails application. You fetch rates from external source once a day in a rake task and your running application picks up the new rates on the next request.

## Usage in Rails

Add it to your gemfile:

    gem "persistent_bank", "~> 0.1.0"

Now you can use it in a rake task.

    task :fetch_rates => :environment do
      bank = Money::Bank::PersistentBank.instance

      # Here goes your code that fetches the rates from external source.
      # Emulating this:
      sleep 1
      bank.set_rate(:usd, :eur, 0.8)

      bank.save! # you have to explicitly save after setting the rates
    end

(See also [money\_bank\_sources](https://github.com/semaperepelitsa/money_bank_sources).)

And somewhere in your application:

    1.to_money(:usd).exchange_to(:eur).to_f # => 0.8

When the rates are updated it will automatically use them.

[money]: https://github.com/RubyMoney/money
