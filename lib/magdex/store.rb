module Magdex
  class Store
    attr_accessor :name

    def initialize(name)
      @name = name
      @set = IdentitySet.new
    end

    def store(record)
      @set << record
    end

    def index_by(variable, klass)
      @set.create_equality_index("@#{variable}", klass)
    end

    def find(conditions)
      conditions.map do |variable, (op, value)|
        @set.search(["@#{variable}"], op, value)
      end.reduce do |union, things|
        union & things
      end.to_a
    end
  end
end
