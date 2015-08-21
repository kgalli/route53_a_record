require 'aws-sdk-v1'

module Route53ARecord
  class Handler
    attr_accessor :overwrite

    def initialize(access_key_id, secret_access_key, overwrite = true)
      @access_key_id = access_key_id
      @secret_access_key = secret_access_key
      @overwrite = overwrite
    end

    def create(resource_a_record)
      action = action_based_on_overwrite
      aws_client.change_resource_record_sets(a_record_change_hash(action, resource_a_record))
    end

    def delete(resource_a_record)
      aws_client.change_resource_record_sets(a_record_change_hash("DELETE", resource_a_record))
    end

    private

    def action_based_on_overwrite
      @overwrite ? 'UPSERT' : 'CREATE'
    end

    def aws_client
      AWS::Route53.new(
          access_key_id: @access_key_id,
          secret_access_key: @secret_access_key
      ).client
    end

    def a_record_change_hash(action, resource_a_record)
      {
        hosted_zone_id: resource_a_record.hosted_zone_id,
        change_batch: {
          changes: [
            {
              action: action,
              resource_record_set: {
                name: resource_a_record.name,
                type: "A",
                ttl: resource_a_record.ttl,
                resource_records: [
                  {
                    value: resource_a_record.value
                  }
                ]
              }
            }
          ]
        }
      }
    end
  end
end

