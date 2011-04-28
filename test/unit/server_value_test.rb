require 'test_helper'

class ServerValueTest < ActiveSupport::TestCase
  should "calculate total throughput of alive servers" do
    assert_equal 0, ServerValue.total_current_messages_throughput

    ServerValue.make(:messages_throughput => {'current' => 1})
    ServerValue.make(:messages_throughput => {'current' => 10})
    ServerValue.make(:messages_throughput => {'aaaaaaa' => 100})
    ServerValue.make(:messages_throughput => nil)
    ServerValue.make(:messages_throughput => {'current' => 1000}, :updated_at => 70.seconds.ago)

    assert_equal 11, ServerValue.total_current_messages_throughput
  end
end
