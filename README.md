#  Docker Enterprise Edition Demo

This installation guide last updated at: **2017-12-12**

Ubuntu Version: **16.04**

Docker Enterprise Edition Version: **17.06.2-ee-6**

From the Prerequisties [described here](https://docs.docker.com/engine/installation/linux/docker-ee/ubuntu/) begin with getting the Docker EE URL.

It will look like: *https://storebits.docker.com/ee/ubuntu/sub-xxxxx-xxxxx-xxxxx-xxxx-xxxxx-xxxx*

## Create a new Virtual Machine with Docker Enterprise Edition installed

1. `vagrant up`
2. `vagrant ssh`
3.  Example: `export DOCKER_EE_URL=<https://storebits.docker.com/ee/ubuntu/sub-xxxxx-xxxxx-xxxxx-xxxx-xxxxx-xxx>`
4. `sh /vagrant_data/install_docker.sh`
5. Reboot
6. Install Docker UCP

<!--
docker run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:2.1.0 install --force-insecure-tcp \
  --san *.play-with-docker.com \
  --host-address $(hostname -i) \
  --interactive
-->

<!--
sudo docker run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:2.1.0 install --force-insecure-tcp \
  --host-address 192.168.88.10 \
  --interactive
-->

```
docker container run --rm -it --name ucp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  docker/ucp:2.2.4 install \
  --host-address 192.168.88.10 \
  --interactive
```

5. Login to UCP at [https://192.168.88.10:443](https://192.168.88.10:443)


## Build Demo Web App (Local)

1. `cd /vagrant/data/app`
2. `docker build -t demo-app:1.0.0 .`
3. `docker run -it --rm --name demo-app --network host demo-app:1.0.0`
4. `curl 192.168.88.10:3000`
<!--
5. `docker tag demo-app:1.0.0 192.168.88.10:5000/demo-app:1.0.0`
6. `docker push 192.168.88.10:5000/demo-app:1.0.0`
-->

## Deploy Service

1. `docker stack deploy --compose-file docker-compose.yml demo`

<!--

## Local Mac OS

1. `docker-machine create --engine-insecure-registry 192.168.88.10:5000 -d virtualbox --virtualbox-hostonly-cidr 192.168.99.1/24 --virtualbox-memory '1024' --virtualbox-boot2docker-url https://releases.rancher.com/os/latest/rancheros.iso demo1`

## Docker Trusted Registry

1. `docker run -it --rm docker/dtr:2.2.6 install --ucp-node 192.168.88.10 --ucp-insecure-tls`
-->

## Run a Docker Registry

1. `docker run -d -p 5000:5000 --restart=always --name registry registry:2`
2. `curl 192.168.88.10:5000/v2/_catalog`

Expose the registry (development only insecure)

3. Create file `/etc/docker/daemon.json`

```
{
  "insecure-registries" : ["192.168.88.10:5000"]
}
```

4. `sudo cat /etc/docker/daemon.json`
5. `sudo service docker restart`

Secure registry docs at  [https://docs.docker.com/registry/deploying/](https://docs.docker.com/registry/deploying/)

Push to the Registry via command line

6. `docker tag demo-app:1.0.0 192.168.88.10:5000/demo-app:1.0.0`
7. `docker push 192.168.88.10:5000/demo-app:1.0.0`

## Setup Jenkins CI (Continous Integration)

1. `docker build -t jenkins-docker:1.0.0 .`
2. `docker tag jenkins-docker:1.0.0 192.168.88.10:5000/jenkins-docker:1.0.0`
3. `docker push 192.168.88.10:5000/jenkins-docker:1.0.0`
4. `docker stack deploy --compose-file docker-compose-ci.yml jenkins`

## Deploy an existing service

1. `docker service update --image 192.168.88.10:5000/demo-app:1.0.0 demo_web`
