FROM debian

RUN groupadd -r mysql && useradd -r -g mysql mysql --home-dir /var/lib/mysql

RUN apt-get update

RUN mkdir -p /var/lib/mysql/mysql; touch /var/lib/mysql/mysql/user.frm; \
    apt install -y --no-install-recommends mariadb-server; \
    rm -rf /var/lib/mysql; \
    mkdir -p             /var/lib/mysql /run/mysqld; \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld; \
    chmod 1777 /run/mysqld

VOLUME /var/lib/mysql/
EXPOSE 3306

COPY src/ /

CMD /startup.sh
