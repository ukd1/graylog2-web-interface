class ServerValue
  include Mongoid::Document

  # keys are Strings and defined in blueprint, values are Fixnums and Strings
  field :info, :type => Hash                 # keys: local_hostname, startup_time, pid, version, env
  field :messages_total, :type => Hash       # keys: received, persisted
  field :messages_throughput, :type => Hash  # keys: current, highest, lowest - per minute
  field :additional_fields, :type => Hash    # for example: user_id => 42, post_id => 6
  field :updated_at, :type => Time

  field :type, :type => String

  def startup_time
    Time.at(info.try(:fetch, 'startup_time', 0))
  end

  def alive?
    (updated_at || 0) > 65.seconds.ago
  end

  def self.all_alive?
    all.map(&:alive?).reduce(&:and)
  end

  def self.total_current_messages_throughput
    all.map(&:messages_throughput).map { |hash| hash.try(:fetch, 'current', nil) }.compact.reduce(&:+)
  end
end
