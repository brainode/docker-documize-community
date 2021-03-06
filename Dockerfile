FROM alpine:latest

ARG VERSION

ENV DBUSER root
ENV DBPASS password
ENV DBNAME documize
ENV DBHOST localhost
ENV DBSALT 1234567890abcdefg

RUN apk --update add \
    wget 

WORKDIR /documize

RUN wget https://github.com/documize/community/releases/download/v3.7.0/documize-community-linux-amd64
RUN chmod +x /documize/documize-community-linux-amd64
EXPOSE 5001

CMD /documize/documize-community-linux-amd64 -port=5001 -db="$DBUSER:$DBPASS@tcp($DBHOST:3306)/$DBNAME" -dbtype=percona -salt=$DBSALT