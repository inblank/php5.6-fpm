FROM php:5.6.40-fpm-alpine
RUN apk upgrade --update \
    && apk add --no-cache libzip-dev bzip2-dev postgresql-dev icu-dev libmemcached-dev libxml2-dev libxslt-dev libgcrypt-dev libjpeg-turbo-dev libpng-dev freetype-dev rabbitmq-c-dev libssh2-dev git \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gd \
    && printf "\n" | pecl install memcached-2.2.0 \
    && printf "\n" | pecl install memcache-2.2.7 \
    && printf "\n" | pecl install redis-4.3.0 \
    && printf "\n" | pecl install mongo \
    && printf "\n" | pecl install mongodb \
    && printf "\n" | pecl install amqp \
    && printf "\n" | pecl install ssh2-0.13 \
    && printf "\n" | pecl install https://xdebug.org/files/xdebug-2.5.5.tgz \
    && printf "\n" | pecl install rar \
    && docker-php-ext-enable memcached memcache redis mongodb amqp ssh2 xdebug rar \
    && docker-php-ext-install bcmath bz2 calendar exif opcache pdo_mysql pdo_pgsql intl zip soap gd xsl pcntl sockets