
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
  log "Adding apt repo '#{new_resource.name}' with key '#{new_resource.key}'."

  apt_key_from_keyserver(new_resource.key, new_resource.keyserver)

  execute "apt-get-update" do
    command "/usr/bin/apt-get update"
    action :nothing
  end

  file "/etc/apt/sources.list.d/#{new_resource.name}.list" do
    action :create
    owner "root"
    group "root"
    mode "0644"
    content "deb #{new_resource.url} #{new_resource.suite} #{new_resource.component}"

    notifies :run, "execute[apt-get-update]", :immediately
  end
end
