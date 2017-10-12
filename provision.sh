#!/usr/bin/env bash


# Environment Laravel original provisioning script
# https://github.com/dung13890

# Update Package List
apt-get update
apt-get install -y software-properties-common locales

locale-gen en_US.UTF-8

echo "LANGUAGE=en_US.UTF-8" >> /etc/default/locale
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
echo "LC_CTYPE=UTF-8" >> /etc/default/locale

export LANG=en_US.UTF-8

# PPA
apt-add-repository ppa:ondrej/php -y

# Install PHP-CLI 7, some PHP extentions
apt-get update
apt-get install -y --force-yes \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-json \
    php7.0-xml \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-pgsql \
    php7.0-sqlite \
    php7.0-sqlite3 \
    php7.0-zip \
    php7.0-memcached \
    php7.0-gd \
    php7.0-fpm \
    php7.0-xdebug \
    php7.0-bcmath \
    php7.0-intl \
    php7.0-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libssl-dev \
    libxml2-dev \
    xz-utils \
    sqlite3 \
    libsqlite3-dev \
    git \
    curl \
    vim \
    zip \
    unzip \
    supervisor

# Remove load xdebug extension
sed -i 's/^/;/g' /etc/php/7.0/cli/conf.d/20-xdebug.ini

# Set php7.0-fpm
sed -i "s/listen =.*/listen = 0.0.0.0:9000/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 20M/" /etc/php/7.0/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 25M/" /etc/php/7.0/fpm/php.ini
mkdir -p /var/run/php
mkdir -p /var/log/php-fpm
touch /var/run/php/php7.0-fpm.sock

# Install Composer, PHPCS
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require "squizlabs/php_codesniffer=*"

# Create symlink
ln -s /root/.composer/vendor/bin/phpcs /usr/bin/phpcs

# Install Nodejs
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
npm install -g bower eslint

# Clean up
apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
