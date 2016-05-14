module InfluxDB
  module Query
    module Database # :nodoc:
      def create_database(name, if_not_exists = false)
        execute("CREATE DATABASE #{"IF NOT EXISTS " if if_not_exists}#{name}")
      end

      def delete_database(name)
        execute("DROP DATABASE #{name}")
      end

      def list_databases
        resp = execute("SHOW DATABASES".freeze, parse: true)
        fetch_series(resp)
          .fetch(0, {})
          .fetch('values', [])
          .flatten
          .map { |v| { 'name' => v } }
      end
    end
  end
end
