FROM jenkins
USER root

#  curl -L https://get.docker.com/builds/Linux/x87_64/docker-1.13.1.tgz | tar -xz -C /tmp/download && \

RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-17.09.1-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG staff,docker jenkins

user jenkins
