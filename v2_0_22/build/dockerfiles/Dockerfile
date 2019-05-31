FROM ubuntu:16.04
RUN apt-get  -y -qq update; apt-get -y -qq install software-properties-common; \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y; apt-get update -y -qq; \
    apt-get install -y -qq wget nginx sudo supervisor php7.1-apcu php7.1-bcmath php7.1-cli \
    php7.1-curl php7.1-fpm php7.1-gd php7.1-intl php7.1-mcrypt  php7.1-mysql php7.1-soap \
    php7.1-xml php7.1-zip php7.1-imagick cron; \
    rm -rf /etc/nginx/sites-available/default; rm -rf /etc/nginx/sites-enabled/default;  mkdir /run/php; \
    groupadd -r -g 2000  akeneo; useradd -r -u 2000 -g 2000 -m -c "Akeneo account" -d /home/akeneo -s /bin/bash akeneo; \
    mkdir -p /opt/letsencrypt
# COPY ./src/app.tar.gz /usr/src/app.tar.gz
RUN wget https://download.akeneo.com/pim-community-standard-v2.0-latest-icecat.tar.gz -O /usr/src/app.tar.gz
RUN  chown akeneo:akeneo  /usr/src/app.tar.gz
ADD configs/php/cli/php.ini /etc/php/7.1/cli/php.ini
ADD configs/php/fpm/php.ini /etc/php/7.1/fpm/php.ini
ADD configs/php/www.conf /etc/php/7.1/fpm/pool.d/www.conf
ADD configs/supervisord/akeneo.conf /etc/supervisor/conf.d/akeneo.conf
ADD scripts/letsencrypt-auto /opt/letsencrypt/letsencrypt-auto
RUN chmod +x /opt/letsencrypt/letsencrypt-auto; /opt/letsencrypt/letsencrypt-auto  --os-packages-only --install-only --non-interactive

RUN apt-get clean; apt-get autoclean; apt-get autoremove -y -qq

USER akeneo
ENV HOME /home/akeneo
WORKDIR /home/akeneo
