module Route53ARecord
  class Record
    attr_reader :hosted_zone_id, :name, :value, :ttl

    def initialize(hosted_zone_id, name, value, ttl = 5)
      @hosted_zone_id = hosted_zone_id
      @name = name
      @value = value
      @ttl = ttl
    end

    def type
      'A'
    end
  end
end

