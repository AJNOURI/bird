FROM python:2-onbuild

RUN apt-get update && apt-get install -y wget vim nano 
RUN apt-get install -y build-essential binutils m4 flex bison python-pip

RUN pip install netaddr

# Install BIRD internet routing
RUN wget ftp://bird.network.cz/pub/bird/bird-1.5.0.tar.gz && tar -zxvf bird-1.5.0.tar.gz && rm bird-1.5.0.tar.gz
WORKDIR bird-1.5.0
RUN ./configure && make && make install

ADD route.py /bird/route.py
ADD bird.conf /bird/bird.conf
ADD bgp.conf /bird/bgp.conf
ADD bgp_route.py /bird/bgp_route.py
ADD ospf.conf /bird/ospf.conf
ADD ospf_route.py /bird/ospf_route.py

VOLUME /bird

CMD /bin/bash
