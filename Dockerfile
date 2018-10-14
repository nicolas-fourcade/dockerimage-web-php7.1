FROM ubuntu:16.04
MAINTAINER Nicolas Fourcade <nicolas_fourcade@hotmail.com>

ADD ondrej-ubuntu-php-xenial.list /etc/apt/sources.list.d/
RUN apt-get update -y --fix-missing
# install php
RUN apt-get install -y --allow-unauthenticated php7.1 php7.1-bcmath php7.1-bz2 php7.1-cgi php7.1-cli php7.1-common php7.1-curl php7.1-dba php7.1-dev php7.1-enchant php7.1-fpm php7.1-gd php7.1-gmp php7.1-imap php7.1-interbase php7.1-intl php7.1-json php7.1-ldap php7.1-mbstring php7.1-mcrypt php7.1-odbc php7.1-opcache php7.1-phpdbg php7.1-pspell php7.1-readline php7.1-recode php7.1-soap php7.1-sqlite3  php7.1-tidy php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip php-xdebug
RUN apt-get -y install php-xdebug
RUN apt-get install apache2 libapache2-mod-php7.1 -y --allow-unauthenticated
RUN apt-get install git nodejs npm composer nano tree vim curl ftp -y --allow-unauthenticated
RUN npm install -g bower grunt-cli gulp
RUN apt-get install php-mbstring -y --allow-unauthenticated

#COMPOSER 
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#PHPUNIT 
RUN composer global require "phpunit/phpunit"
ENV PATH /root/.composer/vendor/bin:$PATH RUN ln -s /root/.composer/vendor/bin/phpunit /usr/bin/phpunit
ENV LOG_STDOUT **Boolean** ENV LOG_STDERR **Boolean** ENV LOG_LEVEL warn ENV ALLOW_OVERRIDE All ENV DATE_TIMEZONE UTC ENV TERM dumb COPY index.php /var/www/html/
COPY run-lamp.sh /usr/sbin/
RUN a2enmod rewrite
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html
VOLUME /var/www/html
VOLUME /var/log/httpd
RUN chmod 777 /var/www/html
RUN chmod 777 /var/log

EXPOSE 80