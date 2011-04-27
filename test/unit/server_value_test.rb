require 'test_helper'

class ServerValueTest < ActiveSupport::TestCase
  should "calculate total throughput" do
    ServerValue.make(:messages_throughput => {'current' => 7})
    ServerValue.make(:messages_throughput => {'current' => 8})
    ServerValue.make(:messages_throughput => {'aaaaaaa' => 9})
    ServerValue.make(:messages_throughput => nil)

    assert_equal 15, ServerValue.total_current_messages_throughput
  end
end
