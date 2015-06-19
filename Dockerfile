FROM php:5.6-apache

RUN a2enmod rewrite

# PHP extensions for drupal (https://github.com/docker-library/drupal Dockerfile)
RUN apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip

# Install Tools and SSH server
RUN apt-get install -y curl wget git vim openssh-server

# Install Composer and Drush
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer global require drush/drush:7.*
RUN composer global update
RUN ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

## Install MySql
ENV DEBIAN_FRONTEND noninteractive                  # avoids prompt for mysql root password
RUN apt-get install -y mysql-server mysql-client 

## Install Commerce Kickstarter
WORKDIR /var/www/html
ENV KICKSTART_VERSION 7.x-2.25
RUN curl -fSL "http://ftp.drupal.org/files/projects/commerce_kickstart-${KICKSTART_VERSION}-core.tar.gz" -o kickstart.tar.gz \
    && tar xz --strip-components=1 -f kickstart.tar.gz \
    && rm  kickstart.tar.gz \
    && chown -R www-data:www-data sites

