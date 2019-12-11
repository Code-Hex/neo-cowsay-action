FROM alpine:3.10

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl"]

RUN ["bin/sh", "-c", "mkdir -p /src"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
