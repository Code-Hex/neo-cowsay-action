FROM alpine:3.10

LABEL "com.github.actions.name" = "cowsay"
LABEL "com.github.actions.description" = "Wraps some messages by cowsay"
LABEL "com.github.actions.icon" = "bell"
LABEL "com.github.actions.color" = "gray-dark"

LABEL "repository" = "https://github.com/Code-Hex/cowsay-action"
LABEL "homepage" = "https://github.com/Code-Hex/cowsay-action"

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl jq"]

RUN ["bin/sh", "-c", "mkdir -p /src"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
