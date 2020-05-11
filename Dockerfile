FROM nginx:1.18.0

RUN rm -f /usr/share/nginx/html/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./dirlist.xslt xslt/dirlist.xslt

ENTRYPOINT ["nginx", "-g", "daemon off;"]
