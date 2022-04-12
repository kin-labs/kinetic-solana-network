FROM solanalabs/solana:stable

LABEL org.opencontainers.image.source = https://github.com/kin-labs/mogami-solana-network

EXPOSE 8899 8900

COPY owner.json .

COPY mint.json .

COPY setup-localnet.sh .

ENTRYPOINT ./setup-localnet.sh
