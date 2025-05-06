## Stage 1: Build
FROM golang:1.23 as base

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod .

# Download all dependencies. Dependencies are cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o main .

# Stage 2: Run
FROM gcr.io/distroless/base

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Pre-built binary file from the previous stage
COPY --from=base /app/main .

COPY --from=base /app/static ./static 

# Expose port 80 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
