FROM        debian:buster-slim

RUN         apt-get -y update && apt-get -y install mariadb-server \
            nginx \
            openssl \
            curl \
            wget \
            php \
            php-fpm \
            php-mysql \
            php-mbstring

EXPOSE      80

COPY        srcs/entrypoint.sh .
COPY        srcs/wp-config.php .
COPY        srcs/default.conf etc/nginx/sites-available/
COPY        srcs/default_no_autoindex.conf tmp/

ENTRYPOINT  ["bash", "./entrypoint.sh"]
#CMD         ["bash"]
