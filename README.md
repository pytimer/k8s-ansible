Kansible
----------------------------------

This repository setup the Kubernetes cluster with kubeadm via ansible.

This repository have some restrictions now. you can see below `Restrictions`.

## Restrictions

- os: CentOS

- CRI: docker

- CNI: flannel

## Requirements

### OS

CentOS 7.4

### Ansible

Install the Kubernetes cluster via ansible, so you should install ansible in your machine.

Ansible installation guide you can open [ansible offical document](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

This repository now only support `CentOS 7.4`, so you install ansible with yum.

## Installation

### Configures Ansible

```ini
roles_path    = /root/kansible/roles

# uncomment this to disable SSH key host checking
#host_key_checking = False
host_key_checking = False

# change the default callback, you can only have one 'stdout' type  enabled at a time.
#stdout_callback = skippy
stdout_callback = debug

callback_whitelist = profile_tasks

ansible_managed = This file is managed by kansible. date: %Y-%m-%d %H:%M:%S

```

### Set ansible hosts information.

Add your hosts into `inventory/hosts.ini`, format like:

`k8s-1 ansible_ssh_host=1.2.3.4 ansible_ssh_port=22 ansible_ssh_user=root ansible_ssh_pass=123456`

You can choose which hosts to use as the master role, and which hosts to use as the node role.

> `kube-masters` install components, include: `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `etcd`

> `kube-nodes` install components, include: `kubelet`.

> all hosts install `docker`, `kube-proxy`, `kube-flannel`.

### Set ansible variables

Ansible variables in `inventory/group_vars/all.yml`.

### Setup

`ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml`