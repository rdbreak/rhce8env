# RHCE 8 Automated Practice Deployment
_Powered by Ansible and Vagrant_

## Installation options below:
## macOS
_Gatekeeper will block virtualbox from installing. All you have to do is go into Security & Privacy of System Preferences and click Allow under the General tab and rerun installation._
##### Install all at once with the command below:
```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
    xcode-select --install && \
    brew install ansible ; \
    brew install python ; \
    brew cask install vagrant ; \
    brew cask install VirtualBox ; \
    brew cask install virtualbox-extension-pack ; \
    vagrant plugin install vagrant-guest_ansible
```

##### Alternatively, you can install everything individually below.
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html) - (`brew cask install vagrant`)
    - Vagrant Plugin - `vagrant plugin install vagrant-guest_ansible`
- [Install the Latest Version of Virtualbox](https://www.virtualbox.org/wiki/Downloads) (`brew cask install VirtualBox`)
    - Virtual Box Extension Pack (`brew cask install virtualbox-extension-pack`)

##### Once the above software is installed. Do the following if you're running the environment on Mac:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhce8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

## CentOS/RHEL/Manjaro/Arch - Install all at once by Copy/Pasting the below command into your terminal as root.
_NOTE - If it's been awhile since you've run yum update, do that first. Reboot if the kernel was updated. There may be some dependencies errors but don't be alarmed as this won't stop the environment from working._

_NOTE2 - If you receive an error for an ansible guest vagrant plugin, DO NOT worry, as there are two different plugins related to Ansible and only one needs to be installed._
##### For CentoOS/RHEL7/Manjaro/Arch (Continue below for RHEL 8 specific script)
```shell
VAGRANT_VERS="2.2.19" && \
    systemctl stop packagekit; \
    yum install -y epel-release && \
    yum install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c ; \
    mkdir ~/Vagrant ; \
    cd ~/Vagrant ; \
    curl -o  vagrant_${VAGRANT_VERS}_x86_64.rpm https://releases.hashicorp.com/vagrant/${VAGRANT_VERS}/vagrant_${VAGRANT_VERS}_x86_64.rpm && \
    yum install -y vagrant_${VAGRANT_VERS}_x86_64.rpm && \
    vagrant plugin install vagrant-guest_ansible ; \
    vagrant plugin install vagrant-guest-ansible ; \
    wget -O /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo ; \
    yum install -y VirtualBox-6.1 && \
    echo "* 0.0.0.0/0" >> "/etc/vbox/networks.conf" && \
    systemctl start packagekit
```
##### If you're using RHEL 8, use the script below:
```shell
VAGRANT_VERS="2.2.19" && \
    systemctl stop packagekit; \
    dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm ; \
    dnf install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c ; \
    mkdir ~/Vagrant ; cd ~/Vagrant ; \
    curl -o  vagrant_${VAGRANT_VERS}_x86_64.rpm https://releases.hashicorp.com/vagrant/${VAGRANT_VERS}/vagrant_${VAGRANT_VERS}_x86_64.rpm && \
    dnf install -y vagrant_${VAGRANT_VERS}_x86_64.rpm && \
    vagrant plugin install vagrant-guest_ansible ; \
    wget -O /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo ; \
    dnf install -y VirtualBox-6.1 && \
    /usr/lib/virtualbox/vboxdrv.sh setup ; \
    usermod -a -G vboxusers root ; \
    echo "* 0.0.0.0/0" >> "/etc/vbox/networks.conf" && \
    systemctl start packagekit
```
##### Also, install the Virtualbox extension pack below
- [Install the Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

##### Once the above software is installed. Do the following if you're running the environment on Mac:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhcsa8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

## Windows/Fedora
### If using Windows:
- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html)
- [Install the Latest Version of Virtualbox and Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)
- Then install the following vagrant plugin via PowerShell as Administrator `vagrant plugin install vagrant-guest_ansible`

### If using Fedora,
- run `dnf update -y` to update your system, then run the script below as root to install everything at once:
```shell
dnf -y install wget git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel ; \
    wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo ; \
    mv virtualbox.repo /etc/yum.repos.d/virtualbox.repo ; \
    dnf install -y VirtualBox-6.1 ; \
    usermod -a -G vboxusers ${USER} ; \
    /usr/lib/virtualbox/vboxdrv.sh setup ; \
    dnf -y install vagrant ; \
    dnf remove -y rubygem-fog-core ; \
    echo "* 0.0.0.0/0" >> "/etc/vbox/networks.conf" && \
    vagrant plugin install vagrant-guest_ansible
```

##### Once the above software is installed. Do the following if you're running the environment on Windows:
1. Create a separate `~/bin` directory and `cd` to it using the same PowerShell/Terminal as Administrator/Root.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Use your browser of choice and navigate to https://github.com/rdbreak/rhce8env, press the green “Clone or download” button then the “Download ZIP” button. Or use Github Desktop (See below).
3. Once downloaded, unzip the file and move it to the directory you created earlier, `~/bin` in the above example.
4. Use PowerShell/Terminal as Administrator/Root again and cd to the `~/bin/rhce8env` directory then run `vagrant up` to deploy the environment. (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)


## Debian
_NOTE - If it's been awhile since you've run apt update, do that first. Reboot if the kernel was updated._

##### Install all at once by Copy/Pasting the below command into your terminal as root.
```shell
VAGRANT_VERS="2.2.19" && \
    sudo snap install ruby ; \
    sudo apt install ruby-bundler git -y; \
    wget -c https://releases.hashicorp.com/vagrant/${VAGRANT_VERS}/vagrant_${VAGRANT_VERS}_x86_64.deb ; \
    sudo dpkg -i vagrant_${VAGRANT_VERS}_x86_64.deb ; \
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - ; \
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - ; \
    sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"; \
    sudo apt update; \
    sudo apt install -y virtualbox-6.0 ; \
    echo "* 0.0.0.0/0" >> "/etc/vbox/networks.conf" && \
    vagrant plugin install vagrant-guest_ansible
```
##### Also, install the Virtualbox extension pack below
- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

##### Once the above software is installed. Do the following if you're running the environment on Linux:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhce8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

**Also, don't be spooked by any scary red font during the setup process. There are known issues that won't have a negative affect on the environment.**

_Now the deployment should be up and running!_

## (Recommended) Install Github Desktop to make pulling down changes easier
_NOTE this requires a free Github account_
1. Navigate to https://desktop.github.com/ and download Github Desktop.
2. Create or sign in to your account.
3. Click "Clone a repository from the Internet" and enter "rdbreak/rhce8env" and choose a location then "Clone".
4. You are also able to easily pull changes when they're made available.

## Notable Vagrant Commands to control the environment:
- `ansible-playbook playbooks/reset.yml` - Used for resetting the environment after attempting the practice exam in the Red Hat Certs Slack workspace practice exam channel.
- `vagrant up` - Boots and provisions the environment
- `vagrant destroy -f` - Shuts down and destroys the environment
- `vagrant halt` - Only shuts down the environment VMs (can be booted up with `vagrant up`)
- `vagrant suspend` - Puts the VMs in a suspended state
- `vagrant resume` - Takes VMs out of a suspended state

## Other Useful Information:
You can also use the VirtualBox console to interact with the VMs or through a terminal. If you need to reset the root password, you would need to use the console. I'm constantly making upgrades to the environments, so every once and awhile run `git pull` in the repo directory to pull down changes. If you're using Windows, it's recommended to use Github Desktop so you can easily pull changes that are made to the environment. The first time you run the vagrant up command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. This environment is meant to be reuseable, If you run the `vagrant up` command after destroying the environment, the OS image will already be downloaded and environment will deploy faster. Deployment should take around 15 minutes depending on your computer. You shouldn't need to access the IPA server during your practice exams. Everything should be provided that you would normally need during an actual exam. Hope this helps in your studies!

## Included systems:
- repo.ansi.example.com
- control.ansi.example.com
- node1.ansi.example.com
- node2.ansi.example.com
- node3.ansi.example.com
- node4.ansi.example.com

## System Details:
> control
- 192.168.55.200
- Gateway - 192.168.55.1
- DNS - 8.8.8.8
> node1
- 192.168.55.201
- Gateway - 192.168.55.1
- DNS - 8.8.8.8
> node2
- 192.168.55.202
- Gateway - 192.168.55.1
- DNS - 8.8.8.8
> node3
- 192.168.55.203
- Gateway - 192.168.55.1
- DNS - 8.8.8.8
> node4
- 192.168.55.204
- Gateway - 192.168.55.1
- DNS - 8.8.8.8

There is a Repo/AppStream available to use from `http://repo.ansi.example.com/BaseOS` and `http://repo.ansi.example.com/AppStream`

## Accessing the systems
Remember to add the IP addresses to your local host file if you want to connect to the guest systems with the hostname.
Username - user or root
Password - password

- For root - use `sudo` or `sudo su`
Access example - `ssh user@192.168.55.201` or `vagrant ssh system`

## Help
If you're having problems with the environment, please submit an issue by going to the `ISSUES` tab at the top. If you have more questions, looking for practice exams to use against this environment, or just looking for a fantastic Red Hat community to join to get your questions answered, check out the Red Hat Certs Slack Workspace. You can find the invite link at the top of this page next to the description.

## Known Issues:

Running the 'vagrant up' environment build will fail If HyperV is installed on the Windows VirtualBox host.
Error is usually "VT-x is not available. (VERR_VMX_NO_VMX)" or similar, when the script attempts to boot the first VM.

Resolution seems to be either remove HyperV, or preventing its hypervisor from starting with the command:
bcdedit /set hypervisorlaunchtype off, followed by a reboot.

On AMD processors, the VMs can hung during reboots with the error:
`watchdog : BUG : soft lockup - CPU stuck for 22-23 secs`
