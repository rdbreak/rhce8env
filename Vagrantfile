VAGRANTFILE_API_VERSION = "2"
VAGRANT_DISABLE_VBOXSYMLINKCREATE = "1"
file_to_disk1 = './disk-0-1.vdi'
file_to_disk2 = './disk-0-2.vdi'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# Use same SSH key for each machine
config.ssh.insert_key = false
config.vm.box_check_update = false
config.vm.define "node1" do |node1|
  node1.vm.box = "generic/oracle8"
#  node1.vm.hostname = "node1.example.com"
  node1.vm.network "private_network", ip: "192.168.55.201"
  node1.vm.network "private_network", ip: "192.168.55.210"
  node1.vm.network "private_network", ip: "192.168.55.211"
  node1.vm.provision :shell, :inline => "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; systemctl restart sshd;", run: "always"
  node1.vm.provision :shell, :inline => "sudo dnf install -y @idm:DL1; sudo dnf -y install httpd python36 python2 python2-pip python3-pip python2-setuptools python3-setuptools python2-devel python36-devel python3-cryptography;", run: "always"
  node1.vm.provision :shell, :inline => "ln -s /usr/bin/python3.6 /usr/bin/python", run: "always"
  node1.vm.provision :shell, :inline => "alternatives --set python /usr/bin/python3", run: "always"
  node1.vm.provision :shell, :inline => " yum install -y @idm:DL1 ;dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y; yum install -y sshpass;", run: "always"
  node1.vm.provision :shell, :inline => "pip3 install ansible --user", run: "always", privileged: false
  node1.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
  node1.vm.provider "virtualbox" do |node1|
    node1.memory = "1024"

    if not File.exist?(file_to_disk1)
      node1.customize ['createhd', '--filename', file_to_disk1, '--variant', 'Fixed', '--size', 10 * 1024]
    end
    node1.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node1.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk1]
  end
  
    node1.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
    node1.vm.synced_folder ".", "/vagrant"
 end

config.vm.define "node2" do |node2|
  node2.vm.box = "generic/oracle8"
#  node2.vm.hostname = "node2.example.com"
  node2.vm.network "private_network", ip: "192.168.55.202"
  node2.vm.network "private_network", ip: "192.168.55.212"
  node2.vm.network "private_network", ip: "192.168.55.213"
  node2.vm.provision :shell, :inline => "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; systemctl restart sshd;", run: "always"
  node2.vm.provision :shell, :inline => "sudo dnf install -y @idm:DL1; sudo dnf -y install httpd python36 python2 python2-pip python3-pip python2-setuptools python3-setuptools python2-devel python36-devel python3-cryptography;", run: "always"
  node2.vm.provision :shell, :inline => "ln -s /usr/bin/python3.6 /usr/bin/python", run: "always"
  node2.vm.provision :shell, :inline => "yum install -y @idm:DL1 ;dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y; yum install -y sshpass;", run: "always"
  node2.vm.provision :shell, :inline => "pip3 install ansible --user", run: "always", privileged: false
  node2.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
  node2.vm.provider "virtualbox" do |node2|
    node2.memory = "1024"

    if not File.exist?(file_to_disk2)
      node2.customize ['createhd', '--filename', file_to_disk2, '--variant', 'Fixed', '--size', 10 * 1024]
    end
    node2.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 2]
    node2.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk2]
  end
  
    node2.vm.provision "shell", inline: <<-SHELL
    yes| sudo mkfs.ext4 /dev/sdb
    SHELL
    node2.vm.synced_folder ".", "/vagrant"
end
config.vm.define "control" do |control|
  control.vm.box = "generic/oracle8"
  control.vm.provision :shell, :inline => "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; systemctl restart sshd;", run: "always"
  control.vm.provision :shell, :inline => "sudo dnf -y install httpd python36 python2 python2-pip python3-pip python2-setuptools python3-setuptools python2-devel python36-devel python3-cryptography;", run: "always"
  control.vm.provision :shell, :inline => "yum install -y @idm:DL1 ;dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y; sudo yum install -y sshpass httpd vsftpd createrepo pki-ca", run: "always"
  control.vm.provision :shell, :inline => "mkdir -p /var/www/html/rpms;  echo 'nameserver 8.8.8.8' > /etc/resolv.conf;", run: "always"
  control.vm.provision :shell, :inline => "for i in \"Development Tools\" \"Container Management\" \"Workstation\" \"Graphical Administration Tools\" ; do yum group install \"$i\" -y --downloadonly --downloaddir=/var/www/html/rpms;done;", run: "always"
  control.vm.provision :shell, :inline => "yum install -y man-pages httpd-manual selinux\* sssd\* --downloadonly --downloaddir=/var/www/html/rpms; yum install -y @idm:DL1 --downloadonly --downloaddir=/var/www/html/rpms; yum install -y bind-dyndb-ldap ipa-server ipa-server-dns --downloadonly --downloaddir=/var/www/html/rpms;", run: "always"
  control.vm.provision :shell, :inline => "pip3 install ansible --user", run: "always", privileged: false
#  control.vm.hostname = "control.example.com"
  control.vm.network "private_network", ip: "192.168.55.200"
  control.vm.provider :virtualbox do |control|
    control.customize ['modifyvm', :id,'--memory', '2048']
    end
  control.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
  control.vm.provision :ansible_local do |ansible|
  ansible.playbook = "/vagrant/playbooks/master.yml"
  ansible.install = false
  ansible.compatibility_mode = "2.0"
  ansible.inventory_path = "/vagrant/inventory"
  ansible.config_file = "/vagrant/ansible.cfg"
  ansible.limit = "all"
 end
end
end