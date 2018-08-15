FROM alpine:3.6
LABEL Maintainer="Stephan Kropop <post@makakken.de>" \
      Description="Lightweight container with Nginx 1.12 & PHP-FPM 7.1 based on Alpine Linux."

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-pdo_mysql php7-json php7-openssl php7-curl php7-tokenizer php7-xmlwriter \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-session php7-xmlreader php7-ctype php7-opcache \
    php7-mbstring php7-gd php7-simplexml nginx supervisor curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure nginx
COPY config_docker/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config_docker/fpm-pool.conf /etc/php7/php-fpm.d/03_bonobo.conf

# Configure supervisord
COPY config_docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add Cronjob
COPY config_docker/cron /etc/periodic/15min/cron
RUN chmod a+x /etc/periodic/15min/cron

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN composer create-project --no-interaction --prefer-dist cakephp/app .
RUN chmod -R 755 /var/www/html/tmp
RUN chmod -R 755 /var/www/html/logs
RUN chown -R nobody:nogroup /var/www/html/tmp
RUN chown -R nobody:nogroup /var/www/html/logs

# Install Additional Composer packages
# RUN composer require cakedc/users

EXPOSE 80 443

WORKDIR /var/log
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
