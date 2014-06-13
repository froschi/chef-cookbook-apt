def apt_repo_add(name, url, version)
  filename = "/etc/apt/sources.list.d/#{name}.list"
  line = "deb #{url} #{version} main"
  file filename do
    action :create
    owner "root"
    group "root"
    mode "0644"
    content line
  end
end

action :add do
  log "Adding apt repo '#{new_resource.name}'."
  apt_repo_add(new_resource.name, new_resource.url, new_resource.version)
end
