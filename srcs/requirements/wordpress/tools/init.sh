#!/bin/bash
cd /var/www/html

# Load secrets content into variables
WP_ADMIN_PASSWORD=$(cat /run/secrets/db_root_password)
WP_PASSWORD=$(cat /run/secrets/db_password)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
# Also read credentials email if needed:
WP_ADMIN_EMAIL=$(cat /run/secrets/credentials)


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
./wp-cli.phar core download --allow-root
# set up wp-config user to database access
./wp-cli.phar config create \
    --dbname=${WP_DB_NAME} \
    --dbuser=${WP_USER} \
    --dbpass=${WP_PASSWORD} \
    --dbhost=${WP_HOST} \
    --allow-root

./wp-cli.phar core install \
    --url="${WP_URL}" \
    --title="${WP_TITLE}"  \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

./wp-cli.phar option update home '${WP_URL}' --allow-root
./wp-cli.phar option update siteurl '${WP_URL}' --allow-root
#https://adapassa.42.fr
# create a user with author role
# allow root when creating user
./wp-cli.phar user create ${DB_USER} ${DB_EMAIL} --role=author --user_pass=${DB_PASSWORD} --allow-root

php-fpm7.4 -F