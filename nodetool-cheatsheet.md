# Nodetool cheatsheet

## Overview

### Check the version of nodetool

```shell
nodetool version
```

### View cluster information

```shell
nodetool status
```

### View information about a specific node

```nodetool info <node_ip>```

### View the ring topology of the cluster

```nodetool ring```

### View the token ranges and ownership of the cluster

```nodetool describering```

### View the status of a specific keyspace

```nodetool status <keyspace_name>```

### View the status of a specific table

```nodetool tablestats <keyspace_name>.<table_name>```

### View the compaction status

```nodetool compactionstats```

### Trigger a repair on a specific keyspace

```nodetool repair <keyspace_name>```

### Trigger a cleanup on a specific keyspace

```nodetool cleanup <keyspace_name>```

### Flush all memtables to disk

```nodetool flush```

### Take a snapshot of a specific keyspace

```nodetool snapshot <keyspace_name>```

### Enable/disable tracing for a specific request

```nodetool settraceprobability <probability>```

### Enable/disable gossip tracing

```nodetool setlogginglevel gossip trace/debug/off```

### Enable/disable compaction throttling

```nodetool setcompactionthroughput <value_in_mb>```

### Enable/disable repair throttling

```nodetool setrepairthroughput <value_in_mb>```

### Enable/disable auto-compaction

`````````shell
nodetool enableautocompaction
nodetool disableautocompaction
`````````

### Enable/disable incremental repair

`````````shell
nodetool enableincrementalrepair
nodetool disableincrementalrepair
`````````
