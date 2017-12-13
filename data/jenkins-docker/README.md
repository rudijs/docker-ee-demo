# Jenkins docker

* Jenkins CI with docker client

Add this Jenkins plugin
- CloudBees Docker Build and Publish plugin

Create a new project.
Set the git repo to:
https://github.com/rudijs/docker-demo-web-app.git

Set the Docker Build and Publish
Repository Name: docker-demo-web-app
Tag: ${GIT_COMMIT}
Docker Registry URL: http://192.168.88.10:5000

Add another build step: Execute Shell
docker service update --image 192.168.88.10:5000/docker-demo-web-app:${GIT_COMMIT} demo_web
