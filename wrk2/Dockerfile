FROM ubuntu:22.04 AS build

RUN set -eux; \
    apt-get -o Acquire::Retries=5 update; \
    apt-get install -y --no-install-recommends \
      build-essential git ca-certificates \
      libssl-dev zlib1g-dev liblz4-dev \
    ; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . /src

RUN set -eux; \
    if [ ! -d deps/luajit/src ]; then \
      mkdir -p deps; \
      git clone --depth 1 https://github.com/LuaJIT/LuaJIT.git deps/luajit; \
    fi

RUN make -j"$(nproc)"

FROM ubuntu:22.04
RUN set -eux; \
    apt-get -o Acquire::Retries=5 update; \
    apt-get install -y --no-install-recommends \
      ca-certificates libssl3 zlib1g liblz4-1 \
      lua-socket \
    ; \
    rm -rf /var/lib/apt/lists/*

ENV LUA_PATH="/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;;"
ENV LUA_CPATH="/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;;"

COPY --from=build /src/wrk /usr/local/bin/wrk
ENTRYPOINT ["wrk"]
