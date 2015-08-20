require 'test_helper'

describe Route53ARecord::Record do

  let(:rr) { Route53ARecord::Record.new('hosted_zone_id', 'name', 'value') }

  describe '#initialize' do

    it 'assigns given values' do
      rr.hosted_zone_id.must_equal 'hosted_zone_id'
      rr.name.must_equal 'name'
      rr.value.must_equal 'value'
      rr.ttl.must_equal 5
    end
  end
end
