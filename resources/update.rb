actions :update
default_action :update

# Needed for Chef versions < 0.10.10, apparently.
def initialize(*args)
  super
  @action = :update
end

attribute :name, :kind_of => String, :name_attribute => true
attribute :timestamp_file, :kind_of => String, :default => '/var/lib/apt/periodic/update-success-stamp'
