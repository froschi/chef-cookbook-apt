# TODO: implement some kind of timestamping system.

action :update do
  log "Running apt-get update."

  execute "apt-get-update-again" do
    command "/usr/bin/apt-get update"
    action :run
  end
end
