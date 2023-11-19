#!/bin/bash

ansible all -m group -a 'name=automation' -u vagrant -b -k
ansible all -m user -a 'name=automation \
	group=automation \
	groups=wheel \
	append=yes' -u vagrant -b  -k
ansible all -m file -a 'path=/home/automation/.ssh \
	state=directory \
	owner=automation \
	group=automation \
	mode=0700' -u vagrant -b -k
ansible all -m lineinfile -a 'path=/home/automation/.ssh/authorized_keys \
	create=yes \
	owner=automation \
	group=automation \
	mode=0600 \
	line="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC84L3g/uFMnvDyM0ZIX33EvWIM/KMM0fZVdxhQGrt4ZMqakKOWXUurIA5A/gcUyx+41mmmkLcxZFjbI/j4nbX/qCvm3GOWe4MTTrhawKxjzxhZbKREzk73vC3UJpPvoxmg87W4xBleO70kfpyZ9hjSqPP3COEUnY37KEd/WmxPqFNd17ls6eRH1BpxvFZO/vTOioRMlF33dmxrqvuwr3SlDhEC6EKzSLr3bPDMxmD+KHA5x/Db6CkHSj3k9vkBj9hDlWHcrBtM7y9ZZTLwrORVKbldzOST8womG9wP625CkbDArDoFNAQ+Q1YaUXHGXBczoHzugr7iwFl7M9jDQViqOO3g6PlYPa+X8umt7vA6bUVz+CYOrcyJJ1dHrc861VZKkMa4UxgdRw98oW6p16cWIdjgl47I6WoRMo+T1SYgii66beBidP7ht24Bqng1e1DevKqeLWcqSdPvlBqZtiGHwJdBBBF9FrWc4x7WMq43bByV7BYXApa446M/IxRmT4U= automation"' -u vagrant -b -k
ansible all -m lineinfile -a "path=/etc/sudoers \
	regexp='^%wheel	ALL=(ALL)' \
        line='%wheel	ALL=(ALL)	NOPASSWD: ALL' \
	validate='/usr/sbin/visudo -cf %s'" -u vagrant -b -k
