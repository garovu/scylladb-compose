# ScyllaDB Docker Compose

This repository contains a Docker Compose configuration for running ScyllaDB, a highly scalable NoSQL database.

## Prerequisites

Before running the ScyllaDB Docker Compose configuration, make sure you have the following prerequisites installed:

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Docker Compose: [Install Docker Compose](https://docs.docker.com/compose/install/)

If your machine is using a Linux virtual machine to run a Linux kernel for Docker, please check if `/proc/sys/fs/aio-max-nr` is large enough. Multiple cores requires setting a proper value to the `/proc/sys/fs/aio-max-nr`. On many non production systems it will be equal to 65K. The formula to calculate proper value is: `11026 * cpu_cores`. [Read more in this official image.](https://hub.docker.com/r/scylladb/scylla)

To change default values, try this:

[See more in this issue](https://github.com/scylladb/scylladb/issues/5638).

```shell
docker run --rm -it --privileged ubuntu bash -c "echo \"fs.aio-max-nr = 1048576\" >> /etc/sysctl.conf && sysctl -p /etc/sysctl.conf"
```

This parameter will be visible in any container (because all containers share the same Linux kernel):

```shell
docker exec -it scylla-node1 cat /proc/sys/fs/aio-max-nr
```

Tested on MacBook ARM with M1! ✨ (Scylla 5.4)

Issues:

- Looks like you need to run this on each restart of your computer.
- Some Scylla containers can fail on start, then just restart them to retry.

## Usage

1. Clone this repository:

    ```shell
    git clone https://github.com/garovu/scylladb-compose.git
    ```

2. Navigate to the cloned repository:

    ```shell
    cd scylladb-compose
    ```

3. Start the ScyllaDB cluster:

    ```shell
    docker-compose up -d
    ```

    This will start a three-nodes ScyllaDB cluster in detached mode.

4. Verify that the ScyllaDB cluster is running:

    ```shell
    docker-compose ps
    ```

    You should see the ScyllaDB container listed as "Up".

    ```shell
    docker-compose exec scylla-node1 nodetool status
    ```

    Check ScyllaDB cluster status. Example:

    ```shell
    Datacenter: datacenter1
    =======================
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address     Load       Tokens       Owns    Host ID                               Rack
    UN  172.18.0.2  63.98 KB   256          ?       87461c7e-31af-450e-ac5e-d3802cbd3a22  rack1
    UN  172.18.0.3  112.7 KB   256          ?       6b25d433-66f0-4b9b-98de-bd62a360a980  rack1
    UN  172.18.0.4  223.83 KB  256          ?       488b5340-ab99-4efb-958f-6e66a24789a8  rack1

    Note: Non-system keyspaces don't have the same replication settings, effective ownership information is meaningless
    ```

5. Connect to the ScyllaDB cluster:

    ```shell
    docker-compose exec scylla cqlsh
    ```

    This will open a CQL shell where you can interact with the ScyllaDB cluster.

6. When you're done, stop the ScyllaDB cluster:

    ```shell
    docker-compose down
    ```

    This will stop and remove the ScyllaDB container.

## Configuration

The Docker Compose configuration file (`compose.yml`) allows you to customize various aspects of the ScyllaDB cluster, such as the number of nodes, memory limits, and network settings. Refer to the [Docker Compose documentation](https://docs.docker.com/compose/compose-file/) for more information on how to configure the ScyllaDB cluster.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE).
