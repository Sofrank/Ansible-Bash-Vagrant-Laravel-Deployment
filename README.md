# Cloud Engineering Second Semester Examination Project

(Deploy Laravel and Set up Postgresql)

## Objective

- Automate the provisioning of two Ubuntu-based servers, named “Master” and “Slave”, using Vagrant.
- On the Master node, create a bash script to automate the deployment of a LAMP (Linux, Apache, MySQL, PHP) stack.
- This script should clone a PHP application from GitHub, install all necessary packages, and configure Apache web server and MySQL.
- Ensure the bash script is reusable and readable.
- Using an Ansible playbook:

1. Execute the bash script on the Slave node and verify that the PHP application is accessible through the VM’s IP address (take screenshot of this as evidence)
2. Create a cron job to check the server’s uptime every 12 am.

## Requirements

1. Submit the bash script and Ansible playbook to (publicly accessible) GitHub repository.
2. Document the steps with screenshots in md files, including proof of the application’s accessibility (screenshots taken where necessary)
3. Use either the VM’s IP address or a domain name as the URL.

## PHP Laravel GitHub Repository:

[Laravel Repo](https://github.com/laravel/laravel)

### Helpful Links:

https://medium.com/@melihovv/zero-time-deploy-of-laravel-project-with-ansible-3235816676bb

https://www.cherryservers.com/blog/how-to-install-and-setup-postgresql-server-on-ubuntu-20-04

https://dev.to/sureshramani/how-to-deploy-laravel-project-with-apache-on-ubuntu-36p3

https://docs.ansible.com/

## Steps:

### 1. Running the VM Provisioning Script

![Provisioning Script](./Screenshots/Running%20the%20VM%20Provisioning%20Script.png)

### 2. Successful Provisioning

![Successful Provisioning](./Screenshots/Success%20VM%20Provisioning.png)
![Provision Success](./Screenshots/Provision%20Successful.png)

### 3. Logged into Master node and generated SSH keys

![SSh Key-gen](./Screenshots/SSH%20Keygen.png)

### 4. Exited and logged into the Slave machine to edit sshd_config file and restart sshd.service

![sshd_config file](./Screenshots/editing%20sshdconfig%20file.png)

### 5. Logged out of the Slave machine and back into the Master machine to copy ssh keys

![copy ssh key](./Screenshots/sshcopyid%20and%20ssh%20connection%20success.png)

### 6. Copied Ansible directory and the Laravel script into the Master node

![copy ansible directory and Laravel script](./Screenshots/copied%20the%20ansible%20directory%20and%20laravel%20script%20to%20the%20master%20node.png)

### 7. Dray-ran the Ansible playbook

![ansible dry run](./Screenshots/Dry%20run%20successful.png)

### 8. Ansible Playbook ran

![It ran for real!](./Screenshots/Ansible%20playbok%20ran.png)

### 9. Screenshot of the Laravel page. Nite Note the IP address in the address bar

![Laravel page](./Screenshots/Screenshot%20of%20Laravel%20page.png)
