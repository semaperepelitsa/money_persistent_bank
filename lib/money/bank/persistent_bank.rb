require "money/bank/variable_exchange"

class Money
  module Bank
    class PersistentBank < VariableExchange
      attr_reader :storage

      def initialize storage, key = 'persistent_bank/rates', format = :yaml
        super()
        @storage = storage
        @storage_key = key
        @storage_format = format
      end

      def writing
        yield self
        export_rates
      end

      def reading
        import_rates
        yield self
      end

      def export_rates
        storage.write(@storage_key, super(@storage_format))
      end

      def import_rates
        rates.clear
        cache = storage.read(@storage_key)
        super(@storage_format, cache) if cache
      end

      def clear
        storage.delete(@storage_key)
      end
    end
  end
end
