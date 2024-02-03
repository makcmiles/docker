#Задание
```
1. Установите Docker на машину https://docs.docker.com/engine/install/ubuntu/
2. Установите Docker Compose - как плагин, или как отдельное приложение
3. Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx)
4. Определите разницу между контейнером и образом
5. Ответьте на вопрос: Можно ли в контейнере собрать ядро?
```
## 1. Подготовка ОС и установка docker по инструкции https://docs.docker.com/engine/install/ubuntu/
```
root@kernel-update:~# for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Package 'docker.io' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package docker-doc
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package docker-compose
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package docker-compose-v2
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package podman-docker
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Package 'containerd' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Package 'runc' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.


sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
## 2. Установите Docker Compose - как плагин, или как отдельное приложение
```
root@kernel-update:/# apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  docker-ce-rootless-extras pigz slirp4netns
Suggested packages:
  aufs-tools cgroupfs-mount | cgroup-lite
The following NEW packages will be installed:
  containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-ce-rootless-extras docker-compose-plugin pigz
  slirp4netns
0 upgraded, 8 newly installed, 0 to remove and 0 not upgraded.
Need to get 117 MB of archives.
After this operation, 420 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 pigz amd64 2.4-1 [57.4 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 slirp4netns amd64 0.4.3-1 [74.3 kB]
Get:3 https://download.docker.com/linux/ubuntu focal/stable amd64 containerd.io amd64 1.6.28-1 [29.6 MB]
Get:4 https://download.docker.com/linux/ubuntu focal/stable amd64 docker-buildx-plugin amd64 0.12.1-1~ubuntu.20.04~focal [28.2 MB]
Get:5 https://download.docker.com/linux/ubuntu focal/stable amd64 docker-ce-cli amd64 5:25.0.2-1~ubuntu.20.04~focal [13.7 MB]
Get:6 https://download.docker.com/linux/ubuntu focal/stable amd64 docker-ce amd64 5:25.0.2-1~ubuntu.20.04~focal [24.3 MB]
Get:7 https://download.docker.com/linux/ubuntu focal/stable amd64 docker-ce-rootless-extras amd64 5:25.0.2-1~ubuntu.20.04~focal [9323 kB]
Get:8 https://download.docker.com/linux/ubuntu focal/stable amd64 docker-compose-plugin amd64 2.24.5-1~ubuntu.20.04~focal [12.1 MB]
Fetched 117 MB in 38s (3109 kB/s)                                                                                    
Selecting previously unselected package pigz.
(Reading database ... 63759 files and directories currently installed.)
Preparing to unpack .../0-pigz_2.4-1_amd64.deb ...
Unpacking pigz (2.4-1) ...
Selecting previously unselected package containerd.io.
Preparing to unpack .../1-containerd.io_1.6.28-1_amd64.deb ...
Unpacking containerd.io (1.6.28-1) ...
Selecting previously unselected package docker-buildx-plugin.
Preparing to unpack .../2-docker-buildx-plugin_0.12.1-1~ubuntu.20.04~focal_amd64.deb ...
Unpacking docker-buildx-plugin (0.12.1-1~ubuntu.20.04~focal) ...
Selecting previously unselected package docker-ce-cli.
Preparing to unpack .../3-docker-ce-cli_5%3a25.0.2-1~ubuntu.20.04~focal_amd64.deb ...
Unpacking docker-ce-cli (5:25.0.2-1~ubuntu.20.04~focal) ...
Selecting previously unselected package docker-ce.
Preparing to unpack .../4-docker-ce_5%3a25.0.2-1~ubuntu.20.04~focal_amd64.deb ...
Unpacking docker-ce (5:25.0.2-1~ubuntu.20.04~focal) ...
Selecting previously unselected package docker-ce-rootless-extras.
Preparing to unpack .../5-docker-ce-rootless-extras_5%3a25.0.2-1~ubuntu.20.04~focal_amd64.deb ...
Unpacking docker-ce-rootless-extras (5:25.0.2-1~ubuntu.20.04~focal) ...
Selecting previously unselected package docker-compose-plugin.
Preparing to unpack .../6-docker-compose-plugin_2.24.5-1~ubuntu.20.04~focal_amd64.deb ...
Unpacking docker-compose-plugin (2.24.5-1~ubuntu.20.04~focal) ...
Selecting previously unselected package slirp4netns.
Preparing to unpack .../7-slirp4netns_0.4.3-1_amd64.deb ...
Unpacking slirp4netns (0.4.3-1) ...
Setting up slirp4netns (0.4.3-1) ...
Setting up docker-buildx-plugin (0.12.1-1~ubuntu.20.04~focal) ...
Setting up containerd.io (1.6.28-1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
Setting up docker-compose-plugin (2.24.5-1~ubuntu.20.04~focal) ...
Setting up docker-ce-cli (5:25.0.2-1~ubuntu.20.04~focal) ...
Setting up pigz (2.4-1) ...
Setting up docker-ce-rootless-extras (5:25.0.2-1~ubuntu.20.04~focal) ...
Setting up docker-ce (5:25.0.2-1~ubuntu.20.04~focal) ...
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for systemd (245.4-4ubuntu3.23) ...
```
Проверка установки
```
root@kernel-update:/# docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete 
Digest: sha256:4bd78111b6914a99dbc560e6a20eab57ff6655aea4a80c50b0c5491968cbc2e6
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```
## 3. Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx). Создаю Dockerfile
```
root@kernel-update:/# nano Dockerfile

FROM alpine
RUN apk update && apk add nginx
RUN rm -rf /usr/share/nginx/html/*
COPY ./index.html /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
```
Создаю и заполняю кастомную страницу index.html
```
root@kernel-update:/# nano index.html
<!DOCTYPE html>
<html>
<head>
<title>Start Index</title>
</head>
<body>
For OTUS DZ, NGINX runs on container
</body>
</html>
```
Создаю и заполняю файл конфигурации nginx
```
user nginx;

worker_processes    auto;

events { worker_connections 1024; }

http {
    server {
        # Hide nginx version information.
        server_tokens off;

        listen  80;
        root    /usr/share/nginx/html;
        include /etc/nginx/mime.types;

        location / {
            try_files $uri $uri/ /index.html;
        }

        gzip            on;
        gzip_vary       on;
        gzip_http_version  1.0;
        gzip_comp_level 5;
        gzip_types
                        application/atom+xml
                        application/javascript
                        application/json
                        application/rss+xml
                        application/vnd.ms-fontobject
                        application/x-font-ttf
                        application/x-web-app-manifest+json
                        application/xhtml+xml
                        application/xml
                        font/opentype
                        image/svg+xml
                        image/x-icon
                        text/css
                        text/plain
                        text/x-component;
        gzip_proxied    no-cache no-store private expired auth;
        gzip_min_length 256;
        gunzip          on;
    }
}

```
Создаю образ
```
root@kernel-update:/# docker build -t nginx .
[+] Building 1.0s (10/10) FINISHED                                                                      docker:default
 => [internal] load build definition from Dockerfile                                                              0.0s
 => => transferring dockerfile: 251B                                                                              0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                  0.9s
 => [internal] load .dockerignore                                                                                 0.0s
 => => transferring context: 2B                                                                                   0.0s
 => [1/5] FROM docker.io/library/alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8  0.0s
 => [internal] load build context                                                                                 0.0s
 => => transferring context: 1.53kB                                                                               0.0s
 => CACHED [2/5] RUN apk update && apk add nginx                                                                  0.0s
 => CACHED [3/5] RUN rm -rf /usr/share/nginx/html/*                                                               0.0s
 => CACHED [4/5] COPY ./index.html /usr/share/nginx/html/                                                         0.0s
 => [5/5] COPY ./nginx.conf /etc/nginx/nginx.conf                                                                 0.0s
 => exporting to image                                                                                            0.0s
 => => exporting layers                                                                                           0.0s
 => => writing image sha256:e70fc75b45631a4d614a676896d99ef3962c18091039d17b170c442b7dcb0f69                      0.0s
 => => naming to docker.io/library/nginx                                                                          0.0s      
 
root@kernel-update:/# docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
nginx        latest    e70fc75b4563   12 seconds ago   11.1MB
```
Запускаю контейнер с пробросом порта
```
root@kernel-update:/#docker run -d --name nginxcont -p 81:80 nginx
9e96a9306c7dc190602b04bc746fb09e9fb1540c2d54bb28bb5662bb06f06298

root@kernel-update:/#docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES
9e96a9306c7d   nginx     "nginx -g 'daemon of…"   6 seconds ago   Up 6 seconds   0.0.0.0:81->80/tcp, :::81->80/tcp   nginxcont
```
Проверка
```
root@kernel-update:/# curl http://localhost:81
<!DOCTYPE html>
<html>
<head>
<title>Start Index</title>
</head>
<body>
For OTUS DZ, NGINX runs on container
</body>
```
Отправляю в dockerhub
```
root@kernel-update:/# docker login -u makcwrk
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

root@kernel-update:/# docker commit nginxcont makcwrk/nginxcont
sha256:ed0c2b202d5c925359bb89ba4464d1a59442c66a1a37316bb5edb1b41759785b

root@kernel-update:/# docker images
REPOSITORY          TAG       IMAGE ID       CREATED             SIZE
makcwrk/nginxcont   latest    ed0c2b202d5c   12 seconds ago      11.1MB
nginx               latest    e70fc75b4563   About an hour ago   11.1MB

root@kernel-update:/# docker push makcwrk/nginxcont
Using default tag: latest
The push refers to repository [docker.io/makcwrk/nginxcont]
f58fab4b5a4e: Pushed 
f79bc0fb4334: Pushed 
3a2e08f080cb: Pushed 
07708950b665: Pushed 
b7d8bcb309bb: Pushed 
d4fc045c9e3a: Mounted from library/alpine 
latest: digest: sha256:274ffc6eee6c103b1ca8ea41cf3a7734699ec01777b53142a7ac8f69abe9e609 size: 1566
```
Скопировать можно применив команду 
```
docker pull makcwrk/nginxcont:latest
```
## 4. Определите разницу между контейнером и образом
```
Образ - это шаблон для контейнера с заданным набором настроек, программ, инструментов, зависимостей между ними, требуемых для запуска приложения. Образ не подразумевает изменение со стороны, запускаемого приложения. То есть он существует на чтение.
Контейнер берёт за основу образ как шаблон; при запуске вирутальной среды (контейнера) создаётся слой на запись, с которым работает приложение, оно работает изолировано от хостовой машины и других приложений, при этому образ не меняется. 
```
## 5. Ответьте на вопрос: Можно ли в контейнере собрать ядро?
```
Думаю что в этом нет проблем в рамках одного контейнера, по логике мы не можем вносить изменения в образ, однако, изменения фиксируются в временном слое для записи. Загрузиться с такого ядра не получится, потому как перезапуск контейнера стирает наработанные данные. Возможно надо из такого контейнера сделать образ - то что сделть образ можно из контейнера - я уверен, но вот результат модификации ядра навсегда в таком случае - у меня под вопросом.
```