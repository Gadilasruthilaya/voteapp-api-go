FROM golang:1.19 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod tidy
COPY . .
RUN go build -v -o /app/bin/api ./...

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/bin/api .
EXPOSE 8080
CMD ["./api"]
