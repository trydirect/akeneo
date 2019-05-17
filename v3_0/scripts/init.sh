# from pim project
set -e
cd "$(dirname "$0")"
cd ./../../

if [ ! -f ./app/config/parameters.yml ]; then
    cp ./app/config/parameters.yml.dist ./app/config/parameters.yml
    sed -i "s/database_host:.*localhost/database_host: mysql/g" ./app/config/parameters.yml
    sed -i "s/localhost: 9200/elastic:changeme@elasticsearch:9200/g" ./app/config/parameters.yml
fi

docker-compose exec akeneo php -d memory_limit=3G /usr/local/bin/composer update
docker-compose run --rm node yarn install

docker-compose exec akeneo rm -rf var/cache/*
docker-compose exec akeneo bin/console --env=prod pim:installer:assets --symlink --clean
docker-compose run --rm node yarn run webpack-dev

docker-compose exec akeneo rm -rf var/cache/*
docker-compose exec akeneo bin/console --env=prod pim:install --force --symlink --clean
docker-compose run --rm node yarn run webpack-dev
