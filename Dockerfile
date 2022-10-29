FROM ubuntu:20.04

RUN mkdir /opt/html
WORKDIR /opt/html

# 日付設定
ENV TZ Asia/Tokyo

# これをしないと　apt install　の途中で止まっちゃう
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt-get update

# 基本コマンドインストール
RUN apt install curl zip php-curl git -y

# PHP7.4インストール
RUN apt install php7.4 php7.4-mbstring php7.4-dom -y
RUN apt-get install php-mysql php7.4-gd -y

# php.iniをコピー
COPY php.ini /etc/php/7.4/fpm/

# Composerインストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer

# npm,nodejsインストール
RUN apt install npm -y
RUN npm install -g n
RUN n latest

# PHP-FPMインストール
RUN apt install php7.4-fpm -y

# nginxインストール
RUN apt install nginx -y
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# 設定ファイルをコピー
COPY default /etc/nginx/sites-available/

# copy docker-entrypoint.sh & grant execute permission
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
STOPSIGNAL SIGQUIT

### PID1　measures(k8s compatible)
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

### Start Process
CMD ["bash", "/docker-entrypoint.sh"]