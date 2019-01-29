# Nginx Reverse Proxy Docker Container
Docker image for a reverse proxy, powered by nginx. 

# Concept
This git / docker image is desinged to demo with examples for reverse proxy together with two other Docker containers so that people can easily learn how to create reverse proxy using this Docker container:
* openkbs/nginx-reverse-proxy-docker
* openkbs/jetty-fileserver, and
* openkbs/rest-dev-vnc-docker

By showing the actual working examples as the part of the demo, template, and actual configuratons, you can easily adapt or modify to become your own. 

# Nginx Configuration Folder
All you need to do is to provide ./etc/nginx configuration folder and launch this Docker container, then you have your customized Nginx Server.
Here is the ./etc/nginx folder which will be used to map into the Nginx Container when using "./run.sh" or "docker-compose up -d":

```
./etc
└── nginx
    ├── certificates
    ├── conf.d
    │   ├── jetty.conf
    │   ├── noVNC.conf
    │   └── proxy.conf
    ├── mime.types
    ├── nginx.conf
    ├── sites-enabled
    └── ssl
        ├── nginx.crt
        └── nginx.key

```

# Run

## 1.) Create your SSL certificate and key:
```
./create-ssl-certificate.sh (you can just hit 'y' to use auto configuration)
```
## 2.) Start Nginx Proxy Server:
```
./run.sh
```
or, for full demo with two other docker server containers
```
docker-compose up
```

# Volumes

* **/etc/nginx/sites-enabled**: Should contains nginx configurations for redirections to websites/web apps.
* **/etc/nginx/certificates**: Should contains certificates used in nginx redirection configurations.

# References
* [Nginx-Examples](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
* [Nginx + noVNC as Reverse Proxy](https://github.com/novnc/noVNC/wiki/Proxying-with-nginx)
* [How to config Nginx](https://www.linode.com/docs/web-servers/nginx/how-to-configure-nginx/)

# Validate Nginx Configuration
```
nginx -c /etc/nginx/nginx.conf -t

In Docker run:
docker run --rm -t -a stdout --name my-nginx -v $PWD/config/:/etc/nginx/:ro nginx:latest nginx -c /etc/nginx/nginx.conf -t

```
