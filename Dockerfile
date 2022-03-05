FROM ubuntu

ENV TZ=Europe/Minsk
RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime
RUN echo "$TZ" > /etc/timezone

RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y tzdata
RUN apt-get install -y nginx
RUN apt-get install -y python3-pymysql
RUN apt-get install -y php
RUN apt-get install -y php-fpm
RUN apt-get install -y php-mysql
COPY files/nginx.conf /etc/nginx/sites-available/
COPY files/nginx.conf  /etc/nginx/sites-enabled/
COPY files/index.php /var/www/html/
COPY --chown=www-data:www-data . /var/www/html
WORKDIR /var/www/html
EXPOSE 80 443
RUN echo "exit 0" > /usr/sbin/policy-rc.d
CMD /etc/init.d/php7.4-fpm restart && nginx -g "daemon off;"

