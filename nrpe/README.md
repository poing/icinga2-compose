# Notes

> While `docker-compose.yml` is often *ephemeral* and designed to be easily modified and rebuilt, the Dockerfile tends to be less so; changes to the `Dockerfile` can affect the overall image and container behavior significantly.

## Making Changes

When you modify the `Dockerfile` or `entrypoint.sh`, the changes won’t be reflected until the image is rebuilt. Rebuild the image with:

```sh
docker compose down
docker compose up --build
```

## Working with a Single Container

For ease of adjustment during development, it’s recommended to work with a single container. Use the following commands to target a specific container:

```sh
docker compose down
docker compose up host-name --build   # replace host-name with the service name
```

By using the `--build` flag, you ensure that any modifications made to the `Dockerfile` or `entrypoint.sh` are applied when the container starts.

## Additional Troubleshooting

If things still do not work as expected, you may need to clean up your Docker environment. Use the following commands to remove unused containers, images, and volumes:

```sh
docker compose down
docker container prune
docker image prune -a
docker volume prune
```