# Hyperledger-Fabric-ARM64-images
These are Hyperledger Fabric arm64 images and binaries for use on Raspberry Pi 4+ running Raspbian OS 64 Bit. 

# **Creating Hyperledger Fabric v2.1.0 ARM64 Images for Raspberry Pi 4**
At development of these images "Raspbian OS 64 bit operating system" for Raspberry Pi devices has just been released. Raspbian OS is a Debian distribution (debian:buster) and this is the base operating system used in this exercise. Hyperledger fabric (HLF) does not have any support for ARM64 images, however, the images can be created for the architecture only for 64 bit OS. There are other repositories and images with lower versions of HLF which did not work on my devices due to build issues and missing components hence need to create these.

Built images can be accessed from https://hub.docker.com/u/chinyati.

## **Prerequisites**

Hyperledger fabric requires a number of Prerequisites which can be installed using this script HLF-Prerequisites.sh. These dependencies are:
* Git
* Curl
* Node
* Python & pipenv
* Java
* Docker and docker compose
* Golang

To install the dependencies download the HLF-Prerequisites.sh and run it.
Verify that all dependencies installed correctly by checking the final output of dependency versions.

### **GO WORKSPACE**

The Hyperledger Fabric (HLF) images need to be built within a Go workspace which should be created after installing dependencies.
To manually create workspace, do the following:

```
$ mkdir -p $HOME/golang
$ export GOPATH=$HOME/go
```

Check whether path has been added by executing $ echo $PATH. If the GOPATH has not been added open the $ ~/.profile or $ ~/.bashrc and add the GOPATH, then execute $ source ~/.bashrc to save the paths.

Verify Golang environment setup by checking ```$ go env``` and see if GOPATH and GOROOT have been setup.

## **DOWNLOADING SOURCE CODE REPOSITORIES**
From the command line navigate to the newly created Go workspace and make new directories which will hold the fabric files.

```
$ mkdir -p $HOME/go/src/github.com/hyperledger

$ cd $HOME/go/src/github.com/hyperledger
```
The src directory will hold the HLF source code for fabric, fabric-baseimage and fabric-ca. These source code directories will be cloned using $ git clone into the created child directory /github.com/hyperledger.

Hyperledger fabric has three GIT repositories that contain the source code needed to create the ARM64 images.

1. Clone the fabric-baseimage repository by executing:

```
$ git clone https://github.com/hyperledger/fabric-baseimage.git
```
2. Clone the fabric repository by executing:

```
$ git clone https://github.com/hyperledger/fabric.git
```
3. Clone the fabric ca repository by executing:

```
$ git clone https://github.com/hyperledger/fabric-ca.git
```

## **EDIT BASEIMAGE FILES**
The Fabric baseimage repository contains source code for the base docker images required by the fabric repository. Navigate to the **fabric-baseimage**:

```
cd $HOME/go/src/github.com/hyperledger/fabric-baseimage
```

Check the available tagged branches for the fabric-baseimage codebase by executing:

```
git tag
```
For this exercise switch to branch v0.4.20 by executing:
```
git checkout v0.4.20
```

Within the fabric-baseimage codebase there are files that should be adjusted for successful build.

1. Edit the file **config/baseimage/Dockerfile** by commenting out
```
FROM adoptopenjdk:8u222-b10-jdk-openj9-0.15.1
```
and inserting this line:
```
FROM adoptopenjdk/openjdk8:aarch64-ubuntu-jdk8u222-b10
```

2. Edit the file **config/baseos/Dockerfile** by commenting out
```
FROM debian:buster-20190910-slim
```

and inserting this line:
```
FROM arm64v8/debian:buster
```
3. Edit the file **images/couchdb/Dockerfile** by commenting out
```
FROM debian:stretch-20190910-slim
```
and inserting this line;
```
FROM arm64v8/debian:buster
```
Whilst in the same file replace the following line:
```
libicu57 \
```
with the following line
```
libicu63 \
```
Finally in the same file **DELETE** this line as it causes errors within Debain:buster due to the package not being available
```
libmozsf180 \
```
4. Edit the two docker files in **images/zookeeper/Dockerfile** and **images/kafka/Dockerfile** by commenting out
```
FROM debian:buster-20190910-slim as download
```
and insert this line:
```
FROM arm64v8/debian:buster as download
```
still in the same file comment this line
```
FROM adoptopenjdk:8u222-b10-jdk-openj9-0.15.1
```
and insert this line:
```
FROM adoptopenjdk/openjdk8:aarch64-ubuntu-jdk8u222-b10
```
5. Lastly edit the file **scripts/common/setup.sh** and replace two instances of the following line:
```
ARCH=`uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|'`
```
with this line:
```
ARCH=`uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|' | sed 's|aarch64|arm64|'`
```
Still in the same file, replace all instances of **golang-1.6** with **golang-1.11**

## BUILDING BASEIMAGE DOCKER IMAGES ##

After setting up the Prerequisites and also editing the files in the Base-image codebase its time to make the images. First check if there are any available docker images and if any remove them.

1. The following instructions should be done whilst in **fabric-baseimage directory**

* To build docker images for the baseimage and baseos execute:
```
make docker
```
After an hour+ build should complete and then run **docker images** to list the successfully built images. If successful proceed.

* To build docker image for couchdb execute:
```
make couchdb
```
* To build docker image for kafka execute:
```
make kafka
```
* To build docker image for zookeeper execute:
```
make zookeeper
```

At this point run **docker images** to see created images. If successful a list of created docker images will show.

2. Navigate to **fabric directory** and here execute this command to switch to branch v2.1.0
```
git checkout v2.1.0
```

Within this directory Now execute this command:
```
make docker
```

If successful this process will create the **peer, orderer, tools, ccenv**. These individual components can also be built separately e.g ```make peer peer-docker``` or ```make ccenv```.
Run docker images to list all created image.

3. Dependent on what the Raspberry Pi will be in your deployment create the fabric-ca by navigating to **fabric-ca** directory. In this directory switch to branch v1.4.7
```
git checkout v1.4.7
```

Open the Makefile in fabric-ca and replace every instance of amd64 to arm64 for Linux entries.

Within this directory Now execute this command:
```
make docker
```

## BUILDING BASEIMAGE DOCKER IMAGES ##

Binary executables which include peer, orderer, cryptogen and more need to be built for the ARM64 architecture as well. These can be built from the source code in /fabric folder.
```
$ make native
```

These built executables will be places in the bin folder within /bin and must be moved to the /bin folder for the Hyperledger fabric samples or project.

### **ALL REQUIRED DOCKER IMAGES WOULD HAVE BEEN BUILT BY NOW.**
These built images can be accessed from https://hub.docker.com/u/chinyati.
Run docker images to view them.

ERRORS
For errors that could come up when deploying test-network or your channels look for core.yaml file in config and edit Memory value to:
```
Memory: 16777216
```

Install gcc to avoid runtime errors
```
sudo apt install -y gcc
```
