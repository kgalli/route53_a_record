require 'test_helper'

describe Route53ARecord::Handler do

  let(:rh) { Route53ARecord::Handler.new('my_access_key_id', 'my_secret_access_key') }
  let(:rh_overwrite_false) { Route53ARecord::Handler.new('my_access_key_id', 'my_secret_access_key', false) }
  describe '#initialize' do

    it 'assigns the aws credentials' do
      rh.instance_variable_get(:@access_key_id).must_equal 'my_access_key_id'
      rh.instance_variable_get(:@secret_access_key).must_equal 'my_secret_access_key'
    end

    it 'does not allow access to aws credentials' do
      proc { rh.access_key_id }.must_raise NoMethodError
      proc { rh.secret.access_key }.must_raise NoMethodError
    end

    it 'assigns default true for overwrite' do
      rh.instance_variable_get(:@overwrite).must_equal true
    end

    it 'overwrites the default for overwrite' do
      rh_overwrite_false.instance_variable_get(:@overwrite).must_equal false
    end
  end

  describe '#action_based_on_overwrite' do

    it 'returns UPSERT if overwrite is allowed' do
      rh.send(:action_based_on_overwrite).must_equal 'UPSERT'
    end

    it 'returns CREATE if overwrite is denied' do
      rh_overwrite_false.send(:action_based_on_overwrite).must_equal 'CREATE'
    end
  end

  describe '#aws_client' do

    it 'assigns the credentials' do
      rh.send(:aws_client).config.credentials[:access_key_id].must_equal 'my_access_key_id'
      rh.send(:aws_client).config.credentials[:secret_access_key].must_equal 'my_secret_access_key'
    end
  end

  describe '#a_record_change_hash' do

    let(:a_record) { Route53ARecord::Record.new('aws_hosted_zone_id', 'resource_a_record_name', 'resource_a_record_value', 15) }
    let(:create_record) { {
      hosted_zone_id: "aws_hosted_zone_id", change_batch: {
        changes: [
          { action: "CREATE",
            resource_record_set: {
              name: "resource_a_record_name", type: "A", ttl: 15,
              resource_records: [ { value: "resource_a_record_value" } ]
            }
          }
        ]
      }
    }}

   it 'replaces placeholder values by a ResourceARecord' do
     rh.send(:a_record_change_hash, 'CREATE', a_record).must_equal create_record
   end
  end
end

