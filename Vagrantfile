# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX                 = "monvillalon/sinatra"
NETWORK_INTERFACE   = nil # Name of the network interface to bridge ex: "en0: Wi-Fi (AirPort)"
MACHINE_MEMORY      = 512
PRIVATE_IP          = "192.168.2.99"
GUI                 = false
PORT_WEBRICK        = 4567
PORT_SHOTGUN        = 9393
PORT_POSTGRESQL     = 5432
PORT_TEAMPOSTGRESQL = 8082

#Create the code folder if doesn't exist
code_dir = File.dirname(__FILE__) + "/src"
Dir.mkdir( code_dir ) unless File.exists?( code_dir )

#Configure Vagrant
Vagrant.configure(2) do |config|

  config.vm.box               = BOX
  config.vm.box_check_update  = true
  config.vm.hostname          = "sinatra"

  #Configure Port Fowarding
  config.vm.network "forwarded_port", guest: 4567, host: PORT_WEBRICK        # shotgun
  config.vm.network "forwarded_port", guest: 9393, host: PORT_SHOTGUN        # shotgun
  config.vm.network "forwarded_port", guest: 5432, host: PORT_POSTGRESQL     # Postgresql
  config.vm.network "forwarded_port", guest: 8082, host: PORT_TEAMPOSTGRESQL # teampostgresql

  #Uncomment this to have a public network bridge
  config.vm.network :public_network, bridge: NETWORK_INTERFACE

  #Uncomment this to have a private host network
  config.vm.network :private_network, ip: PRIVATE_IP

  #Setup shared folders
  config.vm.synced_folder "./src", "/home/vagrant/src"

  #Configure Virtual Machine Settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui    = GUI
    vb.memory = MACHINE_MEMORY
  end

end
