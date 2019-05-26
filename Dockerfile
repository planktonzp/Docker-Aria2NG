FROM alpine

RUN apk update \
 && apk add --no-cache --update bash darkhttpd aria2 \
 && mkdir -p /conf /conf-copy /aria2ng /data \
 && wget https://github.com/mayswind/AriaNg/releases/download/1.1.1/AriaNg-1.1.1.zip \
 && unzip AriaNg-1.1.1.zip -d /aria2ng \
 && rm -rf AriaNg-1.1.1.zip

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
ENV SECRET=diaosi0000
EXPOSE 6800
EXPOSE 8080
EXPOSE 80

CMD ["/conf-copy/start.sh"]
