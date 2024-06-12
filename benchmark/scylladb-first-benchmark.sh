#!/bin/bash

# Set the Cassandra stress command
CASSANDRA_STRESS="cassandra-stress"

# Set the Cassandra contact point
CASSANDRA_CONTACT_POINT="10.17.1.61"

# Set the Cassandra consistency level
CONSISTENCY_LEVEL="ALL"

# Set user and password
USER="cassandra"
PASSWORD="cassandra"

# Set the number of threads (many clients concurrently)
THREADS=(100 500 1000)

# Set time to run each tests
DURATION="10m"

# Set the output file name
OUTPUT_FILE="scylla-benchmark-$(date +%Y%m%d%H%M%S)"

# Schema
SCHEMA="replication(strategy=NetworkTopologyStrategy,replication_factor=3) compaction(strategy=SizeTieredCompactionStrategy)"

# Columns
COLUMNS_SIZES=64
COLUMNS_NUMBERS=20

#!/bin/bash

# Define the directory
DIRECTORY_NAME="$(date +%Y%m%d%H%M%S)"

# Check if the directory exists
if [ ! -d "$DIRECTORY_NAME" ]; then
  # Create the directory
  mkdir -p "/benchmark/$DIRECTORY_NAME"
  echo "Directory created: /benchmark/$DIRECTORY_NAME"
else
  echo "Directory already exists: /benchmark/$DIRECTORY_NAME"
fi

# Print the settings
echo "Running Cassandra stress with the following settings:"
echo "Cassandra stress command: $CASSANDRA_STRESS"
echo "Cassandra contact point: $CASSANDRA_CONTACT_POINT"
echo "Number of threads: $NUM_THREADS"
echo "Number of operations: $NUM_OPERATIONS"
echo "Output file: $OUTPUT_FILE"
echo "Sleep time: $SLEEP_TIME"

sleep 2

# Sample command
# $CASSANDRA_STRESS write n=$NUM_OPERATIONS -rate threads=$NUM_THREADS -node $CASSANDRA_CONTACT_POINT -schema "keyspace=$KEYSPACE table=$TABLE"

# First senerio - Threads increase
echo "=> First senerio - Threads increase"

echo "-> First senerio - Threads increase - Write"
$CASSANDRA_STRESS write cl=$CONSISTENCY_LEVEL no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/01-write-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/01-write-$OUTPUT_FILE.log 

echo "-> First senerio - Threads increase - Read"
$CASSANDRA_STRESS read cl=$CONSISTENCY_LEVEL no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/01-read-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/01-read-$OUTPUT_FILE.log

echo "-> First senerio - Threads increase - Mixed(1:1)"
$CASSANDRA_STRESS mixed ratio\(write=1, read=1\) cl=$CONSISTENCY_LEVEL no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -schema $SCHEMA -graph file=/benchmark/$DIRECTORY_NAME/01-mixed-1-1-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/01-mixed-1-1-$OUTPUT_FILE.log

echo "-> First senerio - Threads increase - Mixed(3:1)"
$CASSANDRA_STRESS mixed ratio\(write=3, read=1\) cl=$CONSISTENCY_LEVEL no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -schema $SCHEMA -graph file=/benchmark/$DIRECTORY_NAME/01-mixed-3-1-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/01-mixed-3-1-$OUTPUT_FILE.log

# Second senerio - Threads [100,500,1000] in 5 minutes
echo "=> Second senerio - Threads increase"

# Iterate over the values
for value in "${THREADS[@]}"; do

  echo "-> Second senerio - Threads increase - Write"
  $CASSANDRA_STRESS write cl=$CONSISTENCY_LEVEL duration=$DURATION no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -rate threads=$value -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-write-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-write-$OUTPUT_FILE.log

  echo "-> Second senerio - Threads increase - Read"
  $CASSANDRA_STRESS read cl=$CONSISTENCY_LEVEL duration=$DURATION no-warmup -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -rate threads=$value -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-read-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-write-$OUTPUT_FILE.log

  echo "-> Second senerio - Threads increase - Mixed(1:1)"
  $CASSANDRA_STRESS mixed ratio\(read=1, write=1\) cl=$CONSISTENCY_LEVEL duration=$DURATION -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -rate threads=$value -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-mixed-1-1-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-mixed-1-1-$OUTPUT_FILE.log

  echo "-> Second senerio - Threads increase - Mixed(1:3)"
  $CASSANDRA_STRESS mixed ratio\(read=1, write=3\) cl=$CONSISTENCY_LEVEL duration=$DURATION -mode native cql3 user=$USER password=$PASSWORD -node $CASSANDRA_CONTACT_POINT -rate threads=$value -schema $SCHEMA -col size=FIXED\($COLUMNS_SIZES\) n=FIXED\($COLUMNS_NUMBERS\) -graph file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-mixed-3-1-graph-$OUTPUT_FILE.html -log file=/benchmark/$DIRECTORY_NAME/02-threads-$THREADS-mixed-3-1-$OUTPUT_FILE.log
  
done

echo "=> Done!"
