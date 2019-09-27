FROM adoptopenjdk/openjdk8:x86_64-ubuntu-jdk8u192-b12

ENV TEAMCITY_DATA_PATH=/data/teamcity_server/datadir \
    TEAMCITY_DIST=/opt/teamcity \
    TEAMCITY_LOGS=/opt/teamcity/logs \
    TEAMCITY_SERVER_MEM_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=350m" \
    LANG=C.UTF-8

EXPOSE 8111
RUN mkdir -p $TEAMCITY_DATA_PATH $TEAMCITY_DIST $TEAMCITY_LOGS

RUN apt-get update && \
    apt-get install -y git mercurial ca-certificates wget && \
    apt-get clean all

RUN apt install -y python-pip && pip install awscli &&  \
    wget https://download-cf.jetbrains.com/teamcity/TeamCity-2019.1.3.tar.gz -P $TEAMCITY_DIST/ && \
    tar -xvzf $TEAMCITY_DIST/TeamCity-2019.1.3.tar.gz --strip-components=1 -C $TEAMCITY_DIST

COPY run-server.sh /run-server.sh
COPY run-services.sh /run-services.sh

RUN chmod +x  /run-server.sh /run-services.sh && sync

VOLUME $TEAMCITY_DATA_PATH \
    $TEAMCITY_LOGS
RUN ls /opt/teamcity
CMD ["/run-services.sh"]