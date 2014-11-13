docker-postgresql
=================

Postgresql docker

##Build the container

    docker build -t your_container_name:version .

##Run it

    docker run -d --name your_instance_name yourcontainername:version

postgresql will autostart and run.
superuser is docker with password docker

##Get a shell inside  
	
    docker exec -it your_instance_name bash

or use ssh :
Put your public key in the pubkeys directory instead of mine and expose the port to the host with

    docker run -d --name your_instance_name -p your_port_number:22 your_container_name:version
