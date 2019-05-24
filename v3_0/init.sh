#!/usr/bin/env bash

# from pim project
set -e

docker-compose -f docker-compose-build.yml exec --user=travis akeneo php -d memory_limit=3G composer.phar update
docker-compose -f docker-compose-build.yml exec --user=travis akeneo rm -rf var/cache/*
docker-compose -f docker-compose-build.yml exec --user=travis akeneo bin/console --env=prod pim:installer:assets --symlink --clean
docker-compose -f docker-compose-build.yml exec --user=travis akeneo rm -rf var/cache/*
docker-compose -f docker-compose-build.yml exec --user=travis akeneo bin/console --env=prod pim:install --force --symlink --clean

docker-compose -f docker-compose-build.yml run --rm node yarn install
docker-compose -f docker-compose-build.yml run --rm node yarn run webpack-dev
docker-compose -f docker-compose-build.yml run --rm node yarn run webpack-dev
