# Practice Exams

Here you can find practice exams that can be used to practice and validate your knowledge.

## Included Exam Scenarios

### Exam Scenario 1

The exam has 18 tasks for you to perform. At the end you can run a validation playbook to check that all steps were performed correctly.

Access the exam -> [Exam Scenario 1](./exam1/README.md)

## Creating an Exam Scenario with ChatGPT

You can use ChatGPT to create new exam scenarios for you. Use the 2 commands below.

### Question 1: Providing base data

    I'm providing you with the RHCE exam objectives and a sample inventory file. Don't do anythin and wait for my next question.

    ```
    [repo]
    repo.ansi.example.com ansible_host=192.168.55.199 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    [control]
    control.ansi.example.com ansible_host=192.168.55.200 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    [node1]
    node1.ansi.example.com ansible_host=192.168.55.201 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    [node2]
    node2.ansi.example.com ansible_host=192.168.55.202 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    [node3]
    node3.ansi.example.com ansible_host=192.168.55.203 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    [node4]
    node4.ansi.example.com ansible_host=192.168.55.204 ansible_user=vagrant ansible_ssh_pass=vagrant ansible_python_interpreter=/usr/bin/python3
    ```

    # RHCE exam objectives

    As an RHCE exam candidate, you should be able to handle all responsibilities expected of a Red Hat Certified System Administrator, including these tasks:

    + **Be able to perform all tasks expected of a Red Hat Certified System Administrator**
      + Understand and use essential tools
      + Operate running systems
      + Configure local storage
      + Create and configure file systems
      + Deploy, configure, and maintain systems
      + Manage users and groups
      + Manage security
    + **Understand core components of Ansible**
      + Inventories
      + Modules
      + Variables
      + Facts
      + Plays
      + Playbooks
      + Configuration files
    + **Install and configure an Ansible control node**
      + Install required packages
      + Create a static host inventory file
      + Create a configuration file
    + **Configure Ansible managed nodes**
      + Create and distribute SSH keys to managed nodes
      + Configure privilege escalation on managed nodes
      + Validate a working configuration using ad hoc Ansible commands
    + **Script administration tasks**
      + Create simple shell scripts
      + Create simple shell scripts that run ad hoc Ansible commands
    + **Create and use static inventories to define groups of hosts**
    + **Create Ansible plays and playbooks**
      + Know how to work with commonly used Ansible modules
      + Use variables to retrieve the results of running a command
      + Use conditionals to control play execution
      + Configure error handling
      + Create playbooks to configure systems to a specified state
    + **Use Ansible modules for system administration tasks that work with:**
      + Software packages and repositories
      + Services
      + Firewall rules
      + File systems
      + Storage devices
      + File content
      + Archiving
      + Scheduled tasks
      + Security
      + Users and groups
    + **Create and use templates to create customized configuration files**
    + **Work with Ansible variables and facts**
    + **Create and work with roles**
    + **Download roles from an Ansible Galaxy and use them**
    + **Use Ansible Vault in playbooks to protect sensitive data**
    + **Use provided documentation to look up specific information about Ansible modules and commands**

    As with all Red Hat performance-based exams, configurations must persist after reboot without intervention.

### Question 2: Create practice exam

    Create a practice exam using the RHCE objectives and inventory file provided before. Be very specific about the tasks. For example:
    + Don't just say to create a user, specify the user name and attributes.
    + Don't just ask to copy a file to a node, specify the name, file attribute and contents.
    + If you specify a new jinja2 template file, include the contents.
    + If you specify a new config file, include the contents.
