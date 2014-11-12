docker-postgresql
=================

Postgresql docker

##Build the container

    docker build -t yourcontainername:version .

##Run it

    docker run -d --name yourinstancename yourcontainername:version

postgresql will autostart and run
superuser is docker with password docker

##Get a shell inside  
	
    docker exec -it yourinstancename bash

or use ssh :
Put your public key in the pubkeys directory instead of mine and expose the port to the host with

    docker run -d --name yourinstancename -p yourportnumber:22 yourcontainername:version
