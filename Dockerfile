FROM golang:1.21 as base

WORKDIR /app

copy go.mod .

RUN go mod doqnload

COPY . .

RUN go build -o main .

#Final stage - distroless iamge
from gcr.io/distroless as base

COPY --from=base /app/main .

COPY --from=base /app/static ./static 

expose 8000

cmd [./"main ."]

