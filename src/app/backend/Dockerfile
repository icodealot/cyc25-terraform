FROM golang:1.23.1 AS build-stage
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o cyc .

FROM alpine:latest
WORKDIR /app
COPY --from=build-stage /app/cyc .
RUN chmod +x cyc

EXPOSE 8000

CMD ["./cyc"]