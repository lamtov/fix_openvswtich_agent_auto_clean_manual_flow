FROM docker-registry:4000/neutron:q
MAINTAINER lamtv10@viettel.com.vn

LABEL openstack_version="queens"
ENV DEBIAN_FRONTEND noninteractive
ENV SERVICE neutron


USER root
#copy script

RUN apt-get update -y && apt-get -y install vim net-tools
RUN apt-get -y install iputils-ping
RUN apt-get -y install telnet 
RUN apt-get -y install python-elasticsearch
RUN pip install --upgrade pip 
RUN apt-get install -y python-openstackclient 
RUN apt-get install -y neutron-sriov-agent
RUN pip install osprofiler
RUN pip install elasticsearch==5.5.3




COPY copy_file.sh /usr/local/bin/copy_file.sh
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/var/log/neutron", "/var/lib/neutron", "/run"]

EXPOSE 9696

USER neutron

CMD ["start.sh"]


