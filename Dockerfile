FROM solanalabs/solana:stable

EXPOSE 8899 8900

COPY owner.json .

COPY mint.json .

COPY validator.sh . 

ENTRYPOINT ./validator.sh