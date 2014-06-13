def apt_key_fingerprints
  so = Mixlib::ShellOut.new('apt-key finger').run_command
  so.stdout.split(/\n/).map do |t|
    if z = t.match(/^ +Key fingerprint = ([0-9A-F ]+)/)
      z[1].split.join
    end
  end.compact
end

def apt_key_from_keyserver(key, keyserver)
  execute "apt-key-install-#{key}" do
    command "apt-key adv --keyserver #{keyserver} --recv #{key}"
    action :run
    not_if do
      apt_key_fingerprints.any? do |fingerprint|
        fingerprint.end_with?(key.upcase)
      end
    end
  end
end

action :add do
  log "Adding apt key '#{new_resource.name}'." do
    apt_key_from_keyserver(new_resource.key, new_resource.keyserver)
    #apt_get_update
    #apt_touch_update_file
    #notifies :run, "execute[foo-apt-get-update]", :immediately
  end
end
