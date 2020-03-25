VERSION = 0.0.2
APP_NAME = netshoot
REPO = strongjz

.PHONY: build push kubetest

help:           ## Show this help.
	make _help

_help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build: 		## Build Docker image with Version
	docker build -t  $(REPO)/$(APP_NAME):$(VERSION) .

push: 		## Push docker image to repo
	docker push $(REPO)/$(APP_NAME):$(VERSION)

dockerhost:	## Run image in a docker container attached to the host network
	docker run -it --net host $(REPO)/$(APP_NAME):$(VERSION)

kubetest: 	## Run the image in a kubenetes cluster
	kubectl run --generator=run-pod/v1 --rm -it --image $(REPO)/$(APP_NAME):$(VERSION) netshoot -- /bin/bash


