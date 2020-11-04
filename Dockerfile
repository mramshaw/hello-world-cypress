FROM golang:1.15.3-alpine3.12

RUN mkdir /app
COPY main.go /app/main.go
WORKDIR /app

ENTRYPOINT go run main.go
