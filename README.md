# k8s-ansible

This repository setup the Kubernetes cluster with kubeadm via ansible.

This repository have some restrictions now. you can see below `Restrictions`.

## TODO

- [ ] join control plane nodes.

Now the repository only support one control plane node and multi workers, it will support multi control plane nodes late.

## Restrictions

- os: CentOS

- CRI: docker

- CNI: flannel

## Requirements

### OS

CentOS 7.4+

### Ansible

Install the Kubernetes cluster via ansible, so you should install ansible in your machine.

Ansible installation guide you can open [ansible offical document](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).

This repository now only support `CentOS 7.4+`, so you install ansible with yum.

## Installation

### Install Ansible

`/bin/bash install.sh`

### Set ansible hosts information

Add your hosts into `inventory/hosts.ini`, format like:

`k8s-1 ansible_ssh_host=1.2.3.4 ansible_ssh_port=22 ansible_ssh_user=root ansible_ssh_pass=123456`

You can choose which hosts to use as the master role, and which hosts to use as the node role.

> `kube-masters` install components, include: `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `etcd`
>
> `kube-nodes` install components, include: `kubelet`.
>
> all hosts install `docker`, `kube-proxy`, `kube-flannel`.

### Set ansible variables

Ansible variables in `inventory/group_vars/all.yml`.

### Setup

`ansible-playbook -i inventory/hosts.ini playbooks/deploy.yml`

### Cluster

When you run setup command successfully, you can use `kubectl get nodes` to show your cluster all nodes, and run `kubectl get pod -n kube-system` to show all pods in you cluster.

#### Example

This is a Kubernetes cluster that have one control plane(master) and two workers.

The `inventory/hosts.ini` is like below:

```ini
k8s-1 ansible_ssh_host=192.168.46.11 ansible_ssh_port=22 ansible_ssh_user=root ansible_ssh_pass=123456
k8s-2 ansible_ssh_host=192.168.46.12 ansible_ssh_port=22 ansible_ssh_user=root ansible_ssh_pass=123456
k8s-3 ansible_ssh_host=192.168.46.13 ansible_ssh_port=22 ansible_ssh_user=root ansible_ssh_pass=123456

[kube-masters]
k8s-1

[kube-nodes]
k8s-2
k8s-3

[k8s-cluster:children]
kube-masters
kube-nodes

[etcd:children]
kube-masters
``` 

If cluster created successfully, you can see these nodes and below pods in `kube-system` namespace.

```bash
[root@k8s-1 ~]# kubectl get nodes
NAME    STATUS   ROLES    AGE     VERSION
k8s-1   Ready    master   15h     v1.14.1
k8s-2   Ready    <none>   15h     v1.14.1
k8s-3   Ready    <none>   15h     v1.14.1
```

```bash
[root@k8s-1 ~]# kubectl get pod -n kube-system
NAME                            READY   STATUS    RESTARTS   AGE
coredns-fb8b8dccf-6sqlr         1/1     Running   0          15h
coredns-fb8b8dccf-jr6n7         1/1     Running   0          15h
etcd-k8s-1                      1/1     Running   0          15h
kube-apiserver-k8s-1            1/1     Running   0          15h
kube-controller-manager-k8s-1   1/1     Running   0          15h
kube-flannel-ds-amd64-5l5r8     1/1     Running   0          15h
kube-flannel-ds-amd64-fz7f5     1/1     Running   0          15h
kube-flannel-ds-amd64-ll4g5     1/1     Running   0          15h
kube-proxy-m2tx8                1/1     Running   0          15h
kube-proxy-tssfg                1/1     Running   0          15h
kube-proxy-zcf4z                1/1     Running   0          15h
kube-scheduler-k8s-1            1/1     Running   0          15h
```