#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

# install bash ip openssh python3
RUN set -ex \
    && apk add --no-cache bash \
    && apk add --no-cache ca-certificates iptables iproute2 \
    && apk add --no-cache curl \
    && apk add --no-cache openssh \
    && apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python \
	&& apk add --no-cache tzdata openssl ca-certificates \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools \
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && /bin/bash

RUN adduser -D less
USER less

WORKDIR /limitless
ARG TARGETPLATFORM=""
COPY embed-install.sh /limitless/embed-install.sh
COPY embed-cmd.sh /limitless/embed-cmd.sh

# support Heroku Exec (SSH Tunneling)
ADD ./.profile.d /app/.profile.d

RUN set -ex \
    && chmod +x /limitless/embed-cmd.sh \
    && chmod +x /limitless/embed-install.sh \
    && /limitless/embed-install.sh "${TARGETPLATFORM}" \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

CMD [ "/limitless/embed-cmd.sh", ""]