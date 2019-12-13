FROM alpine:3.10

LABEL "com.github.actions.name" = "neo-cowsay"
LABEL "com.github.actions.description" = "Wraps some messages by neo-cowsay"
LABEL "com.github.actions.icon" = "bell"
LABEL "com.github.actions.color" = "gray-dark"

LABEL "repository" = "https://github.com/Code-Hex/neo-cowsay-action"
LABEL "homepage" = "https://github.com/Code-Hex/neo-cowsay-action"

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl jq"]

RUN ["bin/sh", "-c", "mkdir -p /src"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
