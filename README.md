[![Build Status](https://travis-ci.com/trydirect/akeneo.svg?branch=master)](https://travis-ci.com/trydirect/akeneo)
![Docker Stars](https://img.shields.io/docker/stars/trydirect/akeneo.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/trydirect/akeneo.svg)
![Docker Automated](https://img.shields.io/docker/cloud/automated/trydirect/akeneo.svg)
![Docker Build](https://img.shields.io/docker/cloud/build/trydirect/akeneo.svg)
[![Gitter chat](https://badges.gitter.im/trydirect/community.png)](https://gitter.im/try-direct/community)

# akeneo
Deploy Akeneo with docker-compose.yml


## Note
Before installing this project, please, make sure you have installed docker and docker-compose

To install docker execute: 
```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
$ pip install docker-compose
```
## Installation
Clone this project into your work directory:
```sh
$ git clone "https://github.com/trydirect/akeneo.git"
```
Then build it via docker-compose:
```sh
$ cd akeneo
$ docker-compose up -d
```


## Quick deployment to cloud
##### Amazon AWS, Digital Ocean, Hetzner and others
[<img src="https://img.shields.io/badge/quick%20deploy|3.0-%40try.direct-brightgreen.svg">](https://try.direct/server/user/deploy/ImFrZW5lbzN8NnwyMSI.EAoFeA.C7647Nw1nehXGsu5_PBehkI5tz8/)
[<img src="https://img.shields.io/badge/quick%20deploy|2.0.22-%40try.direct-brightgreen.svg">](https://try.direct/server/user/deploy/ImFrZW5lb3w2fDIyIg.EAoFeA.JtCgx-NVqUqpyP47-VKSAVN2pRo/)



# Contributing

1. Fork it (https://github.com/trydirect/akeneo/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request
