#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import docker
import requests

client = docker.from_env()

time.sleep(10)
for c in client.containers.list():
    print(c.name)
    print(c.status)

node = client.containers.get('node')
print(node.logs())


# PHP-FPM
php = client.containers.get('akeneo')
assert php.status == 'running'
php_conf = php.exec_run("php-fpm7.0 -t")
print(php_conf.output.decode())
assert 'configuration file /etc/php/7.0/fpm/php-fpm.conf test is successful' in php_conf.output.decode()
php_proc = php.exec_run("sh -c 'ps aux |grep php-fpm'")
print(php_proc.output.decode())
assert 'php-fpm: master process (/etc/php/7.0/fpm/php-fpm.conf)' in php_proc.output.decode()
assert 'fpm is running, pid' in php.logs()

nginx_cfg = php.exec_run("/usr/sbin/nginx -T")
print(nginx_cfg.output.decode())
assert 'server_name _;' in nginx_cfg.output.decode()
assert "error_log /proc/self/fd/2" in nginx_cfg.output.decode()
assert "location = /.well-known/acme-challenge/" in nginx_cfg.output.decode()
assert 'HTTP/1.1" 500' not in php.logs()

db = client.containers.get('db')
assert db.status == 'running'
mycnf = db.exec_run("/usr/sbin/mysqld --verbose  --help")
assert '/usr/sbin/mysqld  Ver 5.7' in mycnf.output.decode()
mysql_log = db.logs()
assert "mysqld: ready for connections" in mysql_log.decode()
print(mysql_log.decode())

# Elasticsearch
elastic = client.containers.get('akeneo_search')
assert elastic.status == 'running'
port = client.api.inspect_container('elasticsearch')['NetworkSettings']['Ports']['9200/tcp'][0]['HostPort']
response = requests.get("http://localhost:{}".format(port))
assert '"name" : "elasticsearch"' in response.text
assert '"number" : "5.4.3"' in response.text
assert response.status_code == 200
assert ' bound_addresses {0.0.0.0:9200}' in elastic.logs()

