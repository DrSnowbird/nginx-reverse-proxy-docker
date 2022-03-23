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
        ├── nginx.crt (auto generated)
        └── nginx.key (auto generated)

```
# Ngnix Config
* There three examples config files in 'etc/nginx/config.d' folder:
1. ./etc/nginx/conf.d/jetty.conf
2. ./etc/nginx/conf.d/jena-fuseki-docker.conf
3. ./etc/nginx/conf.d/blazegraph.conf

`IMPORTANT!`, you will have to modify the server IP address or domain name. currently, it is using some random IP address. Hence, it will not work if you did not modify those server IP address.
```
You need to replace the above "0.0.0.0" with the actual IP address when accessing from remote machines.

```

# Run
docker-compose up
```
##  PORTS_LIST="80:80 443:443"
## -- Reverse Proxy internal setup: --
##       # openkbs/jetty-fileserver 
##       - Proxy access [38443 / 38080] -> 18080 -> 8080
##       # openkbs/blazegraph-docker 
##       - Proxy access [39443 / 39999] -> 9999 -> 9999
##       # openkbs/jena-fuseki-docker 
##       - Proxy access [33843 / 33030] -> 13030 -> 3030

#PORTS_LIST="38843 38080  39443 39999  33843 33030"
```
# Volumes

* **/etc/nginx/sites-enabled**: Should contains nginx configurations for redirections to websites/web apps.
* **/etc/nginx/certificates**: Should contains certificates used in nginx redirection configurations.

# References
* [Nginx-Examples](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
* [Nginx + noVNC as Reverse Proxy](https://github.com/novnc/noVNC/wiki/Proxying-with-nginx)
* [How to config Nginx](https://www.linode.com/docs/web-servers/nginx/how-to-configure-nginx/)

# Using Ngix as Web Server
The Nginx container is set up by default to look for an index page at /usr/share/nginx/html, so in our new Docker container, we need to give it access to our files at that location. Let’s use the -v flag to map a folder from your local machine ~/docker-nginx/html to a relative path in the container that is /usr/share/nginx/html

This can be accomplished by using the following command in your ssh terminal.

```
sudo docker run --name docker-nginx -p 18880:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx
```

# Validate Nginx Configuration
```
nginx -c /etc/nginx/nginx.conf -t

In Docker run:
docker run --rm -t -a stdout --name my-nginx -v $PWD/config/:/etc/nginx/:ro nginx:latest nginx -c /etc/nginx/nginx.conf -t

```
