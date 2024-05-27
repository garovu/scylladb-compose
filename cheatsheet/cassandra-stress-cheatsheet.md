# Cassandra Stress Cheatsheet

## Installation

1. Install Cassandra stress tool
Read ./benchmark/README.md

## Useful Command

1. Cassandra-stress help

```shell
    cassandra-stress
    cassandra-stress help
    cassandra-stress help <command|option>
```

Example:

```shell
cassandra-stress help write # command
cassandra-stress help -mode # option

```

## Basic Usage

1. Connect to a Cassandra cluster:

    ```bash
    cassandra-stress user profile=stress.yaml ops\(insert=1\) n=100000 -node 127.0.0.1
    ```

2. Run a stress test with predefined workload:

    ```bash
    cassandra-stress user profile=stress.yaml ops\(insert=1,read1=1\) n=100000 -node 127.0.0.1
    ```

3. Run a stress test with custom workload:

    ```bash
    cassandra-stress user profile=stress.yaml ops\(insert=1,read1=1\) n=100000 -node 127.0.0.1 -rate threads=50
    ```

## Advanced Usage

1. Generate a stress profile:

    ```bash
    cassandra-stress user profile=stress.yaml n=100000 -node 127.0.0.1 -rate threads=50 -pop seq=1..100000
    ```

2. Run a stress test with a custom profile:

    ```bash
    cassandra-stress user profile=stress.yaml ops\(insert=1,read1=1\) n=100000 -node 127.0.0.1 -rate threads=50 -pop seq=1..100000
    ```

3. Run a stress test with multiple nodes:

    ```bash
    cassandra-stress user profile=stress.yaml ops\(insert=1,read1=1\) n=100000 -node 127.0.0.1,127.0.0.2,127.0.0.3 -rate threads=50
    ```

## References

- [Cassandra Stress Tool Documentation](https://cassandra.apache.org/doc/latest/tools/cassandra-stress.html)
- [The Best and Worst of Cassandra-stress Tool by Christopher Batey, The Last Pickle - C* Summit 2016](https://www.youtube.com/watch?v=it4yqHXu4TE)
- [Performance Testing by Ticketmaster: ScyllaDB vs. Cassandra vs. Datastax](https://www.youtube.com/watch?v=boMhPf_331E)
