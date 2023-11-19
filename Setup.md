# Setting Up the Environment

Follow the instructions below to setup the lab environment on your machine. We will be installing the requirements, then cloning this repo and initializing the VMs.

## Install the Required Software

### macOS

_Gatekeeper will block virtualbox from installing. All you have to do is go into Security & Privacy of System Preferences and click Allow under the General tab and rerun installation._

Install all at once with the command below:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && xcode-select --install &&brew install ansible ; brew install python ; brew cask install vagrant ; brew cask install VirtualBox ; brew cask install virtualbox-extension-pack ; vagrant plugin install vagrant-guest_ansible
```

Alternatively, you can install everything individually below:

- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html) - (`brew cask install vagrant`)
  - Vagrant Plugin - `vagrant plugin install vagrant-guest_ansible`
- [Install the Latest Version of Virtualbox](https://www.virtualbox.org/wiki/Downloads) (`brew cask install VirtualBox`)
  - Virtual Box Extension Pack (`brew cask install virtualbox-extension-pack`)

### Linux

> [!IMPORTANT]
> + If it's been awhile since you've run an update, do that first. Reboot if the kernel was updated. There may be some dependencies errors but don't be alarmed as this won't stop the environment from working.
> + If you receive an error for an Ansible guest vagrant plugin, DO NOT worry, as there are two different plugins related to Ansible and only one needs to be installed.

#### RHEL7 - CentOS7

Install the required software:

```bash
{
	systemctl stop packagekit
	yum install -y epel-release && yum install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c
	mkdir ~/Vagrant
	cd ~/Vagrant
	curl -o  vagrant_2.2.6_x86_64.rpm https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm && yum install -y vagrant_2.2.6_x86_64.rpm && vagrant plugin install vagrant-guest_ansible
	vagrant plugin install vagrant-guest-ansible
	wget -O /etc/yum.repos.d/virtualbox.repo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
	yum install -y VirtualBox-6.0 && systemctl start packagekit
}
```

Also, install the VirtualBox extension pack below:

- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

#### RHEL8

Install the required software:

```bash
{
	systemctl stop packagekit
	dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	dnf install -y git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel libguestfs-tools-c
	mkdir ~/Vagrant
	cd ~/Vagrant
	curl -o  vagrant_2.2.19_x86_64.rpm https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.rpm && dnf install -y vagrant_2.2.19_x86_64.rpm && vagrant plugin install vagrant-guest_ansible
	wget -O /etc/yum.repos.d/virtualbox.repo
	wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
	dnf install -y VirtualBox-6.1 && /usr/lib/virtualbox/vboxdrv.sh setup
	usermod -a -G vboxusers root
	systemctl start packagekit
}
```

Also, install the Virtualbox extension pack below:

- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

#### Arch / Manjaro

Install the required software:

```bash
{
  sudo /usr/bin/pacman -Sy
  sudo /usr/bin/pacman -S --needed ansible virtualbox virtualbox-host-modules-arch virtualbox-guest-iso vagrant libvirt
}
```

Also, install the Virtualbox extension pack from the AUR:

+ `virtualbox-ext-oracle`

#### Fedora

Run `dnf update -y` to update your system, then run the script below as root to install everything at once:

```bash
{
	dnf -y install wget git binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms libvirt libvirt-devel ruby-devel libxslt-devel libxml2-devel
	wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
	mv virtualbox.repo /etc/yum.repos.d/virtualbox.repo
	dnf install -y VirtualBox-6.0
	usermod -a -G vboxusers ${USER}
	/usr/lib/virtualbox/vboxdrv.sh setup
	dnf -y install vagrant
	dnf remove -y rubygem-fog-core
	vagrant plugin install vagrant-guest_ansible
}
```

Also, install the Virtualbox extension pack below:

- [Install the Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

#### Debian

_NOTE - If it's been awhile since you've run apt update, do that first. Reboot if the kernel was updated._

Install the required software (as root):

```bash
{
  sudo snap install ruby
  sudo apt install ruby-bundler git -y
  wget -c https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
  sudo dpkg -i vagrant_2.2.6_x86_64.deb
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
  sudo apt update
  sudo apt install -y virtualbox-6.0
  vagrant plugin install vagrant-guest_ansible
}
```

Also, install the Virtualbox extension pack below:

- [Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)

### Windows

Follow the steps below:

- [Install the Latest Version of Vagrant](https://www.vagrantup.com/downloads.html)
- [Install the Latest Version of Virtualbox and Virtual Box Extension Pack](https://www.virtualbox.org/wiki/Downloads)
- Then install the following vagrant plugin via PowerShell as Administrator `vagrant plugin install vagrant-guest_ansible`

## Initialize and Start the Environment

Once the required software is installed, do the following:

### macOS

1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhce8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

### Linux

1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhcsa8env` directory that is now in your `~/bin` directory.
4. Run `vagrant up` to deploy the environment (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

### Windows

1. Create a separate `~/bin` directory and `cd` to it using the same PowerShell/Terminal as Administrator/Root.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Use your browser of choice and navigate to <https://github.com/rdbreak/rhce8env>, press the green “Clone or download” button then the “Download ZIP” button. Or use Github Desktop (See below).
3. Once downloaded, unzip the file and move it to the directory you created earlier, `~/bin` in the above example.
4. Use PowerShell/Terminal as Administrator/Root again and cd to the `~/bin/rhce8env` directory then run `vagrant up` to deploy the environment. (If the environment has a designated repo VM it will take the longest to deploy the first time only, this is because the repo system has all the packages available to the base release but will be quicker on subsequent deployments.)

---

**_The deployment should be up and running!_**

>[!NOTE]
> Don't be spooked by any scary red font during the setup process. There are known issues that won't have a negative affect on the environment.
