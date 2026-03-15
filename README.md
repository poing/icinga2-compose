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
    
    - Copies the `ca` to a shared location, used by Master 2 (i2m2)
    - Replaces `/etc/icinga2` _symlink_
        - __Container restart required!__
        
    After the container restarts, `i2m1` is a _generic_ master.
    
    Connect to [Icinga Web 2](http://localhost:8080)
    
2. Setup Master 2 (i2m2)

    ```sh
    ./setup.sh
    ```

    - Copies the `ca` from Master 1
    - Removes contents of `/var/lib/icinga2/certs/` to force regneration with updated `ca`.
        - __Container restart required!__
        

    ```sh
    ./setup.sh
    ```
    
    - Begins `icinga2 node wizard`
        - Specify `i2m2` as __`agent/satellite`__ _default `[Y/n]`_
        - Specify the parent endpoint __`i2m1`__
        - Connection to the parent? _default `[Y/n]`_
        - Master/Satellite endpoint host __`i2m1`__ _with default `port`_
        - Add more endpoints? _default [y/N]_ 
        