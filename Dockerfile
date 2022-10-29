FROM --platform=linux/amd64 solanalabs/solana:v1.13.4

LABEL org.opencontainers.image.source = https://github.com/kin-labs/kinetic-solana-network

EXPOSE 8899 8900

COPY . .

ENTRYPOINT ./start-ledger.sh
