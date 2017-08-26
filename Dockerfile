FROM postgres:9.6
MAINTAINER Qiang Li

####
COPY pg.sh /
RUN chmod a+x pg.sh

ENTRYPOINT ["/pg.sh"]

EXPOSE 5432
CMD ["postgres"]