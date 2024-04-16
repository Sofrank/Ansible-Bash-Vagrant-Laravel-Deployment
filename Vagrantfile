
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "master" do |master_config|
    master_config.vm.box = "ubuntu/focal64"
    master_config.vm.hostname = "master"
    master_config.vm.network "private_network", ip: "192.168.56.55"
    master_config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
    master_config.vm.provision "shell", inline: "sudo apt-get update"
    master_config.vm.provision "shell", inline: "sudo apt-get install -y ansible"
  end

  config.vm.define "slave" do |slave_config|
    slave_config.vm.box = "ubuntu/focal64"
    slave_config.vm.hostname = "slave"
    slave_config.vm.network "private_network", ip: "192.168.56.56"
    slave_config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
  end

end