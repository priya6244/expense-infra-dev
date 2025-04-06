#!/bin/bash

comp=$1
env=$2
echo "Component: $comp, Environment: $env"
dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/priya6244/expense-ansible-roles-tf.git main.yaml -e component=$comp -e environment=$env