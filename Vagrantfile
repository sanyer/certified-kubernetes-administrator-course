# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

HOSTS = [
  { name: "kubemaster", ip: "192.168.56.10" },
  { name: "kubenode01", ip: "192.168.56.20" },
  { name: "kubenode02", ip: "192.168.56.21" }
]

$hostname = "hostnamectl set-hostname ${1-kubenode}"

$interface = "enp0s8"
$hostmap = <<SCRIPT
tee /etc/hosts <<CONFIG
#{HOSTS.map{ |host| "#{host[:ip]} #{host[:name]}" }.join("\n")}
CONFIG
SCRIPT

$dns = "8.8.8.8"
$resolv = <<SCRIPT
sed -i "s/#DNS=.*/DNS=${1-8.8.8.8}/g" /etc/systemd/resolved.conf
systemctl restart systemd-resolved
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.boot_timeout = 600

  HOSTS.each do |host|
    config.vm.define host[:name] do |node|
      node.vm.provider :virtualbox do |vb|
        vb.name = host[:name]
        vb.check_guest_additions = false
        vb.customize ["modifyvm", :id, "--cpus", 2]
        vb.customize ["modifyvm", :id, "--memory", 2048]
        vb.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
      end

      # node.vm.provision :shell, inline: $hostname, args: host[:name]
      # node.vm.hostname = host[:name]
      # node.vm.network :private_network, ip: host[:ip]
      # node.vm.network :public_network, ip: host[:ip]

      # node.vm.provision :shell, inline: $hostmap, args: $interface
      # node.vm.provision :shell, inline: $resolv, args: $dns
      # node.vm.provision :shell, inline: "shutdown -r now"
    end
  end
end
