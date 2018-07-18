FROM openjdk:8-slim

ENV DUMB_INIT_VERSION="1.2.1"

RUN apt-get update && \
    apt-get install -y wget && \
    wget http://apt.puppetlabs.com/puppet6-nightly/puppet6-nightly-release-stretch.deb && \
    wget https://github.com/Yelp/dumb-init/releases/download/v"$DUMB_INIT_VERSION"/dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    dpkg -i puppet6-nightly-release-stretch.deb && \
    dpkg -i dumb-init_"$DUMB_INIT_VERSION"_amd64.deb && \
    apt-get update && \
    apt-get install -y puppetserver

RUN /opt/puppetlabs/bin/puppet config set autosign true --section master
RUN chown -R puppet:puppet /etc/puppetlabs/puppet/ssl
RUN chown -R puppet:puppet /opt/puppetlabs/server/data/puppetserver/
RUN sed -i '/ruby-load-path:/c\ruby-load-path: [/puppet/lib, /facter/lib, /hiera/lib]' /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf

EXPOSE 8140

ENTRYPOINT ["dumb-init","/opt/puppetlabs/bin/puppetserver"]
CMD ["foreground" ]
