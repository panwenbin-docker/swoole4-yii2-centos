FROM centos:7
RUN yum install -y http://repo1.sea.innoscale.net/remi/enterprise/remi-release-7.rpm \
  && yum install -y php71-php-cli php71-php-pdo php71-php-mysqlnd php71-php-gd php71-php-mbstring php71-php-xml php71-php-json php71-php-pecl-zip php71-php-pecl-swoole4 php71-php-process \
  && yum install -y git unzip \
  && ln -s /usr/bin/php71 /usr/bin/php \
  && yum clean all \
  && rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-* \
  && sed -i 's/display_errors = Off/display_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/log_errors = Off/log_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' /etc/opt/remi/php71/php.ini \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && mv composer.phar /usr/bin/composer \
  && rm -f composer-setup.php
  
EXPOSE 9000

CMD ["php-fpm", "-F"]
