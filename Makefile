docker:
	nix-build docker.nix

install: docker
	docker load < result

run:
	docker run prolog-nix-docker

clean:
	docker rmi -f prolog-nix-docker
