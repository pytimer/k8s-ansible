#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
declare -r REPO_ROOT
cd "${REPO_ROOT}"

# install ansible with yum
yum update -y
yum install -y epel-release
yum install -y ansible

# setting ansible configurations
sed -i "s|^#roles_path.*|roles_path = ${REPO_ROOT}/roles|g" /etc/ansible/ansible.cfg
sed -i "s|^#host_key_checking.*|host_key_checking = False|g" /etc/ansible/ansible.cfg
sed -i "s|^#log_path.*|log_path = ${REPO_ROOT}/ansible.log|g" /etc/ansible/ansible.cfg
sed -i "s|^#stdout_callback.*|stdout_callback = debug|g" /etc/ansible/ansible.cfg
sed -i "s|^#callback_whitelist.*|callback_whitelist = profile_tasks|g" /etc/ansible/ansible.cfg
sed -i "s|^#ansible_managed.*|ansible_managed = This file is managed by k8s-ansible. date: %Y-%m-%d %H:%M:%S|g" /etc/ansible/ansible.cfg