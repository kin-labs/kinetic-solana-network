FROM debian:bullseye as base
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
WORKDIR /workspace

RUN mkdir -pv "/workspace/bin" && echo 'echo test' > '/workspace/bin/test.sh' && chmod +x '/workspace/bin/test.sh'

ENV PATH="/workspace/bin:${PATH}"

FROM base as builder

# Install os deps
RUN apt update && \
    apt-get install -y build-essential clang cmake curl libudev-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Setup rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain 1.59.0 -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Get the solana source
RUN curl https://codeload.github.com/solana-labs/solana/tar.gz/refs/tags/v1.10.38 | tar xvz
WORKDIR /workspace/solana-1.10.38

# Build solana-test-validator
RUN ./scripts/cargo-install-all.sh .
#RUN cargo build
#RUN cp target/debug/solana-test-validator /workspace/bin

# Build solana cli
#RUN cd cli && cargo build && cd ..
#RUN cp target/release/* /workspace/bin

#WORKDIR /workspace
#
#FROM base as final
## Install os deps
#RUN apt update && \
#    apt-get install -y build-essential clang cmake curl libudev-dev pkg-config && \
#    rm -rf /var/lib/apt/lists/*
#
#COPY --from=builder /workspace/bin/* /workspace/bin
