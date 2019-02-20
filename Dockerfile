FROM nlnetlabs/routinator

LABEL maintainer "Sebastian Meiling <s@mlng.net>"

# create rpki group and user to run as non-root
RUN addgroup -S -g 323 rpki && adduser -S -u 323 -G rpki -h /opt/docker rpki
RUN mkdir -p /opt/docker/
RUN cp -r /root/.rpki-cache /opt/docker/.
RUN chown -R rpki:rpki /opt/docker

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
USER rpki

CMD ["routinator", "rtrd", "-a", "-l", "0.0.0.0:3323"]
