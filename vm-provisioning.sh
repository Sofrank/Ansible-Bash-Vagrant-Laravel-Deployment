#!/bin/bash

green_echo() {
  echo -e "\e[32m$1\e[0m"
}


green_echo "Provisioning vagrant Machines..."
#-----------------------------------------------
# Provision Vagrant Machines Based on vagrantfile Content
#-----------------------------------------------
vagrant up


green_echo "Done!"