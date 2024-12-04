#!/bin/bash

# Update system
yum update -y

# Install required packages
amazon-linux-extras enable php8.0
yum install -y httpd mysql php php-mysqlnd wget unzip

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Download and configure WordPress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
cp -r wordpress/* /var/www/html/

# Set permissions
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/

# Configure wp-config.php
cat > /var/www/html/wp-config.php <<EOF
<?php
define( 'DB_NAME', '${db_name}' );
define( 'DB_USER', '${db_user}' );
define( 'DB_PASSWORD', '${db_password}' );
define( 'DB_HOST', '${db_endpoint}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

# Restart Apache
systemctl restart httpd

# Create the WordPress database
#mysql -h ${db_endpoint} -u ${db_user} -p${db_password} -e "CREATE DATABASE wordpress;"