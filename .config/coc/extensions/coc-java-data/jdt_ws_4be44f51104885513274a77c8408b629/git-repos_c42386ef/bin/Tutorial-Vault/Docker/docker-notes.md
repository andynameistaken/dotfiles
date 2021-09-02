# Docker Notes
## What is Docker
It is way to simplify application development and application deployment so you have isolated environments and configurations in one box and we don't have to install apps and configurations on different machines

### Installation
##### Before Docker containers
* Installation process is different for each operating system
* Many steps in which something can go wrong
##### After Docker containers
* Isolated environment
* Packaged with config already
* One command to install app
* Ability to run the same application with different versions

### Deployment
#### Before Docker containers
* We need to package program ourselves and configurations  - it is prone to dependency conflicts
* It needs textual guide of deployment, which can lead to misunderstandings 
* It is time-consuming to create/update guides and contact with DevOps after finishing version of the program
##### After Docker containers
* Developers and DevOps work together to package app into a container
* No environmental configuration on the server is required (except Docker Runtime ofc)
* Configuration, package with app and dependencies are in container so we have single entity with all of this stuff

## Differences between Docker and VM
### What is virtualized in Virtual Machine 
![[Drawing 2021-08-12 19.34.34.excalidraw]]
### What is virtualized in Docker
![[Drawing 2021-08-12 19.34.34.excalidraw 1]]

Because of Docker virtualizes (dunno spelling) only the Application Environment, Docker Images are much smaller storage-wise and they are much less resource hungry, than Virtual Machines

## What is  an Docker Image and a Docker Container

### Docker Image
Docker Image is read-only template with instructions for deploying containers

An **Image** consists of collection of files (layers) that have: dependencies, source code and necessary libraries for setting up container environments

* Image layers are stacked atop each other
* Image layers may be different, but every one of them may depend on the one immediately below it
* Layers between image of OS and Application itself are called *intermediate layers*
* *Intermediate layers* are files that a container layer will be added on top of every one of them

* To see docker images on your system we use command `docker images` with output:
	* `TAG`: version number
	* `IMAGE ID`: unique image identity
	* `CREATED`: time since it was created
	* `SIZE`: the image size
* To see all the layers that make the downloaded image: `docker history appimage:version_number`

![[Screenshot 2021-08-12 at 21.01.59.png]]


### Docker Container
* Docker Container provides virtualized runtime environment that separates the execution of an application from the OS
* Docker Containers provide lightweight and portable environment for deploying apps
* Each container is autonomous and isolated: it ensures that running app won't disrupt other  programs and OS itself
* There are several (6) **container states**:
	* *created*
	* *restarting*
	* *running*
	* *paused*
	* *exited*
	* *dead*
* Every time Docker creates container from an image and  it places `rw` layer on top that image, because image itself is immutable

![[Drawing 2021-08-12 21.42.50.excalidraw]]

| Docker Image                    | Docker Container                                         |
| ------------------------------- | -------------------------------------------------------- |
| It is container blueprint       | It's an image instance                                   |
| Immutable                       | Writable                                                 |
| Doesn't need computer resources | Does need computer resources to run                      |
| It can be shared                | No need to share running entity                          |
| Created only once               | Multiple containers can be created from the single image |

## Working with Docker
### Getting Started
* `docker pull image_name:version` 
	* get docker image (without version specified it gets whatever is `latest`)
	* Example: `docker pull postgres:9.6`
* ` docker run image_name:version_number`
	* create a new container of an image, and execute the container: 
	* Example: ` docker run -e POSTGRES_PASSWORD=password postgres:9.6` (needs password to run)    
- `docker start id_num` 
	* starts already created container
* `docker ps` 
	* Listing containers
	
![[Screenshot 2021-08-16 at 20.28.05.png | 1100]]

* Stopping container: `docker stop container_id`
 
![[Screenshot 2021-08-17 at 18.12.48.png | 1100]]		
 ### Docker Communication and Settings
 Docker uses port binding for communication between containers and a host.  
 Container ports can be the same (see Container 2 and Container 3), but host needs to use different ports to distinguish communication between different containers (to avoid conflicts).
 
* **Option to specify ports:**
	* `docker -p host_port_nr:container_port_nr`
	* If port isn't specified there is no way to communicate between host <-> container
 
 ![[Port_Communication]]	
 
 Example: 
 
 ![[Screenshot 2021-08-18 at 18.06.16.png | 1100]]


Docker can run your container in **detached** mode (in the background.) To do this, use the `--detach` or `-d` for short. Docker will “detach” from the container and return you to the terminal prompt.
* **Checking out container logs:** `docker logs container_id | container_name`: print log output of a docker container 
	* Example of the `redis` container log:

![[Screenshot 2021-08-18 at 22.16.18.png | 1100]]
* Setting container name: `--name`
	* Example	 
```
	docker run -d -p 5000:6379 --name redis_latest redis
```
```
	docker run -d -p 5001:6379 --name redis_6 redis:6.0
```
![[Screenshot 2021-08-19 at 00.39.56.png]]

- Starting interactive terminal: `docker exec -it container_id /directory/shell`
	- Example:
	 
![[Screenshot 2021-08-20 at 13.21.41.png]]

 Additional stuff:
- [[sh-vs-bash  | check the differences between sh and bash]]
- [[container-and-OS | Docker container does not need an OS, but each container has one. Why?]]




---
Useful links:
- <https://www.whitesourcesoftware.com/free-developer-tools/blog/docker-images-vs-docker-containers/>
- <https://devconnected.com/docker-exec-command-with-examples/>