FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    nginx \
    openssl

COPY ./tools/default /etc/nginx/sites-available/.
COPY ./tools/certs.sh /tmp/certs.sh

# RUN mkdir -p requirements/nginx/ssl
RUN chmod +x ./tmp/certs.sh && ./tmp/certs.sh

# COPY ./tmp/nginx.crt /etc/nginx/ssl/nginx.crt
# COPY ./tmp/nginx.key /etc/nginx/ssl/nginx.key

CMD ["nginx", "-g", "daemon off;"]