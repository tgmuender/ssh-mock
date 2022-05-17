# SSH Mock

SSH mock based on [docker-alpine-sshd](https://github.com/trashpanda001/docker-alpine-sshd)

```sh
# Build the image
$ docker build . -t ssh-mock

# Run a container
$ docker run \
    --rm \
    -it \
    -p 2222:22 \
    -e USERNAME=somebody \
    -e STORAGE_DIR=/tmp \
    -v /path/to/authorized_keys:/home/somebody/.ssh/authorized_keys \
    ssh-mock:latest

```
