# RHCE 8 Study/Test Environment powered by Ansible and Vagrant. 

## Required software before setting up:
- Ansible - (`yum install ansible` or `brew install ansible`)
- Python - (`yum install python`or `brew install python`)
- [Vagrant](https://www.vagrantup.com/downloads.html) - (`brew cask install vagrant`)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) (`brew cask install VirtualBox`)
- SSHPASS `brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb`
- Virtual Box Extension Pack (`brew cask install virtualbox-extension-pack`)

### Install at once with the command below:
(`brew install ansible ; brew install python ; brew cask install vagrant ; brew cask install VirtualBox ; brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb ; brew cask install virtualbox-extension-pack`)

If you're using a Mac, Gatekeeper will block virtualbox from installing. All you have to do is go to System Preferences and click Allow under the General tab and rerun installation.

## Set Up Instructions
1. Create a seperate `~/bin` directory and `cd` to it. 
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/rhce8env.git`
3. Change to the `rhce8env` directory that is now in your `~/bin` directory.
3. Run `vagrant up --provider virtualbox` to deploy the environment _(You must be in the directory you cloned the repo to in order to run vagrant commands.)_

*Also, don't be spooked by any red font during the setup process. It won't have an affect on your exam environment.* 

_NOTE - You can use the VirtualBox console to interact with the VMs or through a terminal. If you need to reset the root password, you would need to use the console though._

The first time you run the vagrant up command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. This environment is meant to be reuseable, If you run the `vagrant up --provider virtualbox` command after destroying the environment, the OS image will already be downloaded and environment will deploy faster. Once the setup is complete, the ipa server and client for realm rhce.example.com will already be setup and paired. Deployment should take around 15 minutes depending on your computer. You shouldn't need to access the IPA server during your practice exams. Everything should be provided that you would normally need during an actual exam. Hope this helps  in your studies!

### It includes three systems:
- control.example.com
- node1.example.com
- node2.example.com

### Network Details:
###### control
192.168.55.200
###### node1
192.168.55.201
###### node2
192.168.55.202

There is a repo available to use from `http://control.example.com/rpms`

There are also two additional network interfaces and an additional drive on node1 and node2 to optionally use.

### Accessing the systems
Remember to add the IP addresses to your local host file if you want to connect to the guest systems with the hostname.
Username - user
Password - password
- For root - use `sudo` or `sudo su`
Access example - `ssh vagrant@192.168.55.151`

##Known Issues
Currently there is an issue with the named services during the IPA server setup. This doesn't seem to impact the environment at the moment. Please reach out if it does.

## Help
If you're having problems with the environment, please submit an issue by going to the `ISSUES` tab at the top. If you have more questions, looking for practice exams to use against this environment, or just looking for a fantastic Red Hat community to join, please navigate to #practiceexam in the [Red Hat Certs Slack Workspace](https://join.slack.com/t/redhat-certs/shared_invite/enQtNjAxNDc3MzYyMTAxLWZlM2ZhMGRlNGI2YjQyMzQ4NWEyNDIyYTJiNzcxM2E1ZDVkZmQ4MzU2MTc0ZDRlNzg2MTU5NWIwZjFjZDdjMGE).
