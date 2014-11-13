docker-postgresql
=================

Postgresql docker

##Build the container

    docker build -t your_container_name:version .

##Run it

    docker run -d --name your_instance_name yourcontainername:version
   
Example

    docker build -t postgresql:v1 .
    docker run -d --name mydb postgresql:v1

postgresql will autostart and run as a daemon.
superuser is docker with password docker

## Get inside with a shell
If your postgres container isn't ready yet or you just want to look around with a shell

    docker run --name mydb -t -i postgresql:v1 /bin/bash

images are build from [`phusion/baseimage`](https://github.com/phusion/baseimage-docker), you can connect to them through ssh if you expose port 22.
my dockerfile include all public keys stored in pubkeys dir.

You can also just use docker exec to run a bash process in an existing container

    docker exec -t -i mydb bash


