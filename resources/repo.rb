actions :add
default_action :add

# Needed for Chef versions < 0.10.10, apparently.
def initialize(*args)
  super
  @action = :add
end

attribute :url, :kind_of => String, :required => true
attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String, :default => node['lsb']['codename']
