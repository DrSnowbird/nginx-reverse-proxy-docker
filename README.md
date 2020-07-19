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

# Run
docker-compose up
```
The Proxied Ports by Reverse Proxy Server are
- rest-dev-vnc-docker:
  
      - 8443:8443   #  Proxy access 8443/26901 -> 6901
      - 25901:25901 #  Proxy access 25901 -> 5901
      - 26901:26901 #  Proxy access 8443/26901 -> 6901
      - 28080:28080 #  Proxy access 28080 -> 18080 -> 8080
```
Use the following URLs to test:
- rest-dev-vnc-docker
  - https://0.0.0.0:8443/  (password: vnc_password)
  - http://0.0.0.0:26901/  (password: vnc_password)
- rest-dev-vnc-docker
  - http://0.0.0.0:28080/

Note you need to replace the above "0.0.0.0" with the actual IP address when accessing from remote machines.

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
