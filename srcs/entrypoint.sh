mkdir /var/www/localhost/

# Lien symbolique pour le .conf de nginx
ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/

# Certificat pour le site
echo "Generating SSL Certificate..."
mkdir /etc/nginx/ssl/
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=BE/ST=Bruxelles/L=Bruxelles/O=19 School/OU=cgoncalv/CN=localhost" > dev/null 2>&1

# phpMyAdmin
mkdir /var/www/localhost/phpmyadmin
echo "Downloading phpmyadmin..."
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz > dev/null 2>&1
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz  > dev/null 2>&1
cp -r phpMyAdmin-4.9.0.1-all-languages/. var/www/localhost/phpmyadmin/  > dev/null 2>&1

# Wordpress
echo "Downloading wordpress..."
curl -LO https://wordpress.org/latest.tar.gz  > dev/null 2>&1
tar xzvf latest.tar.gz  > dev/null 2>&1
mv wordpress /var/www/localhost
rm -rf latest.tar.gz
cp wp-config.php /var/www/localhost/wordpress/wp-config.php
rm -f wp-config.php

# Configuration de la database MYSQL
service mysql start
echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# Démarrage des services
service nginx start
service php7.3-fpm start

echo "Ready to use !"

# comment when -it
sleep infinity