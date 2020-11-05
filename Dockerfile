#FROM --platform=${TARGETPLATFORM} alpine:latest
FROM alpine:latest
LABEL maintainer="Limitless"

WORKDIR /root
ARG TARGETPLATFORM=""
COPY limitless.sh /root/limitless.sh

RUN set -ex \
	&& apk add --no-cache tzdata openssl ca-certificates \
	&& mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
	&& chmod +x /root/limitless.sh \
	&& /root/limitless.sh "${TARGETPLATFORM}"

CMD [ "/usr/bin/v2ray", "-config", "/etc/v2ray/config.json" ]