#!/usr/bin/env bash

# from pim project
set -e

docker-compose -f docker-compose-build.yml exec --user=akeneo akeneo bash -c "COMPOSER_MEMORY_LIMIT=-1 composer update"
docker-compose -f docker-compose-build.yml exec --user=akeneo akeneo rm -rf var/cache/*
docker-compose -f docker-compose-build.yml exec --user=akeneo akeneo bin/console --env=prod pim:installer:assets --symlink --clean
docker-compose -f docker-compose-build.yml exec --user=akeneo akeneo rm -rf var/cache/*
docker-compose -f docker-compose-build.yml exec --user=akeneo akeneo bin/console --env=prod pim:install --force --symlink --clean

docker-compose -f docker-compose-build.yml run --rm node yarn install
docker-compose -f docker-compose-build.yml run --rm node yarn run webpack
