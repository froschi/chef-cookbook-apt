def apt_debconf_values_add(package, key, option, value)
  execute "debconf-set-selection-#{key}" do
    command "echo #{package} #{key} #{option} #{value} | debconf-set-selections"
    action :run
  end
end

action :add do
  log "Adding debconf option #{new_resource.package} #{new_resource.key} #{new_resource.option} #{new_resource.value}"

  apt_debconf_values_add(new_resource.package, new_resource.key, new_resource.option, new_resource.value)
end
