# from first part of drupal:7 (https://hub.docker.com/_/drupal/)
FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip

WORKDIR /var/www/html

# Install from kickstart package
ENV KICKSTART_VERSION 7.x-2.36
ENV KICKSTART_MD5 2ac4d251fffa354fc0789b3531d737a7
ENV KS=kickstart.tar.gz

RUN curl -fSL "https://ftp.drupal.org/files/projects/commerce_kickstart-${KICKSTART_VERSION}-core.tar.gz" -o ${KS} \
	&& echo "${KICKSTART_MD5} ${KS}" | md5sum -c - \
	&& tar -xz --strip-components=1 -f ${KS} \
	&& rm ${KS} \
	&& chown -R www-data:www-data sites

# Install Drush
RUN curl -fSL "http://files.drush.org/drush.phar" -o /usr/local/bin/drush \
	&& chmod +x /usr/local/bin/drush
