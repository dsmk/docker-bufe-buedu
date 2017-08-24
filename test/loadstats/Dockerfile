FROM amazonlinux:latest

RUN yum install -y httpd-tools nc

COPY *.sh ./
CMD ["./run-ab.sh", "bufe-load-test:80", "/server/healthcheck"]

