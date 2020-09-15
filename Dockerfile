FROM php:5.6.40-fpm-alpine
RUN apk upgrade --update \
    && apk add --no-cache libzip-dev bzip2-dev postgresql-dev icu-dev libmemcached-dev libxml2-dev libxslt-dev libgcrypt-dev libjpeg-turbo-dev libpng-dev freetype-dev rabbitmq-c-dev libssh2-dev imap-dev git \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gd \
    && printf "\n" | pecl install memcached-2.2.0 \
    && printf "\n" | pecl install memcache-2.2.7 \
    && printf "\n" | pecl install redis-4.3.0 \
    && printf "\n" | pecl install mongo \
    && printf "\n" | pecl install mongodb-1.7.5 \
    && printf "\n" | pecl install amqp \
    && printf "\n" | pecl install ssh2-0.13 \
    && printf "\n" | pecl install https://xdebug.org/files/xdebug-2.5.5.tgz \
    && printf "\n" | pecl install rar \
    && printf "\n" | pecl install dbase-5.1.1 \
    && docker-php-ext-enable memcached memcache redis mongodb amqp ssh2 xdebug rar dbase \
    && docker-php-ext-install bcmath bz2 calendar exif opcache pdo_mysql mysql mysqli pdo_pgsql intl zip soap gd xsl pcntl sockets imap \
    && chmod 777 /var/log
ENV TIDY_VERSION=5.6.0
RUN apk add --no-cache --virtual .build_package build-base cmake 
RUN echo Install tidy-html5 library \
 	&& git clone --branch ${TIDY_VERSION} --depth 1 https://github.com/htacg/tidy-html5.git /tmp/tidy-html5 \
	&& cd /tmp/tidy-html5/build/cmake/ \
	&& cmake ../.. -DCMAKE_BUILD_TYPE=Release \
	&& make && make install \
	&& ln -s /usr/local/include/tidybuffio.h /usr/local/include/buffio.h \
	&& cd \
    && rm -rf /tmp/tidy-html5 \
    && apk del .build_package \
    && docker-php-ext-install tidy