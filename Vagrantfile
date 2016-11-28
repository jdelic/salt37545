# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

    config.ssh.insert_key = false
    config.ssh.forward_agent = true

    config.vm.define :debug37545 do |debug37545|
        debug37545.vm.provider :virtualbox do |vb|
            vb.customize ['modifyvm', :id, '--rtcuseutc', 'on']
            vb.customize ['modifyvm', :id, '--memory', 2048]
        end

        debug37545.vm.box = 'debian/contrib-jessie64'  # debian/jessie64 is missing vbox client
        debug37545.vm.network :private_network, ip: '192.168.56.68'
        debug37545.vm.hostname = 'saltmaster.maurusnet.test'

        debug37545.vm.synced_folder 'srv/salt', '/srv/salt'
        debug37545.vm.synced_folder 'srv/pillar', '/srv/pillar'
        debug37545.vm.synced_folder 'srv/reactor', '/srv/reactor'
        debug37545.vm.synced_folder 'etc/salt-minion/minion.d', '/etc/salt/minion.d'
        debug37545.vm.synced_folder 'etc/salt-master/master.d', '/etc/salt/master.d'

        debug37545.vm.provision :shell do |s|
            s.inline = <<SCRIPT
                mkdir -p /etc/salt/roles.d
                touch /etc/salt/roles.d/test
SCRIPT
        end

        debug37545.vm.provision :salt do |salt|
            salt.run_highstate = true
            salt.colorize = true
            salt.log_level = 'info'
            salt.verbose = true
            salt.no_minion = false
            salt.always_install = true
            salt.install_master = true
            salt.install_syndic = false
            salt.bootstrap_script = 'bootstrap-salt.sh'
            salt.master_pub = 'preseed-keys/saltmaster.maurusnet.test.pub'
            salt.master_key = 'preseed-keys/saltmaster.maurusnet.test.pem'
            salt.minion_pub = 'preseed-keys/saltmaster.maurusnet.test.pub'
            salt.minion_key = 'preseed-keys/saltmaster.maurusnet.test.pem'
            salt.seed_master = {
                'saltmaster.maurusnet.test' => salt.minion_pub,
            }
        end
    end
end
