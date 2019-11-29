# -*- mode: ruby -*-
# vi: set ft=ruby :

env = {}
File.read(".env").split("\n").each do |ef|
  key, value = ef.split("=")
  env[key] = value
end

Vagrant.configure("2") do |config|
  config.vagrant.plugins = [
    'vagrant-hostmanager'
  ]

  config.hostmanager.enabled = false
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.define :singularitybox do |sb|
    sb.vm.hostname = 'singularitybox'
    sb.vm.box = "generic/ubuntu1904"

    sb.vm.provider :hyperv do |v|
      v.cpus = 2
      v.enable_virtualization_extensions = true
      v.linked_clone = true
      v.maxmemory = 4096
      v.memory = 3072
    end

    sb.vm.provider :virtualbox do |v|
      v.cpus = 2
      v.linked_clone = true
      v.memory = 3072
    end

    # Forward MySQL port
    sb.vm.network "forwarded_port", guest: 3306, host: 3306

    # Forward Redis port
    sb.vm.network "forwarded_port", guest: 6379, host: 6379

    # Forward httpd port
    sb.vm.network "forwarded_port", guest: 80, host: 8081
    sb.vm.network "forwarded_port", guest: 8080, host: 8080

    sb.vm.network "private_network", type: 'dhcp'

    sb.vm.synced_folder ".", "/vagrant", disabled: true

    # DNS fix for Linux
    sb.vm.provision :shell, inline: <<-SHELL
    sed -i -e 's/^nameserver 127\.0\.0\.53$/nameserver 8\.8\.8\.8/' /etc/resolv.conf
    SHELL

    # Copy the containers directory into home directory
    sb.vm.provision :file,
      source: './containers', destination: '~/'

    # Install required applications
    sb.vm.provision :shell,
      name: 'Install Build Essential',
      path: './scripts/install_build_essential.sh'
    sb.vm.provision :shell,
      name: 'Install Go',
      path: './scripts/install_go.sh'
    sb.vm.provision :shell,
      name: 'Download Singularity source',
      privileged: false,
      env: { "SINGULARITY_VERSION": "3.5.0" },
      path: './scripts/download_singularity_source.sh'
    sb.vm.provision :shell,
      name: 'Install Dependencies for Singularity',
      path: './scripts/install_build_dep_singularity.sh'
    sb.vm.provision :shell,
      name: 'Build Singularity',
      privileged: false,
      env: { "SINGULARITY_VERSION": "3.5.0" },
      path: './scripts/build_singularity.sh'
    sb.vm.provision :shell,
      name: 'Install Singularity',
      path: './scripts/install_singularity.sh'
    sb.vm.provision :shell,
      name: 'Install Singularity Compose',
      path: './scripts/install_singularity_compose.sh'

    # Build composed containers
    sb.vm.provision :shell,
      name: 'Singularity Compose',
      privileged: false,
      env: {
        "MYSQL_ROOT_PASSWORD": env["MYSQL_ROOT_PASSWORD"],
        "MYSQL_USER": env["MYSQL_USER"],
        "MYSQL_PASSWORD": env["MYSQL_PASSWORD"],
        "MYSQL_DATABASE": env["MYSQL_DATABASE"],
      },
      path: './scripts/build_containers.sh'

      sb.vm.provision :shell,
        name: 'Run Compose Apps',
        env: {
          "MYSQL_ROOT_PASSWORD": env["MYSQL_ROOT_PASSWORD"],
          "MYSQL_USER": env["MYSQL_USER"],
          "MYSQL_PASSWORD": env["MYSQL_PASSWORD"],
          "MYSQL_DATABASE": env["MYSQL_DATABASE"],
        },
        inline: <<-SHELL
    cd containers
    sudo singularity-compose up
        SHELL
  end

  config.vm.provision :hostmanager
end
