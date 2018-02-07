FROM golang:1.9 AS builder
WORKDIR /go/src/github.com/erikasm/openweathermap_exporter
ADD . .
#RUN go get -u github.com/golang/dep/cmd/dep && dep ensure -v
RUN go get -u github.com/prometheus/client_golang/prometheus
RUN CGO_ENABLED=0 GOOS=linux go build -o openweathermap_exporter *.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
EXPOSE 9520
COPY --from=builder /go/src/github.com/erikasm/openweathermap_exporter/openweathermap_exporter openweathermap_exporter

ENTRYPOINT ["/openweathermap_exporter"]
