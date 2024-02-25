ARG VERSION

FROM otel/opentelemetry-collector-contrib:$VERSION as otelcol

FROM alpine:latest

RUN mkdir -p /tmp && \
    apk add --no-cache curl jq lynx inetutils-telnet netcat-openbsd wget && \
    apk --update add ca-certificates

ARG USER_UID=10001
USER ${USER_UID}

COPY --from=otelcol /otelcol-contrib /otelcol-contrib
EXPOSE 4317 55680 55679
ENTRYPOINT ["/otelcontribcol"]
CMD ["--config", "/etc/otel/config.yaml"]
