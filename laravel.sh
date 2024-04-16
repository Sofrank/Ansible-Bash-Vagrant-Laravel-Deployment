#!/bin/bash

green_echo() {
  echo -e "\e[32m$1\e[0m"
}

readonly DB_PASSWORD="CloudDevops247"
readonly DB_DATABASE="laravel_db"


#-----------------------------------------------
# Update and Upgrade
#-----------------------------------------------
sudo apt update
sudo apt upgrade -y


#-----------------------------------------------
# Install Apache and MySQL (MariaDB)
#-----------------------------------------------
green_echo "Installing MYSQL"
sudo apt install -y apache2 mariadb-server git


#-----------------------------------------------
# Set MySQL Root Password and Create Database
#-----------------------------------------------
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
CREATE DATABASE $DB_DATABASE;
EOF


#-----------------------------------------------
# Install PHP Version 8.2
#-----------------------------------------------
green_echo "Installing PHP 8.2 and its components"
sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
echo | sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.2 php8.2-mysql php8.2-curl php8.2-xml php8.2-zip zip unzip


#-----------------------------------------------
# Install Composer
#-----------------------------------------------
green_echo "Installing Composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer


#-----------------------------------------------
# Increase PHP memory limit for the duration of the composer install
#-----------------------------------------------
sudo sed -i 's/memory_limit = .*/memory_limit = -1/' /etc/php/8.2/apache2/php.ini


#-----------------------------------------------
# Start and Enable Apache
#-----------------------------------------------
sudo systemctl start apache2
sudo systemctl enable apache2


#-----------------------------------------------
# Clear Composer Cache an Self Update
#-----------------------------------------------
composer clearcache
composer selfupdate


#-----------------------------------------------
# Create and Change Laravel Directory Ownership
#-----------------------------------------------
sudo mkdir -p /var/www/laravel
sudo chown -R www-data:www-data /var/www/laravel


#-----------------------------------------------
# Clone Laravel GitHub Repo
#-----------------------------------------------
sudo -u www-data git clone https://github.com/laravel/laravel.git /var/www/laravel


#-----------------------------------------------
# Cd Into Laravel Directory
#-----------------------------------------------
sudo chown -R "$USER" /var/www/laravel
cd /var/www/laravel || exit


#-----------------------------------------------
# Install Composer Dependencies & Increase Memory Limit
#-----------------------------------------------
php -d memory_limit=-1 /usr/bin/composer install


#-----------------------------------------------
# Restore PHP Memory Limit
#-----------------------------------------------
sudo sed -i 's/memory_limit = -1/memory_limit = 128M/' /etc/php/8.2/apache2/php.ini


#-----------------------------------------------
# Create .env File
#-----------------------------------------------
cp .env.example .env


#-----------------------------------------------
# Update .env File With Database Connection Settings
#-----------------------------------------------
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$DB_DATABASE/g" /var/www/laravel/.env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=$DB_PASSWORD/g" /var/www/laravel/.env


#-----------------------------------------------
# Generate Application Key
#-----------------------------------------------
php artisan key:generate


#-----------------------------------------------
# Create Apache Virtual Host Configuration
#-----------------------------------------------
sudo tee /etc/apache2/sites-available/laravel.conf <<EOF
<VirtualHost *:80>
    ServerAdmin 192.168.56.5
    DocumentRoot /var/www/laravel/public

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/laravel/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF


#-----------------------------------------------
# Enable the Laravel Site & Disable Apache Default Site
#-----------------------------------------------
sudo a2ensite laravel
sudo a2dissite 000-default


#-----------------------------------------------
# Reload Apache to apply changes
#-----------------------------------------------
sudo systemctl reload apache2


#-----------------------------------------------
# migrate database and tables
#-----------------------------------------------
php artisan migrate


#-----------------------------------------------
# Display installation completed message
#-----------------------------------------------
green_echo "Laravel application has been deployed and configured successfully!"
