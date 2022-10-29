#!bin/sh

### If /opt/html is empty then create Laravel project in /opt/html
if [ -d /opt/html ] ; then
composer create-project laravel/laravel --prefer-dist --remove-vcs .
chmod -R 777 /opt/html/storage
fi

### Start php-fpm
echo "START PHP-FPM";
service php7.4-fpm start

### Start Nginx
echo "START NGINX";
nginx -g "daemon off;"