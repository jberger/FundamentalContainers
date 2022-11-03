FROM gcc:latest AS build
WORKDIR /opt/build
COPY hello.c .
RUN gcc -o hello -static hello.c

FROM scratch
WORKDIR /opt
COPY --from=build /opt/build/hello .
CMD ["/opt/hello"]
