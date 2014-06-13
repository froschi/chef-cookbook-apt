actions :add
default_action :add

# Needed for Chef versions < 0.10.10, apparently.
def initialize(*args)
  super
  @action = :add
end

attribute :keyserver, :kind_of => String, :default => "keyserver.ubuntu.com"
attribute :key, :kind_of => String, :default => nil
attribute :name, :kind_of => String, :name_attribute => true
