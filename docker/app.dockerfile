FROM php:7.4.24-fpm

# Update packages
RUN apt-get update

# Install PHP and composer dependencies
RUN apt-get install -qq git curl libmcrypt-dev libjpeg-dev libpng-dev libfreetype6-dev libbz2-dev

# Clear out the local repository of retrieved package files
# RUN apt-get clean

# Install needed extensions
# Here you can install any other extension that you need during the test and deployment process
RUN apt-get clean \
    &&  pecl install mcrypt-1.0.4 \
    && apt-get install -y libpq-dev \
    && apt-get install -y libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip gd pcntl opcache bcmath

# Installs Composer to easily manage your PHP dependencies.
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD php-fpm