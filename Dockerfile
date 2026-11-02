FROM alpine:3
RUN apk add --no-cache ca-certificates curl unzip && \
    case "$(uname -m)" in \
      aarch64) A=arm64-v8a ;; \
      x86_64) A=64 ;; \
      *) echo "unsupported arch: $(uname -m)" && exit 1 ;; \
    esac && \
    curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/v26.10.31/Xray-linux-${A}.zip" && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
