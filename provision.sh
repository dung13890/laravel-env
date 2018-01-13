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
    php7.1-cli \
    php7.1-dev \
    php7.1-common \
    php7.1-curl \
    php7.1-json \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-pgsql \
    php7.1-sqlite \
    php7.1-sqlite3 \
    php7.1-zip \
    php7.1-memcached \
    php7.1-redis \
    php7.1-gd \
    php7.1-fpm \
    php7.1-xdebug \
    php7.1-bcmath \
    php7.1-intl \
    php7.1-dev \
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
sed -i 's/^/;/g' /etc/php/7.1/cli/conf.d/20-xdebug.ini

# Set php7.1-fpm
sed -i "s/listen =.*/listen = 0.0.0.0:9000/" /etc/php/7.1/fpm/pool.d/www.conf
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 20M/" /etc/php/7.1/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 25M/" /etc/php/7.1/fpm/php.ini
mkdir -p /var/run/php
mkdir -p /var/log/php-fpm
touch /var/run/php/php7.1-fpm.sock

# Install Composer, PHPCS
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require "squizlabs/php_codesniffer=*"

# Create symlink
ln -s /root/.composer/vendor/bin/phpcs /usr/bin/phpcs

# Install Nodejs
curl -sL https://deb.nodesource.com/setup_7.x | bash -
apt-get install -y nodejs
npm install -g bower

# Install yarn
curl -s https://dl.yarnpkg.com/debian/pubkey.gpg -o /tmp/yarn-pubkey.gpg
apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install yarn

# Clean up
apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
