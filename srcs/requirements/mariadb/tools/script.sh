#!/bin/bash
set -e

# Create dynamic init.sql by substituting variables
cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Initialize MariaDB data directory if not already done
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mysqld --initialize-insecure --user=mysql
fi

# Start MariaDB server in the background
mysqld --skip-networking &

# Wait for MariaDB to be ready
until mysqladmin ping &>/dev/null; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Execute init SQL script
mysql -u root < /tmp/init.sql

# Kill background mysqld
mysqladmin shutdown

# Start MariaDB in foreground (normal container process)
exec mysqld
