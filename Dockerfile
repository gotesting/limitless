#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

WORKDIR /root
ARG TARGETPLATFORM=""
COPY install.sh /root/install.sh
COPY cmd.sh /root/cmd.sh

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
	&& chmod +x /root/cmd.sh \
	&& chmod +x /root/install.sh \
	&& /root/install.sh "${TARGETPLATFORM}" \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

CMD [ "/root/cmd.sh"]