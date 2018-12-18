#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
declare -r REPO_ROOT
cd "${REPO_ROOT}"

# install ansible with yum
yum install -y ansible