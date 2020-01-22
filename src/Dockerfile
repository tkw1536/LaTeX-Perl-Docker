## Dockerfile for Building TeXLive distribution image with a specific version of perl
FROM ubuntu:xenial

ARG PERL="5.30.1"
ARG TEXLIVE="2019"

# Install packages required by perlbrew and LaTeXML
RUN apt-get update && \
    apt-get -y install git curl build-essential perl wget && \
    rm -rf /var/lib/apt/lists/*

# Prepare perlbrew installation
RUN mkdir -p /usr/local/perlbrew /root
ENV HOME /root
ENV PERLBREW_ROOT /usr/local/perlbrew
ENV PERLBREW_HOME /root/.perlbrew

# run the perlbrew installation
RUN curl -kL http://install.perlbrew.pl | bash
ENV PATH /usr/local/perlbrew/bin:$PATH
ENV PERLBREW_PATH /usr/local/perlbrew/bin
RUN perlbrew install-cpanm && \
    perlbrew info

# run the installation of the given version of perl
RUN /bin/bash -c "source /usr/local/perlbrew/etc/bashrc; perlbrew --notest install $PERL; perlbrew clean; perlbrew switch $PERL"

# install texlive
ADD install-texlive.sh /

# run the installation of the given version of texlive
RUN /bin/bash install-texlive.sh $TEXLIVE