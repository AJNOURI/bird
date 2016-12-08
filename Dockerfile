FROM python:2-onbuild

RUN apt-get update && apt-get install -y wget vim nano 
RUN apt-get install -y build-essential binutils m4 flex bison python-pip

RUN pip install netaddr

# Install BIRD internet routing
RUN wget ftp://bird.network.cz/pub/bird/bird-1.5.0.tar.gz && tar -zxvf bird-1.5.0.tar.gz && rm bird-1.5.0.tar.gz
WORKDIR bird-1.5.0
RUN ./configure && make && make install

RUN mkdir /data

ADD route.py /data/route.py
ADD bird.conf /data/bird.conf

VOLUME /bird
VOLUME /data

WORKDIR /data

CMD /bin/bash
