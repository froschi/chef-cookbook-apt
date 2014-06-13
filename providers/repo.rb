action :add do
  log "Adding apt repo '#{new_resource.name}'."

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
