FROM golang:1.8-alpine

RUN apk add --update git perl

ARG GOPATH=/go

WORKDIR /go/src/github.com/qntfy/gomosesgo
COPY . /go/src/github.com/qntfy/gomosesgo

RUN mkdir -p $GOPATH/bin && \
    go get github.com/Masterminds/glide && \
    go get github.com/mitchellh/gox && \
    glide up && \
    gox -osarch "linux/amd64" -output "gomosesgo" . && \
    cp scripts/run.sh . && \
    rm -rf vendor $GOPATH/src/github.com/Masterminds/glide $GOPATH/src/github.com/mitchellh/gox && apk del git

EXPOSE 8080

ENTRYPOINT [ "./run.sh" ]
