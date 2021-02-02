FROM scratch
WORKDIR /myapp-go
COPY myapp-go /myapp-go
EXPOSE 3000
ENTRYPOINT ["/myapp-go/myapp-go"]
