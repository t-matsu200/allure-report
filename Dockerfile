FROM docker.io/alpine:3.18

ENV ALLURE_URL https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline
ENV ALLURE_VER 2.22.0
ENV ALLURE_HOME /home/allure/allure-${ALLURE_VER}
ENV PATH $PATH:${ALLURE_HOME}/bin

WORKDIR /home/allure

RUN apk update \
    && apk add --no-cache curl jq bash unzip openjdk11 \
    && curl ${ALLURE_URL}/${ALLURE_VER}/allure-commandline-${ALLURE_VER}.zip \
    -L -o /tmp/allure-commandline.zip \
    && unzip -q /tmp/allure-commandline.zip -d ./ \
    && rm -rf /tmp/* \
    && apk del unzip \
    && chmod -R +x ${ALLURE_HOME}/bin

USER nobody

COPY --chown=nobody:nogroup send_results.sh .

ENTRYPOINT ["/bin/sh", "-c"]
CMD [ "sleep", "infinity" ]
