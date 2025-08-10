FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install \
    mariadb-server -y \
    gettext-base -y

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY ./tools/init.sql /etc/mysql/init.sql
COPY ./tools/script.sh .

RUN mkdir /run/mysqld && chmod +x /script.sh

CMD ["./script.sh"]