From ubuntu:18.04

RUN apt update && \
    apt install -y apt-mirror && \
    apt autoremove -y && apt clean

RUN mkdir -p /repo/conf/
RUN mkdir -p /repo/repo/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
