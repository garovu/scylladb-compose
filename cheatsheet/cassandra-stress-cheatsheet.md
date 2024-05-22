# Cassandra Stress Cheatsheet

## Installation

1. Install Cassandra stress tool:
    - For Linux: `sudo apt-get install cassandra-stress`
    - For macOS: `brew install cassandra-stress`

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
