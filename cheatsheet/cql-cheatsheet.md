# CQL Cheatsheet

## Get keyspace information

### Listing all keyspaces

```sql
DESCRIBE KEYSPACES;
```

### Getting details of a specific keyspace

```sql
DESCRIBE KEYSPACE <keyspace_name>;
or
DESCRIBE <keyspace_name>;
```

### Using the `system_schema` keyspace

   You can query the `system_schema` keyspace directly to get metadata about keyspaces and tables.

**List all keyspaces:**

```sql
SELECT keyspace_name FROM system_schema.keyspaces;
```

**Get keyspace details:**

```sql
SELECT * FROM system_schema.keyspaces WHERE keyspace_name = '<keyspace_name>';
```

**List all tables in a keyspace:**

```sql
SELECT table_name FROM system_schema.tables WHERE keyspace_name = '<keyspace_name>';
```

**Get table schema details:**

```sql
SELECT * FROM system_schema.tables WHERE keyspace_name = '<keyspace_name>' AND table_name = '<table_name>';
```

## Basic Syntax

### Creating Keyspace

```sql
CREATE KEYSPACE <keyspace_name> WITH replication = {'class': 'SimpleStrategy', 'replication_factor': <num_replicas>};
```

### Using Keyspace

```sql
USE <keyspace_name>;
```

### Create table

```sql
CREATE TABLE <table_name> (
    <column1_name> <column1_type>,
    <column2_name> <column2_type>,
    ...
    PRIMARY KEY (<primary_key_column>)
);
```

### Inserting Data

```sql
INSERT INTO <table_name> (<column1_name>, <column2_name>, ...) VALUES (<value1>, <value2>, ...);
```

### Querying Data

```sql
SELECT * FROM <table_name>;
```

### Querying Data with Conditions

```sql
SELECT <column1_name>, <column2_name>, ... FROM <table_name> WHERE <condition>;
```

### Updating Data

```sql
UPDATE <table_name> SET <column_name> = <new_value> WHERE <condition>;
```

### Deleting Data

```sql
DELETE FROM <table_name> WHERE <condition>;
```

### Data Types

- **Text**: `text`
- **Integer**: `int`
- **Double**: `double`
- **Boolean**: `boolean`
- **UUID**: `uuid`
- **Timestamp**: `timestamp`

### Primary Key

- **Partition Key**: The first column(s) specified in the PRIMARY KEY declaration.
- **Clustering Column(s)**: Columns following the first in the PRIMARY KEY declaration.

### Clauses

- **WHERE**: Filter rows based on conditions.
- **ORDER BY**: Arrange rows in ascending or descending order.
- **LIMIT**: Limit the number of rows returned by a query.
- **ALLOW FILTERING**: Allow filtering on non-primary key columns (not recommended for large datasets).
