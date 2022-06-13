FROM solanalabs/solana:stable

LABEL org.opencontainers.image.source = https://github.com/kin-labs/kinetic-solana-network

EXPOSE 8899 8900

COPY keys/* .

COPY setup-localnet.sh .

ENTRYPOINT ./setup-localnet.sh
