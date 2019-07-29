FROM ubuntu:16.04
RUN apt-get  -y -qq update; apt-get -y -qq install software-properties-common; \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y; apt-get update -y -qq; \
    apt-get install -y nginx sudo supervisor php7.2-apcu php7.2-bcmath php7.2-cli \
    php7.2-curl php7.2-fpm php7.2-gd php7.2-intl php7.2-mysql php7.2-soap \
    php7.2-xml php7.2-zip php7.2-imagick cron curl unzip; \
    rm -rf /etc/nginx/sites-available/default; rm -rf /etc/nginx/sites-enabled/default;  mkdir /run/php; \
    groupadd -r -g 2000 akeneo; useradd -r -u 2000 -g 2000 -m -c "Akeneo account" -d /home/akeneo -s /bin/bash akeneo; \
    mkdir -p /opt/letsencrypt

ENV HOME /home/akeneo
WORKDIR /home/akeneo

RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin && \
        echo "alias composer='composer'" >> /root/.bashrc && \
        composer
COPY ./src/app-demodata.tar.gz /usr/src/app-demodata.tar.gz
COPY ./src/app.tar.gz /usr/src/app.tar.gz
RUN chown akeneo:akeneo  /usr/src/*
RUN chown akeneo:akeneo /var/lib/php/sessions
COPY ./configs/php/cli/php.ini /etc/php/7.2/cli/php.ini
COPY ./configs/php/fpm/php.ini /etc/php/7.2/fpm/php.ini
COPY ./configs/php/www.conf /etc/php/7.2/fpm/pool.d/www.conf
COPY ./configs/supervisord/akeneo.conf /etc/supervisor/conf.d/akeneo.conf
COPY ./scripts/letsencrypt-auto /opt/letsencrypt/letsencrypt-auto
RUN chmod +x /opt/letsencrypt/letsencrypt-auto; /opt/letsencrypt/letsencrypt-auto  --os-packages-only --install-only --non-interactive
# Clean up
RUN apt-get clean; apt-get autoclean; apt-get autoremove -y -qq && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 9000