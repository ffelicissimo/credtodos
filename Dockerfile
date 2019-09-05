# python:alpine is 3.{latest}
FROM python:alpine

LABEL maintainer="Fernando Felicissimo"

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

ARG GERU_PASS
ENV GERU_PASS = ${GERU_PASS}
RUN echo $GERU_PASS

RUN mkdir -p /credtodos/app/
WORKDIR /credtodos/app/

#RUN git clone https://github.com/geru-br/devops-challenge.git \
#    && cd /devops-challenge \
#    && mv app /credtodos \
#    && rm -Rf /devops-challenge

#ADD dev.env /credtodos/app

COPY /app/app.py .
COPY /app/requirements.txt .
COPY /app/test_hello_world.py .

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "/credtodos/app/app.py"]

RUN printenv

EXPOSE 80