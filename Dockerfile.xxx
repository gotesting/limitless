#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

WORKDIR /limitless
ARG TARGETPLATFORM=""
COPY install.sh /limitless/install.sh
COPY cmd.sh /limitless/cmd.sh

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

# support Heroku Exec (SSH Tunneling)
ADD ./.profile.d /app/.profile.d

RUN set -ex \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
    && chmod 777 /limitless \
    && chmod 777 /limitless/cmd.sh \
    && chmod 777 /limitless/install.sh \
    && /limitless/install.sh "${TARGETPLATFORM}" \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

CMD [ "/limitless/cmd.sh", ""]