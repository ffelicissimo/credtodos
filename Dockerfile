# python:alpine is 3.{latest}
FROM python:alpine

LABEL maintainer="Fernando Felicissimo"

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

ARG GERU_PASS
ENV GERU_PASS="${GERU_PASS}"
RUN export $GERU_PASS

RUN mkdir -p /credtodos

RUN git clone https://github.com/geru-br/devops-challenge.git \
    && cd /devops-challenge \
    && mv app /credtodos \
    && rm -Rf /devops-challenge

ADD dev.env /credtodos/app

WORKDIR /credtodos/app

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "app.py"]

RUN printenv

EXPOSE 80