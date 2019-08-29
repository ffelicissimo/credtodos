# python:alpine is 3.{latest}
LABEL maintainer="Fernando Felicissimo"
FROM python:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

ARG BRANCH="origin"
ARG COMMIT="local-build"
ARG DATE="2019-08-29T00:00:00Z"
ARG URL="https://github.com/ffelicissimo/credtodos"
ARG VERSION="fernando"

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$DATE \
    org.label-schema.vendor="Fernando Felicissimo" \
    org.label-schema.name="ffelicissimo/credtodos" \
    org.label-schema.description="API FLASK" \
    org.label-schema.version="$VERSION" \
    org.label-schema.vcs-url=$URL \
    org.label-schema.vcs-branch=$BRANCH \
    org.label-schema.vcs-ref=$COMMIT

ENV BRANCH "$BRANCH"
ENV COMMIT "$COMMIT"
ENV DATE "$DATE"
ENV VERSION "$VERSION"

RUN mkdir -p /credtodos

RUN git clone https://github.com/geru-br/devops-challenge.git \
    && cd /devops-challenge \
    && mv app /credtodos \
    && rm -Rf /devops-challenge

WORKDIR /credtodos/app

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "/credtodos/app/app.py"]

RUN printenv

EXPOSE 80