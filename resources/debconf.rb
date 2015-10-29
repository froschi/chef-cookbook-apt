actions :add
default_action :add

# Needed for Chef versions < 0.10.10, apparently.
def initialize(*args)
  super
  @action = :add
end

attribute :package, :kind_of => String, :default => 'debconf'
attribute :key, :kind_of => String, :name_attribute => true, :required => true
attribute :option, :kind_of => String, :required => true
attribute :value, :kind_of => String, :required => true
