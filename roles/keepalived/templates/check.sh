#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

curl -s --cacert {{ etcd_cert_path }}/ca.crt --cert {{ etcd_cert_path }}/healthcheck-client.crt --key {{ etcd_cert_path }}/healthcheck-client.key --cert-type PEM --key-type PEM https://127.0.0.1:{{ etcd_port|default(2379) }}/health | grep \"true\"

curl -XGET -k https://127.0.0.1:{{ kube_apiserver_secure_port }}/healthz | grep ok
