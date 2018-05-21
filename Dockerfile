FROM alpine
MAINTAINER kaku li

RUN apk update && apk add ca-certificates tzdata && rm -rf /var/cache/apk/* && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && mkdir -p /usr/share/filebeat

RUN mkdir /collectbeat
ADD collectbeat /collectbeat/

ENTRYPOINT ["/collectbeat/collectbeat", "-e", "-v", "-c"]
CMD ["/etc/collectbeat/collectbeat.yml"]