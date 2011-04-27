class ServerValue
  include Mongoid::Document

  # keys are Strings and defined in blueprint, values are Fixnums and Strings
  field :info, :type => Hash                 # keys: local_hostname, startup_time, pid, version, env
  field :messages_total, :type => Hash       # keys: received, persisted
  field :messages_throughput, :type => Hash  # keys: current, highest, lowest - per minute
  field :additional_fields, :type => Hash    # for example: user_id => 42, post_id => 6
  field :updated_at, :type => Time

  %w(info messages_total messages_throughput additional_fields).each do |m|
    define_method(m) do
      read_attribute(m) || {}
    end
  end

  def updated_at
    read_attribute(:updated_at) || Time.at(0)
  end

  def startup_time
    Time.at(info.fetch('startup_time', 0))
  end

  def alive?
    updated_at > 65.seconds.ago
  end

  def self.all_alive?
    all.map(&:alive?).reduce(&:and)
  end

  def self.total_current_messages_throughput
    aggregate(:messages_throughput, 'current')
  end

  def self.total_highest_messages_throughput
    aggregate(:messages_throughput, 'highest')
  end

private
  def self.aggregate(field, key)
    all.map(&field).map { |hash| hash.fetch(key, nil) }.compact.reduce(&:+)
  end
end
