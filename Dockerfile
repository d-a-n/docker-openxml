FROM phusion/baseimage:latest

MAINTAINER Daniel Korger version: 0.1

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install wget libx11-6 libglapi-mesa libglu1-mesa libcups2 libfontconfig1

WORKDIR /root
ADD .config .config
RUN wget "http://mirror.netcologne.de/tdf/libreoffice/stable/4.4.2/deb/x86_64/LibreOffice_4.4.2_Linux_x86-64_deb.tar.gz"
RUN tar xvf LibreOffice_4.4.2_Linux_x86-64_deb.tar.gz
WORKDIR LibreOffice_4.4.2.2_Linux_x86-64_deb/DEBS
RUN dpkg -i *.deb
WORKDIR ../..
RUN rm -Rf LibreOffice_4.4.2.2_Linux_x86-64_deb/ LibreOffice_4.4.2_Linux_x86-64_deb.tar.gz

EXPOSE 2002

CMD /opt/libreoffice4.4/program/soffice.bin --headless --nocrashreport --nodefault --nologo --nofirststartwizard --norestore --accept="socket,host=127.0.0.1,port=2002;urp;StarOffice.ComponentContext"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
