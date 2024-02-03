FROM alpine
RUN apk update && apk add nginx
RUN rm -rf /usr/share/nginx/html/*
COPY ./index.html /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
