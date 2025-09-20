FROM golang:1.23.1 AS build-stage
WORKDIR /app
COPY app/backend/go.mod .
COPY app/backend/main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o cyc .

FROM alpine:latest
WORKDIR /app
COPY --from=build-stage /app/cyc .

EXPOSE 8000

CMD ["/app/cyc"]