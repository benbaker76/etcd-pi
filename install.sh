#!/bin/bash
set -e
ansible-playbook -i hosts.ini ./certs.yml
ansible-playbook -i hosts.ini ./etcd.yml
