required_plugins = [
    "vagrant-vbguest"
]

restart_required = false

required_plugins.each do |plugin|
    if !Vagrant.has_plugin? plugin
        system "vagrant plugin install #{plugin}"
        restart_required = true
    end
end

if restart_required == true
    puts "Required plugins installed, please re-run the last vagrant command."
    exit 1
end

Vagrant.configure(2) do |config|
    config.vm.define "usp" do |usp|
    end

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
    end

    config.vm.box = "debian/jessie64"

    config.vm.network "forwarded_port", guest: 3000, host: 8081
    config.vm.network "forwarded_port", guest: 443, host: 4431
    config.vm.network "private_network", type: "dhcp"

    config.vm.synced_folder "./", "/vagrant"
    config.vm.synced_folder "working", "/data/usp"

    
    config.vm.provision :shell, path: "vagrant/bootstrap.sh"
   # config.vm.provision :shell, path: "vagrant/application.sh"
end
