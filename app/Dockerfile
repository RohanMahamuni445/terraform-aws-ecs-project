# Stage 1: build
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod init demo || true
RUN go mod tidy
RUN go build -o app main.go

# Stage 2: runtime
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/app /app/app
EXPOSE 8080
CMD ["/app/app"]

