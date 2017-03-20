# FROM ruby:2.4-alpine
FROM ruby:2.3-alpine

# https://rubygems.org/gems/fluent-plugin-prometheus
# https://rubygems.org/gems/fluent-plugin-kubernetes_metadata_filter
# https://rubygems.org/gems/fluent-plugin-elasticsearch

RUN apk --no-cache add --virtual .build-deps \
    make gcc libc-dev g++ \
  && gem install \
    json \
    oj \
    fluentd:0.14.13 \
    fluent-plugin-prometheus:0.2.1 \
    fluent-plugin-kubernetes_metadata_filter:0.26.3 \
    fluent-plugin-elasticsearch:1.9.2 \
  && apk del .build-deps
  # FIXME is there more stuff to clean up after builds?

COPY ./fluent.conf /etc/fluent/

# USER nobody:nobody
CMD ["fluentd"]
