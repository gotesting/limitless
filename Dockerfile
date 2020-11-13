#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

WORKDIR /limitless
ARG TARGETPLATFORM=""
COPY embed-install.sh /limitless/embed-install.sh
COPY embed-cmd.sh /limitless/embed-cmd.sh

RUN set -ex \
    && chmod +x /limitless/embed-cmd.sh \
    && chmod +x /limitless/embed-install.sh \
    && /limitless/embed-install.sh "${TARGETPLATFORM}" \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*
    
CMD [ "/limitless/embed-cmd.sh", ""]