# Exam Scenario 1

Sources:
+ [Lisenet: Ansible Sample Exam for RHCE EX294 and EX407](https://www.lisenet.com/2019/ansible-sample-exam-for-ex294/)
+ [waseem-h gist: RHCE8-EX294-Practice-Exam.md](https://gist.github.com/waseem-h/6793ba3328f27df1a815402710acb3ff)

## Validation Playbook

After completing all the tasks on this page you can run a validation playbook to check that all steps were completed.

a. SSH to the control node as the 'vagrant' user

b. Browse to `/vagrant/practice_exams/exam1/validation` and run the `validate.yml` playbook:

```
ansible-playbook validate.yaml
```

The playbook will tell you which task (question) has a failure. Review the playbook output to identify where exactly is the error.

## Answers

Answers can also be found in the [answers](./answers/) folder. I would advise to only use it as last resort.

## Sample Exam Questions

**Note: Some questions may depend on the outcome of others. Please read all questions before proceeding.**

### Task 1: Ansible Configuration

+ Create a regular user '**automation**' with the password of '**devops**'. Use this user for all sample exam tasks.
+ All files that you create for this sample exam should be stored in `/home/automation/plays`.
+ All playbooks should exist under `/home/automation/plays/playbooks`.
+ Create a configuration file `/home/automation/plays/ansible.cfg` to meet the following requirements:
  + The roles path should include `/home/automation/plays/roles`, as well as any other path that may be required for the course of the sample exam.
  + The inventory file path is `/home/automation/plays/inventory`.
  + Privileged escalation is **disabled** by default.
  + Ansible should be able to manage **10 hosts** at a single time.
  + Ansible should connect to all managed nodes using the '**automation**' user.

Create an inventory file `/home/automation/plays/inventory` with the following:

+ 'node1.ansi.example.com' should be a member of the '**proxy**' host group.
+ 'node2.ansi.example.com' should be a member of the '**webservers**' host group.
+ 'node3.ansi.example.com' should be a member of the '**webservers**' and '**database**' host group.
+ 'node4.ansi.example.com' should be a member of the '**database**' host group.

### Task 2: Ad-Hoc Commands

+ Create an SSH keypair.
+ Write a script `/home/automation/plays/adhoc.sh` that uses Ansible ad-hoc commands to achieve the following:
  + User '**automation**' is created on all inventory hosts.
  + SSH key (that you generated) is copied to all inventory hosts for the '**automation**' user and stored in `/home/automation/.ssh/authorized_keys`.
  + The '**automation**' user is allowed to elevate privileges on all inventory hosts without having to provide a password.
  + After running the ad-hoc script, you should be able to SSH into all inventory hosts using the '**automation**' user without password, as well as a run all privileged commands.

### Task 3: File Content

Create a playbook `/home/automation/plays/playbooks/motd.yml` that runs on all inventory hosts and does the following:

+ The playbook should replace any existing content of `/etc/motd` with text. Text depends on the host group:
  + On hosts in the '**proxy**' host group the line should be “Welcome to HAProxy server”.
  + On hosts in the '**webservers**' host group the line should be “Welcome to Apache server”.
  + On hosts in the '**database**' host group the line should be “Welcome to MySQL server”.

### Task 4: Configure SSH Server

Create a playbook `/home/automation/plays/playbooks/sshd.yml` that runs on all inventory hosts and configures SSHD daemon as follows:

+ The banner is set to `/etc/motd`
+ `X11Forwarding` is disabled
+ `MaxAuthTries` is set to 3

### Task 5: Ansible Vault

+ Create the Ansible vars file `/home/automation/plays/vars/secret.yml` and add the following variables to the file:
  + '**user_password**' with value of '**devops**'
  + '**database_password**' with value of '**devops**'
+ Create the Ansible password file `/home/automation/plays/vault_key` and add '**devops**' as the vault password.
+ Add the the vault password file to `ansible.cfg`
+ Encrypt the vars file `secret.yml`.

### Task 6: Users and Groups

You have been provided with the list of dictonary of users below. Use `/home/automation/plays/vars/user_list.yml` file to save this content:

```yaml
---
users:
- username: alice
  uid: 1201
- username: vincent
  uid: 1202
- username: sandy
  uid: 2201
- username: patrick
  uid: 2202
```

Create the playbook `/home/automation/plays/playbooks/users.yml` that uses the encrypted vars file `/home/automation/plays/secret.yml` to achieve the following:

+ Users whose user ID starts with 1 should be created on servers in the '**webservers**' host group. User password should be used from the '**user_password**' variable.
+ Users whose user ID starts with 2 should be created on servers in the '**database**' host group. User password should be used from the '**user_password**' variable.
+ All users should be members of a supplementary group '**wheel**'.
+ Shell should be set to `/bin/bash` for all users.
+ Account passwords should use the SHA512 hash format.
+ Password should only be updated on user creation.
+ Each user should have an SSH key uploaded (use the SSH key that you create previously).

After running the playbook, users should be able to SSH into their respective servers without passwords.

### Task 7: Scheduled Tasks

Create the playbook `/home/automation/plays/playbooks/regular_tasks.yml` that runs on servers in the '**proxy**' host group and does the following:

+ A root crontab record is created that runs every hour.
+ The cron job appends the file `/var/log/time.log` with the output from the `date` command.

### Task 8: Software Repositories

Create the playbook `/home/automation/plays/playbooks/repository.yml` that runs on all servers and does the following:

+ A YUM repository file is created called 'rpms.repo'.
+ The ID of the repositories in that file are 'BaseOS' and 'AppStream'.
+ The name of the repositories are is 'BaseOS on repo.ansi.example.com' and 'AppStream on repo.ansi.example.com.
+ Repositories should point to 'http://repo.ansi.example.com/BaseOS' and 'http://repo.ansi.example.com/AppStream'
+ Disable the existing 'Base' and 'Apps' repo (`ipa.repo`)

### Task 9: Create and Work with Roles - MariaDB

Create a role called '**sample-mysql**' and store it in `/home/automation/plays/roles`. The role should satisfy the following requirements:

+ A primary partition number 1 of size 800MB on device `/dev/sdb` is created.
+ An LVM volume group called `vg_database` is created that uses the primary partition created above.
+ An LVM logical volume called `lv_mysql` is created of size 512MB in the volume group `vg_database`.
+ An XFS filesystem on the logical volume `lv_mysql` is created.
+ Logical volume `lv_mysql` is permanently mounted on `/mnt/mysql_backups`.
+ '**mariadb**' package is installed.
+ Firewall is configured to allow all incoming traffic on for 'MySQL' on 'TCP' port '3306'.
+ MySQL root user password should be set from the variable '**database_password**' (see task #5).
+ A `my.cnf` file should be created for root with the credentials.
+ MySQL server should be started and enabled on boot.
+ MySQL server configuration file `/etc/my.cnf.d/mariadb-server.cnf` is generated from the `my.cnf.j2` Jinja2 template with the following content:

```ini
[mysqld]
bind_address = {{ ansible_default_ipv4.address }}
skip_name_resolve
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock

symbolic-links=0
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```

Create a playbook `/home/automation/plays/playbooks/mysql.yml` that uses the role and runs on hosts in the '**database**' group.

### Task 10: Create and Work with Roles - Apache

Create a role called '**sample-apache**' and store it in `/home/automation/plays/roles`. The role should satisfy the following requirements:

+ The '**httpd**', '**mod_ssl**' and '**php**' packages are installed. Apache service is running and enabled on boot.
+ Firewall is configured to allow all incoming traffic for 'HTTP' (TCP port '80') and 'HTTPS' (TCP port '443').
+ Apache service should be restarted every time the files `/var/www/html/index.html` or `/etc/httpd/conf/httpd.conf` are modified.
+ Identify the facts variable that stores the internal IPv4 address, which is the same as in the inventory file (your VM might have more than one address).
+ The `Listen` directive should be `Listen [internal IPv4 address variable]:80` (without the `[]`)
+ A Jinja2 template file `index.html.j2` is used to create the file `/var/www/html/index.html` with the following content:

```
The address of the server is: [internal IPv4 address variable]
```

Create the playbook `/home/automation/plays/playbooks/apache.yml` that uses the role and runs on hosts in the '**webservers**' host group.

### Task 11: Download Roles From Ansible Galaxy and Use Them

Use Ansible Galaxy to download and install '**geerlingguy.haproxy**' role in `/home/automation/plays/roles`.

Create a playbook `/home/automation/plays/playbooks/haproxy.yml` that runs on servers in the '**proxy**' host group and does the following:

+ Use '**geerlingguy.haproxy**' role to load balance request between hosts in the '**webservers**' host group.
+ Use '**roundrobin**' load balancing method.
+ HAProxy backend servers should be configured for HTTP only (port 80).
+ Backend servers should use the IP address from the task 10.
+ Confirm that the firewall is configured to allow all incoming traffic on TCP port 80.

If your playbook works, then doing `curl http://node1.ansi.example.com/` should return output from the web server (see task #10). Running the command again should return output from the other web server.

_Note: It won't work the same from a web browser_

### Task 12: Security

Create the playbook `/home/automation/plays/playbooks/selinux.yml` that runs on hosts in the '**webservers**' host group and does the following:

+ Uses the selinux '**RHEL system role**'.
+ Enables '**httpd_can_network_connect**' SELinux boolean.
+ The change must survive system reboot.

### Task 13: Use Conditionals to Control Play Execution

Create the playbook `/home/automation/plays/playbooks/sysctl.yml` that runs on all inventory hosts and does the following:

+ If a server has more than 512MB of RAM, then parameter '**vm.swappiness**' is set to 10.
+ If a server has less than 512MB of RAM, then the following error message is displayed: '**Server memory less than 512MB**'

### Task 14: Use Archiving

Create the playbook `/home/automation/plays/playbooks/archive.yml` that runs on hosts in the '**database**' host group and does the following:

+ A file `/mnt/mysql_backups/database_list.txt` is created that contains the following line: `dev,test,qa,prod`.
+ A gzip archive of the file `/mnt/mysql_backups/database_list.txt` is created and stored in `/mnt/mysql_backups/archive.gz`.

### Task 15: Work with Ansible Facts

Create the playbook `/home/automation/plays/playbooks/facts.yml` that runs on hosts in the '**database**' host group and does the following:

+ A custom Ansible fact `server_role=mysql` is created that can be retrieved from `ansible_local.custom.sample_exam` when using Ansible setup module.

### Task 16: Software Packages

Create the playbook `/home/automation/plays/playbooks/packages.yml` that runs on all inventory hosts and does the following:

+ Installs '**tcpdump**' and '**mailx**' packages on hosts in the '**proxy**' host groups.
+ Installs '**lsof**' and '**mailx**' and packages on hosts in the '**database**' host groups.

### Task 17: Services

Create the playbook `/home/automation/plays/playbooks/target.yml` that runs on hosts in the '**webservers**' host group and does the following:

+ Sets the default boot target to '**multi-user**'.
+ Displays a message when the target is already set.

### Task 18. Create and Use Templates to Create Customized Configuration Files

Create the playbook `/home/automation/plays/playbooks/server_list.yml` that does the following:

+ Playbook uses a Jinja2 template `server_list.j2` to create a file `/etc/server_list.txt` on hosts in the '**database**' host group.
+ The file `/etc/server_list.txt` is owned by the '**automation**' user.
+ File permissions are set to '**0600**'.
+ SELinux file label should be set to '**net_conf_t**'.
+ The content of the file is a list of FQDNs of all inventory hosts.

After running the playbook, the content of the file `/etc/server_list.txt` should be the following:

```
node1.ansi.example.com node2.ansi.example.com node3.ansi.example.com
```

> [!important]
> If the FQDN of any inventory host changes, re-running the playbook should update the file with the new values.
