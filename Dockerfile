FROM ruby:2.4-alpine

RUN apk --no-cache add --virtual .build-deps \
    make gcc libc-dev g++ \
  && gem install \
    json_pure \
    fluentd:0.14.8 \
    fluent-plugin-kubernetes_metadata_filter:0.26.2 \
    fluent-plugin-elasticsearch:1.9.2 \
    fluent-plugin-prometheus:0.2.1 \
  && apk del .build-deps
  # && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
    # jemalloc \

COPY ./fluent.conf /etc/fluent/

# USER nobody:nobody

# CMD ["je", "fluentd"]
# CMD ["fluentd", "-c", "/etc/fluent/fluent.conf"]
CMD ["fluentd"]
