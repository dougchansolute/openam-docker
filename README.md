# openam-docker
OpenAM configuration for Docker

Step 1 : build the image
docker build -t openam .

Step 2 : run the image
docker run -d --name openam -p 8080:8080 openam

Notes:
The OpenAM software is configured to bind to 'localhost' so the UI is accessible on
http://localhost:8080/openam

If you want to run this image in a cloud platform such as Cloud Foundry, Amazon ECS, Google Container Engine or OpenShift Container Platform you will need to reconfigure OpenAM to bind to a different FQDN. The Dockerfile shows how the SSO Configurator Tool can be used to configure OpenAM
