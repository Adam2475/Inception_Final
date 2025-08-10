FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    php-fpm \
    php-mysqli \
    curl

# Create missing directory
RUN mkdir -p /run/php

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/.
COPY ./tools/init.sh .

RUN chmod +x init.sh

CMD ["./init.sh"]