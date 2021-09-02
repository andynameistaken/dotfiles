# Docker Project  
## JS App with MongoDB
---
1. Get `mongodb` (Database)
```shell
❯ docker pull mongo
```
2. Get `mongo-express` (Web-based MongoDB admin interface written with Node.js, Express and Bootstrap3

```shell
❯ docker pull mongo-express
```

3. Create new network
```bash
docker network-create mongo-network
```
Check networks with `docker network ls`
![[Screenshot 2021-08-22 at 13.46.25.png]]
4. Create `mongodb` container with root and password environmental variables and specified network:
Excerpt from official repo for MongoDB:
> Example `stack.yml` for `mongo`

```yaml
# Use root/example as user/password credentials
version: '3.1'

services:

  mongo:
    image: mongo
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root # <------------------------------ (environmental
      MONGO_INITDB_ROOT_PASSWORD: example # <--------------------------- variables)

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: example
      ME_CONFIG_MONGODB_URL: mongodb://root:example@mongo:27017/
```

```console
docker run -d \
-p 27017:27017 \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=secret \
--name mongodb \
--net mongo-network \
mongo 
```

- Environmental variables provide arguments for the docker containers upon its creation. 
 ![[Screenshot 2021-08-22 at 16.30.04.png]]

4. Create `mongo-express` container
To connect it to MongoDB we need to add:
- name of admin
- admin password
- name of the database server

![[Pasted image 20210824133347.png]]


```console
 docker run -d \							
-p 8081:8081 \								
-e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \	
-e ME_CONFIG_MONGODB_ADMINPASSWORD=secret \	
--net mongo-network \						
--name mongo-express \						
-e ME_CONFIG_MONGODB_SERVER=mongodb \		
mongo-express	
```

5. Create `my-db` database 
| ![[Pasted image 20210824224156.png]] |
| :------------------------------------ :|
| http://localhost:8081/               |
6. Create `users` collection in `my-db`

![[Pasted image 20210824233615.png]]

- to view constantly changes in logs: `docker logs [-f | --follow] [container_id | container_name]`
![[Pasted image 20210825125847.png]]![](app://local/%2FUsers%2Fandy%2FLibrary%2FMobile%20Documents%2FiCloud~md~obsidian%2FDocuments%2FVault%2FDocker%2Fimages%2FPasted%20image%2020210825125847.png?1629889127462?1629889127462)

## Putting `docker run` into Docker Compose (automate containers)
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.


** We don't have to setup network in docker-compose, it takes care of creating it**
```yaml
version: "3"				# version of Docker Compose
services:					# begins docker container specification		
	mongodb:				# container name = --name
		image: mongo		# name of image
		ports:				# ports = -p
			- 27017:27017	# host:container
		environment:		# environment = -e
			- MONGO_INITDB_ROOT_USERNAME=admin
			- MONGO_INITDB_ROOT_PASSWORD=password
	mongo-express:
		image: mongo-express
		ports:
			- 8080:8081
		environment:
			- ME_CONFIG_MONGODB_ADMINUSERNAME=admin
			- ME_CONFIG_MONGODB_ADMINPASSWORD=password
			- ME_CONFIG_MONGODB_SERVER=mongodb
		restart: unless-stopped		# on the first run mongodb doesnt work 
```

- to run compose script: `docker-compose -f script_name.yaml up`
	- `f` = `--file`: Specify an alternate docker-compose file (default: docker-compose.yml)
![[Screenshot 2021-08-25 at 15.08.55.png]]
- to stop `docker-compose` containers and its network: `docker-compose -f docker-compose.yaml down`

![[Pasted image 20210831002329.png]]
