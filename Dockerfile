FROM centos:7 



RUN yum -y install golang git make
RUN echo $GOPATH $GOROOT

WORKDIR /opt/ngrok
RUN git clone https://github.com/inconshreveable/ngrok
RUN cd ngrok && make

ENTRYPOINT ["./scripts/entrypoint.sh"]

COPY --from=builder /opt/golang/ngrok/bin/ngrok* /usr/local/bin/
COPY --from=builder /opt/golang/ngrok/assets  /opt/golang/ngrok/assets
COPY ngrok-config.yaml .
COPY scripts/ ./scripts/
RUN chmod +x scripts/*

