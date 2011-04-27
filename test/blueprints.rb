Sham.login { Faker::Internet.user_name }
Sham.password { Faker::Internet.user_name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.words(15).join }
Sham.name { Faker::Lorem.words(15).join }
Sham.host { Faker::Internet.domain_name }

Message.blueprint do
  message { Faker::Lorem.words(100).join }
  facility { rand(15) }
  level { rand(8) }
  host
  created_at { Time.now.to_i }
  deleted { false }
end

Stream.blueprint do
  title
end

Streamrule.blueprint do
end

FilteredTerm.blueprint do
end

User.blueprint do
  login
  password 'testing'
  password_confirmation { password }
  email
  role { :admin }
end

Host.blueprint do
 host
 message_count { rand(50000) }
end

Hostgroup.blueprint do
  name
end

HostgroupHost.blueprint do
  hostname { Sham.host }
end

ServerValue.blueprint do
  info { { 'local_hostname' => Sham.host, 'startup_time' => Time.now.to_i, 'pid' => 1234, 'version' => '0.9.9', 'env' => 'JVMs are awesome ;)' } }
  messages_total { { 'received' => 1000, 'persisted' => 950 } }
  messages_throughput { { 'current' => 1000, 'highest' => 2000, 'lowest' => 500 } }
  additional_fields { { 'user_id' => 42, 'post_id' => 6 } }
  updated_at { Time.now.to_i }
end
