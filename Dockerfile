FROM alpine
MAINTAINER kaku li

RUN apk update && apk add ca-certificates tzdata && rm -rf /var/cache/apk/* && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && mkdir -p /usr/share/filebeat

RUN mkdir /collectbeat
ADD fields.yml /collectbeat/
ADD collectbeat /collectbeat/
ADD filebeat.yml /collectbeat/
ADD metricbeat.yml /collectbeat/
RUN chmod +x /collectbeat/collectbeat
WORKDIR /collectbeat

ENTRYPOINT ["/collectbeat/collectbeat"]
CMD ["metricbeat","-e","-v","-c","/collectbeat/metricbeat.yml"]