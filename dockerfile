FROM golang:1.9.0 as builder

WORKDIR /go/src/github.com/rafaelbartolome/micro-test-user-cli

COPY . .

RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/rafaelbartolome/micro-test-user-cli .

ENTRYPOINT ["./micro-test-user-cli"]

CMD ["./micro-test-user-cli"]
