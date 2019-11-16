# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vagrant.plugins = [
    'vagrant-hostmanager'
  ]

  config.vm.box = "generic/ubuntu1904"

  config.hostmanager.enabled = false
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.hostname = 'singularitybox'

  config.vm.provider :hyperv do |v|
    v.cpus = 2
    v.enable_virtualization_extensions = true
    v.linked_clone = true
    v.maxmemory = 4096
    v.memory = 3072
  end

  config.vm.provider :virtualbox do |v|
    v.cpus = 2
    v.linked_clone = true
    v.memory = 3072
  end

  # Forward MySQL port
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # Forward Redis port
  config.vm.network "forwarded_port", guest: 6379, host: 6379

  # Forward httpd port
  config.vm.network "forwarded_port", guest: 80, host: 8081
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.network "private_network", type: 'dhcp'

  config.vm.synced_folder ".", "/vagrant", disabled: true

  # DNS fix for Linux
  config.vm.provision :shell, inline: <<-SHELL
    sed -i -e 's/^nameserver 127\.0\.0\.53$/nameserver 8\.8\.8\.8/' /etc/resolv.conf
  SHELL

  # Copy the containers directory into home directory
  config.vm.provision :file, source: './containers', destination: '~/'

  # Install required applications
  config.vm.provision :shell, name: 'Singularity Install', path: './singularity_install.sh'

  config.vm.provision :shell, name: 'Singularity Compose', path: './singularity_compose.sh'

  # Build MariaDB container
  # config.vm.provision :shell, name: 'Setup MariaDB Container', privileged: false, path: './mariadb_container.sh'
  
  # Build Apache2 container
  #config.vm.provision :shell, name: 'Setup Apache2 httpd Container', privileged: false, path: './httpd.sh'

  # Compose the simple singularity example
  # config.vm.provision :shell, name: 'Singularity Compose Simple', path: './compose_simple.sh'

  config.vm.provision :shell, name: 'Compose Apps', privileged: false, inline: <<-SHELL
    cd ~/containers
    singularity-compose build
    sudo singularity-compose up
  SHELL

  config.vm.provision :hostmanager
end
