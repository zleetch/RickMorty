FROM golang:1.19 AS build-stage

WORKDIR /app

COPY /app/rick/go.mod /app/rick/go.sum ./
RUN go mod download

COPY /app/rick/*.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -o ./application

# Run the tests in the container
FROM build-stage AS run-test-stage
RUN go test -v ./...

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage app/application /application

EXPOSE 8001

USER nonroot:nonroot

CMD ["./application"]
