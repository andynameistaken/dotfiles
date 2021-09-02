[](https://stackoverflow.com/a/49449846)
# Docker container doesn't need and OS, but each container has one. Why?
## Questions
The introduction section of the documentation ([https://docs.docker.com/get-started/#a-brief-explanation-of-containers](https://docs.docker.com/get-started/#a-brief-explanation-of-containers)) reads:

> Containers run apps natively on the host machine’s kernel. They have better performance characteristics than virtual machines that only get virtual access to host resources through a hypervisor. Containers can get native access, each one running in a discrete process, taking no more memory than any other executable.

Bingo! Here is the difference. Containers run directly on the kernel of hosting OS, this is why they are so lightweight and fast (plus they provide isolation of processes and nice distribution mechanism in the shape of docker hub, which plays well with the ability to connect containers with each other).

But wait a second. I can run Linux applications on windows using docker - how can it be? Sure, there is some VM. Otherwise we would just not get job done...

OK, but how does it look like, when we work on Linux host??? And here comes real confusion... there one still defines OS as a base image for every image we want to create. Even if we say "FROM scratch" - scratch is still some minimalistic kernel... So here comes

**QUESTION 1**: If I run e.g. CentOS host, can I create the container, which would directly use kernel of this host operating system (and not VM, which includes its own OS)? If yes, how can I do it? If no, why the documentaion of docker lies to us (as then docker images always run within some VM and it is not too much different from other VMs, or ist it?)?

After some thinking about it and looking around I was wondering, if some optimization is done for running the images. Here comes

**QUESTION 2**: If I run two containers, images of both of which are based on the same parent image, will this parent image be loaded into memory only once? Will there be one VM for each container or just one, which runs both containers? And what if we use different OSs?

The third question is quite beaten:

**QUESTION 3**: Are there somewhere some resources, which describe this kind of things... because most of the articles, which discuss docker just tell "it is so cool, you must definitely use it. Just run one command and be happy"... which does not explain too much.

---
## Answers


[](https://stackoverflow.com/posts/49449846/timeline)

Docker "containers" are not virtual machines; they are just regular processes running on the host system (and thus always on the host's Linux kernel) with some special configuration to partition them off from the rest of the system.

You can see this for yourself by starting a process in a container and doing a `ps` outside the container; you'll see that process in the host's list of all processes. Running `ps` in the containerized process, however, will show only processes in that container; limiting the view of processes on the system is one of the facilities that containerization provides.

The container is also usually given a limited or separate view of many other system resources, such as files, network interfaces and users. In particular, containerized processes are often given a completely different root filesystem and set of users, making it look almost as if it's running on a separate machine. (But it's not; it still shares the host's CPU, memory, I/O bandwidth and, most importantly, Linux kernel of the host.)

To answer your specific questions:

1.  On CentOS (or any other system), _all_ containers you create are using the host's kernel. There is no way to create a container that uses a different kernel; you need to start a virtual machine for that.
    
2.  The image is just files on disk; these files are "loaded into memory" in the same way any files are. So no, for any particular disk block of a file in a shared parent image there will never be more than one copy of that disk block in memory at once. However, each container has its own private "transparent" filesystem layer above the base image layer that is used to handle writes, so if you change a file the changed blocks will be stored there, and will now be separate from the underlying image that that other processes (who have not changed any blocks in that file) see.
    
3.  In Linux you can try `man cgroups` and `man cgroup_namespaces` to get some fairly technical details about the cgroup mechanism, which is what Docker (and any other containerization scheme on Linux) uses to limit and change what a containerized process sees. I don't have any other particular suggestions on readings directly related to this, but I think it might help to learn the technical details of how processes and various other systems work on Unix and POSIX systems in general, because understanding that gives you the background to understand what kinds of things containerization does. Perhaps start with learning about the chroot(2) system call and programming with it a bit (or even playing around with the chroot(8) program); that would give you a practical hands-on example of how one particular area of containerization.
    

Follow-up questions:

1.  There is no kernel version matching; only the one host kernel is ever used. If the program in the container doesn't work on that version of that kernel, you're simply out of luck. For example, try runing the Docker official `centos:6` or `centos:5` container on a Linux system with a 4.19 or later kernel, and you'll see that `/bin/bash` segfaults when you try to start it. The kernel and userland program are not compatible. If the program tries to use newer facilities that are not in the kernel, it will similarly fail. This is no different from running the same binaries (program _and shared libraries_!) outside of a container.
    
2.  Windows and Macintosh systems can't run Linux containers directly, since they're not Linux kernels with the appropriate facilities to run even Linux programs, much less supporting the same extra cgroup facilities. So when you install Docker on these, generally it installs a Linux VM on which to run the containers. Almost invariably it will install only a single VM and run all containers in that one VM; to do otherwise would be a waste of resources for no benefit. (Actually, there could be benefit in being able to have several different kernel versions, as mentioned above.) 

[source: stackoverflow](<https://stackoverflow.com/a/49449846>
)
 ---
**My comment:** Windows 10 provides a native support for Docker, so only macOS is the only one that lags behind.

___
Docker **does not has an OS** in its containers. In simple terms, a docker container image just has a kind of filesystem snapshot of the **linux-image** the container image is dependent on.

The container-image includes some basic programs like bash-shell, vim-editor etc to facilitate developer to work easily with the docker image. Also, docker images can include pre-installed dependencies like nodeJS, redis-server etc as we can find on docker hub.

Docker behind the scene uses the **host OS** which is linux itself to run its containers. The programs included in linux-like filesystem snapshot that we see in form of docker containers actually **runs on the host OS in isolation**.

The container-images may sound like different linux distros but they are the filesystem snapshot of those distros. All Linux distributions are based on the same kernel. They differ in the programs, tools and dependencies that they ships with.

Also take note of this comment [click](https://stackoverflow.com/a/57720243/11723512). It is very much relevant to this question.

Hope this helps

[source: stackoverflow](<https://stackoverflow.com/a/57738257>)

