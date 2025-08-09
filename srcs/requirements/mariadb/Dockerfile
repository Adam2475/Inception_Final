FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install \
    mariadb-server -y \
    gettext-base -y

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/init.sql
COPY script.sh .

RUN mkdir /run/mysqld && chmod +x script.sh

CMD ["./script.sh"]