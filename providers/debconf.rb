#def apt_key_fingerprints
#  so = Mixlib::ShellOut.new('apt-key finger').run_command
#  so.stdout.split(/\n/).map do |t|
#    if z = t.match(/^ +Key fingerprint = ([0-9A-F ]+)/)
#      z[1].split.join
#    end
#  end.compact
#end
#
#def apt_key_from_keyserver(key, keyserver)
#  execute "apt-key-install-#{key}" do
#    command "apt-key adv --keyserver #{keyserver} --recv #{key}"
#    action :run
#    not_if do
#      apt_key_fingerprints.any? do |fingerprint|
#        fingerprint.end_with?(key.upcase)
#      end
#    end
#  end
#end

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
