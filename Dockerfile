ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=zarguell/ubi8
ARG BASE_TAG=latest

FROM minio/minio:latest as base

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

COPY --from=base /opt/bin/minio /usr/bin/minio
COPY scripts/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
COPY scripts/verify-minio.sh /usr/bin/verify-minio.sh
COPY LICENSE /licenses/LICENSE

RUN dnf upgrade -y && \
    dnf install -y ca-certificates shadow-utils util-linux && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    chmod +x /usr/bin/docker-entrypoint.sh && \
    chmod +x /usr/bin/verify-minio.sh && \
    groupadd -g 1001 minio && \
    useradd -r -u 1001 -m -s /sbin/nologin -g minio minio && \
    mkdir /data && \
    chown -R 1001:1001 /data

RUN chmod 755 /usr/bin/verify-minio.sh /usr/bin/docker-entrypoint.sh

USER minio

EXPOSE 9000

VOLUME /data

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

HEALTHCHECK --interval=10s --timeout=1s --start-period=10s --retries=6 \
  CMD curl -f http://localhost:9000/minio/index.html || exit 1

CMD ["minio"]
