# ScyllaDB Nodetool cheatsheet

Updated at: Mon 27 May

## Key Operations

### Print help of  nodetool

```shell
nodetool help
nodetool help <command>
```

### Check the version of nodetool

```shell
nodetool version
```

### View cluster information

```shell
nodetool status
nodetool status -r # Show node domain names instead of IPs
```

### View information about a specific node

```shell
nodetool info
```

### View the ring topology of the cluster

```shell
nodetool ring
```

### View the token ranges and ownership of the cluster

```shell
nodetool describering <keyspace_name>
```

### View the status of a specific keyspace

```shell
nodetool status <keyspace_name> # focus Owns (effective)
```

### View the status of tables

```shell
nodetool tablestats # Show all tables status
nodetool tablestats -H #  Display bytes in human readable form, i.e. KiB, MiB, GiB, TiB
nodetool tablestats <keyspace_name> # Show all the status of tables in keyspace.
nodetool tablestats <keyspace_name>.<table_name> # Show status of the table.
```

### Print statistics on compactions

```shell
nodetool compactionstats -H
```

### Trigger a repair on a specific keyspace

```shell
nodetool repair <keyspace_name>
```

### Trigger a cleanup on a specific keyspace

```shell
nodetool cleanup <keyspace_name>
```

### Flush all memtables to disk

```shell
nodetool flush
```

### Take a snapshot of a specific keyspace

```shell
nodetool snapshot <keyspace_name>
```

### Enable/disable tracing for a specific request

```shell
nodetool settraceprobability <probability>
```

### Enable/disable gossip tracing

```shell
nodetool setlogginglevel gossip trace/debug/off
```

### Enable/disable compaction throttling

```shell
nodetool setcompactionthroughput <value_in_mb>
```

### Enable/disable repair throttling

```shell
nodetool setrepairthroughput <value_in_mb>
```

### Enable/disable auto-compaction

```shell
nodetool enableautocompaction
nodetool disableautocompaction
```

### Enable/disable incremental repair

```shell
nodetool enableincrementalrepair
nodetool disableincrementalrepair
```
