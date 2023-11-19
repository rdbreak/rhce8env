# RHCE 8 Automated Practice Deployment

_Powered by Ansible and Vagrant_

## Setting Up the Environment

See the [Setup](./Setup.md) page for details instructions on how to install and configure the environment.

## Environment Info

### Included systems

- repo.ansi.example.com
- control.ansi.example.com
- node1.ansi.example.com
- node2.ansi.example.com
- node3.ansi.example.com
- node4.ansi.example.com

### System Details

+ control
  - 192.168.55.200
  - Gateway - 192.168.55.1
  - DNS - 8.8.8.8
+ node1
  - 192.168.55.201
  - Gateway - 192.168.55.1
  - DNS - 8.8.8.8
+ node2
  - 192.168.55.202
  - Gateway - 192.168.55.1
  - DNS - 8.8.8.8
+ node3
  - 192.168.55.203
  - Gateway - 192.168.55.1
  - DNS - 8.8.8.8
+ node4
  - 192.168.55.204
  - Gateway - 192.168.55.1
  - DNS - 8.8.8.8
+ repo
  - 192.168.55.199
  - There is a Repo/AppStream available to use from `http://repo.ansi.example.com/BaseOS` and `http://repo.ansi.example.com/AppStream`.

### Vagrant Commands to control the environment

- `vagrant up` - Boots and provisions the environment
- `vagrant destroy -f` - Shuts down and destroys the environment
- `vagrant halt` - Only shuts down the environment VMs (can be booted up with `vagrant up`)
- `vagrant suspend` - Puts the VMs in a suspended state
- `vagrant resume` - Takes VMs out of a suspended state

### Reseting the environment

- `ansible-playbook playbooks/reset.yml` - Used for resetting the environment after attempting a practice exam.

### Accessing the systems

You can access the systems using `vagrant ssh`.

Example:

```
vagrant ssh node1
```

Or you can SSH to the VM IP using your systems built-in SSH client.

+ Username - `user` or `root` ('*user*' is the actual username)
+ Password - `password` ('*password*' is the actual password)

Example:

```
ssh user@192.168.55.201
```

To change into root you can use `sudo` or `sudo su` after logging in.

>[!tip]
> Add the IP addresses to your local host file if you want to connect to the guest systems with the hostname.

## Practice Exams

A few practice exams are included. See the [Practice Exams](./practice_exams/README.md) page.

## Additional Information

You can also use the VirtualBox console to interact with the VMs or through a terminal. If you need to reset the root password, you would need to use the console.

I'm constantly making upgrades to the environments, so every once and awhile run `git pull` in the repo directory to pull down changes. If you're using Windows, it's recommended to use Github Desktop so you can easily pull changes that are made to the environment.

The first time you run the vagrant up command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. This environment is meant to be reusable, If you run the `vagrant up` command after destroying the environment, the OS image will already be downloaded and environment will deploy faster. Deployment should take around 15 minutes depending on your computer.

### Recommended

#### Install Github Desktop to make pulling down changes easier

_NOTE this requires a free Github account_

1. Navigate to <https://desktop.github.com/> and download Github Desktop.
2. Create or sign in to your account.
3. Click "Clone a repository from the Internet" and enter "rdbreak/rhce8env" and choose a location then "Clone".
4. You are also able to easily pull changes when they're made available.

#### Get latest Ansible with man pages and GUI on Control node

You can register your control node (or all nodes) using free RHEL licenses that are provided with the Red Hat Developer Program (you can read more about it [here](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux#)). By doing that, you will be able to run full updates on the node(s), get a GUI and install Ansible with man pages.

+ Register for the [Red Hat Developer Program](https://developers.redhat.com/register)
+ Disable the 'ipa.repo'
+ Register the control node to your new developer account using `subscritption-manager`
+ Update and reboot the server
+ Install the 'Server with GUI' group package and change into 'graphical.target'
+ Update VirtualBox guest additions
+ Install Ansible and optionally jinja2
+ Optionally:
  + Enable the 'CodeReady Linux Builder' repo
  + Install the EPEL repo

## Help

If you're having problems with the environment, please submit an issue by going to the `ISSUES` tab at the top. If you have more questions, if you are looking for practice exams to use against this environment, or just looking for a fantastic Red Hat community to join to get your questions answered, check out the Red Hat Certs Slack Workspace. You can find the invite link in the 'About' section for this repo.

### Known Issues

#### VT-x is not available. (VERR_VMX_NO_VMX)

Running the `vagrant up` environment build will fail If HyperV is installed on the Windows VirtualBox host.
Error is usually "VT-x is not available. (VERR_VMX_NO_VMX)" or similar, when the script attempts to boot the first VM.

Resolution seems to be either remove HyperV, or preventing its hypervisor from starting with the command below followed by a reboot:

```
bcdedit /set hypervisorlaunchtype off
```

#### Could not create the medium storage unit (VERR_ALREADY_EXISTS)

The following error might appear when re-creating one or more VMs in VirtualBox:

```
Stderr: 0%...VBOX_E_FILE_ERROR
VBoxManage: error: Failed to create medium
VBoxManage: error: Could not create the medium storage unit 'rhce8env/disk-0-4.vdi'.
VBoxManage: error: VDI: cannot create image 'rhce8env/disk-0-4.vdi' (VERR_ALREADY_EXISTS)
```

If you have VirtualBox Manager open, check the disks in the 'Media' section and you might notice that a disk for a deleted VM is still listed. If the file itself doesn't exist, close the VirtualBox Manager and try running `vagrant up` again.

## Exam Material

See the [Exam Material](./ExamMaterial.md) page.
