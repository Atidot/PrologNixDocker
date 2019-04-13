# SWI-Prolog in Docker with Nix
Containerize a SWI-Prolog script in Docker with Nix  
## Usage
~~~ shell
~/PrologNixDocker (master) $ make
nix-build docker.nix
/nix/store/c42fbg3fli5ma1wajhya8wx394vgpgmn-docker-image-prolog-nix-docker.tar.gz
~/PrologNixDocker (master) $ make install
nix-build docker.nix
/nix/store/c42fbg3fli5ma1wajhya8wx394vgpgmn-docker-image-prolog-nix-docker.tar.gz
docker load < result
Loaded image: prolog-nix-docker:latest
~/PrologNixDocker (master) $ make run
docker run prolog-nix-docker
Free: 3942188 / Total: 16275968
~/PrologNixDocker (master) $ make run
docker run prolog-nix-docker
Free: 3943040 / Total: 16275968
~/PrologNixDocker (master) $ make run
docker run prolog-nix-docker
Free: 3941964 / Total: 16275968
~~~
## TODO
Implement a `ghcWithPackages`-like nix supoprt for Prolog
