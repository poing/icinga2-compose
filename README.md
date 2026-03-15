# icinga2-compose

This is a Docker Compose project to create a three level cluster with HA masters, satellites receiving config sync, and agents checked using command endpoint.

## Usage

```sh
cd icinga2-compose
docker compose up
```

1. Setup Master 1 (i2m1)
    ```sh
    ./setup.sh
    ```
    
    a. Copies the `ca` for use by Master 2 (i2m2)
    
    b. Replaces `/etc/icinga2`
    
2. Setup Master 2 (i2m2)

    ```sh
    ./setup.sh
    ```