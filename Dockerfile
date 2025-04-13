FROM golang:1.24-alpine AS dev

RUN apk update && apk upgrade
RUN apk add --no-cache bash git openssh autoconf automake libtool gettext gettext-dev make g++ texinfo curl

RUN   mkdir /go/pkg
RUN   chmod a+rwx /go/pkg

ARG DEVELOPER_UID=1000
RUN adduser -s /bin/sh -u ${DEVELOPER_UID} -D developer
USER developer

WORKDIR /go/src/app
