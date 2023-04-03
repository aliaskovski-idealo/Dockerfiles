FROM debian:buster-slim
RUN apt update && \
    apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev gnupg1 ruby pinentry-tty pinentry-curses ruby-dev rubygems vim-tiny

RUN curl -sL https://raw.githubusercontent.com/rbenv/rbenv-installer/main/bin/rbenv-installer | bash -

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.rbenv/bin

ENV EDITOR=vi
RUN cd ~/.rbenv/ && \
	rbenv init - && \
    rbenv -v && \
    rbenv install 2.7.1 && \
    rbenv global 2.7.1 && \
    gem install gpgme -v 2.0.18 && \
    gem install hiera-eyaml -v 2.1.0 && \
    gem install hiera-eyaml-gpg -v 0.7.4

RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /root/.gnupg 
###&& chmod 600 /root/.gnupg/* && chmod 700 /root/.gnupg
RUN echo "pinentry-program /usr/bin/pinentry-tty" > /root/.gnupg/gpg-agent.conf && gpg-connect-agent reloadagent /bye
CMD ['/bin/bash']
