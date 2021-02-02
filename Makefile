.PHONY: all
all: deps sec test

.PHONY: deps
deps: 
	go get ./...

.PHONY: sec
sec: 
	go get -v github.com/securego/gosec/v2/cmd/gosec
	gosec -quiet ./...

.PHONY: test
test: 
	go test ./...

.PHONY: gobuild
gobuild: 
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o myapp-go .	

.PHONY: push
push: 
	docker login --username "lindachen" --password-stdin <<< "${DOCKER_ACCESS_TOKEN}"
	docker push docker.io/lindachen/myapp-go:v1.0.0

.PHONY: deploy
deploy: 
	./eks/install-tools.sh
	./eks/deploy.sh
