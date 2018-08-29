FROM alpine:3.8

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}, \
  AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}, \
  AWS_REGION=${AWS_REGION}

RUN apk add --no-cache python3 && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --upgrade pip setuptools && \
  pip3 install awscli && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  rm -r /root/.cache

CMD ["aws", "s3", "rm", "s3://crawler-bi/", "--recursive", "--exclude", "'*/*.csv.zip'"]