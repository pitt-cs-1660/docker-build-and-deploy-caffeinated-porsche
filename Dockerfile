# Stage 1
FROM golang:1.23 AS builder

WORKDIR /app

# Copy Dependencies
COPY ./main.go .
COPY ./go.mod .
COPY ./templates/ ./templates/

# Compile app binary
RUN CGO_ENABLED=0 go build -o p2_app .

# Stage 2
FROM scratch

WORKDIR /app

# Copy compiled app binary from stage 1
COPY --from=builder /app/templates/ ./templates/
COPY --from=builder /app/p2_app .

CMD [ "./p2_app" ]