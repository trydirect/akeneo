#!/usr/bin/env bash
# from pim project
set -e
cd "$(dirname "$0")"
cd ../


docker exec -it akeneo bash -c "php -d memory_limit=3G /home/akeneo/composer.phar update"
docker-compose -f docker-compose-build.yml run --rm node yarn install

docker exec -it akeneo rm -rf var/cache/*
docker exec -it akeneo bin/console --env=prod pim:installer:assets --symlink --clean
docker-compose -f docker-compose-build.yml run --rm node yarn run webpack-dev

docker exec -it akeneo rm -rf var/cache/*
docker exec -it akeneo bin/console --env=prod pim:install --force --symlink --clean
docker-compose -f docker-compose-build.yml run --rm node yarn run webpack-dev
