DOCKER_IMAGE := monicahq/circleci-docker-centralperk
GIT_COMMIT := $(shell git rev-parse --short HEAD)

docker_build:
	# Build Docker image
	docker build \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=$(GIT_COMMIT) \
		-t $(DOCKER_IMAGE) .

docker_push:
	# Tag image with commit
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):$(GIT_COMMIT)
	docker push $(DOCKER_IMAGE):$(GIT_COMMIT)

	# Tag image with branch
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):$(CIRCLE_BRANCH)
	docker push $(DOCKER_IMAGE):$(CIRCLE_BRANCH)

docker_push_master: docker_push
    # push default tag
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):latest
	docker push $(DOCKER_IMAGE)
