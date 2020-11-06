#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

WORKDIR /root
ARG TARGETPLATFORM=""
COPY limitless.sh /root/limitless.sh

RUN set -ex \
    && apk add --no-cache bash \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/* \
    && /bin/bash

RUN apk add --no-cache ca-certificates iptables iproute2

RUN set -ex \
    && apk add --no-cache openssh \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

RUN set -ex \
    && apk add --no-cache curl \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

ADD ./.profile.d /app/.profile.d

RUN set -ex \
	&& apk add --no-cache tzdata openssl ca-certificates \
	&& mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
	&& chmod +x /root/limitless.sh

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

CMD [ "/root/limitless.sh", ""]