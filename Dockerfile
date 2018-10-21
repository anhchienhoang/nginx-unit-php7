FROM alpine:3.8

ENV UNIT_VERSION 1.4

RUN apk add --update --no-cache curl build-base php7-dev php7-embed \
    php7-ctype \
	php7-dom \
	php7-xml \
	php7-json \
	php7-phar \
	php7-mbstring \
	php7-zlib \
	php7-openssl \
	php7-iconv \
	php7-session \
	php7-tokenizer \
	php7-pdo \
	php7-pdo_mysql \
	php7-simplexml

RUN cd /tmp && \
    wget -qO- "http://unit.nginx.org/download/unit-$UNIT_VERSION.tar.gz" | tar xvz \
     && cd unit-$UNIT_VERSION \
    && ./configure --prefix=/opt/unit --modules=modules --control="unix:/var/run/control.unit.sock" --log=/dev/stdout --pid=/var/run/unit.pid \
    && ./configure php --module=php7 \
    && make install \
    && rm -rf /tmp/unit-$UNIT_VERSION

COPY config.json /config.json
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN mkdir /var/www

COPY index.php /var/www/index.php

WORKDIR /var/www

EXPOSE 8300

RUN ln -sf /dev/stdout /var/log/unit.log

CMD /entrypoint.sh
