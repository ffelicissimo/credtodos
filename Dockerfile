# python:alpine is 3.{latest}
FROM python:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

ENV GERU_PASS=${GERU_PASS}

ARG GERU_PASS

LABEL maintainer="Fernando Felicissimo"

RUN mkdir -p /credtodos

VOLUME ["/credtodos/app"]

RUN git clone https://github.com/geru-br/devops-challenge.git \
    && cd /credtodos/devops-challenge \
    && mv app ../ \
    && rm /credtodos/devops-challenge

WORKDIR /credtodos/app

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "/credtodos/app/app.py"]

RUN printenv

EXPOSE 80