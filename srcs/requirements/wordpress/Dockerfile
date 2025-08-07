FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    php-fpm

# Create missing directory
RUN mkdir -p /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/.

CMD ["php-fpm7.4", "-F"]