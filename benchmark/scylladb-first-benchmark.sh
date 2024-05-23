#!/bin/bash

# Set the Cassandra stress command
CASSANDRA_STRESS="cassandra-stress"

# Set the Cassandra contact point
CASSANDRA_CONTACT_POINT="172.18.0.2"

# Set the Cassandra consistency level
CONSISTENCY_LEVEL="LOCAL_ONE"

# Set the number of threads (many clients concurrently)
# THREADS=100

# Set time to run each tests
DURATION="15s"

# Set the output directory
OUTPUT_DIR="benchmark-output"

# Set the output file name
OUTPUT_FILE="cassandra-stress-intial-$(date +%Y%m%d%H%M%S).log"

# Set the sleep time between tests
SLEEP_TIME=10

sleep_between_tasks() {
    echo "*> Sleeping for $SLEEP_TIME seconds..."
    sleep $SLEEP_TIME
}

# Print the settings
echo "Running Cassandra stress with the following settings:"
echo "Cassandra stress command: $CASSANDRA_STRESS"
echo "Cassandra contact point: $CASSANDRA_CONTACT_POINT"
echo "Number of threads: $NUM_THREADS"
echo "Number of operations: $NUM_OPERATIONS"
echo "Keyspace: $KEYSPACE"
echo "Table: $TABLE"
echo "Output file: $OUTPUT_FILE"
echo "Sleep time: $SLEEP_TIME"

sleep 5

# Sample command
# $CASSANDRA_STRESS write n=$NUM_OPERATIONS -rate threads=$NUM_THREADS -node $CASSANDRA_CONTACT_POINT -schema "keyspace=$KEYSPACE table=$TABLE"

# Run the Cassandra stress write (with default settings)
echo "-> Running Cassandra stress write..."
$CASSANDRA_STRESS write cl=$CONSISTENCY_LEVEL duration=$DURATION -node $CASSANDRA_CONTACT_POINT \
    -graph file=write-graph.html > "write-$OUTPUT_FILE" 

sleep_between_tasks()

# Run the Cassandra stress read (with default settings)
echo "-> Running Cassandra stress read..." 
$CASSANDRA_STRESS read cl=$CONSISTENCY_LEVEL duration=$DURATION node $CASSANDRA_CONTACT_POINT \
    -graph file=read-graph.html > "read-$OUTPUT_FILE" 2>&1

sleep_between_tasks() 

# Run the Cassandra stress mixed
echo "-> Running Cassandra stress mixed..." 
$CASSANDRA_STRESS mixed ratio\(read=1, write=3\) cl=$CONSISTENCY_LEVEL duration=$DURATION \
    -node $CASSANDRA_CONTACT_POINT -graph file=write-graph.html >"mixed-$OUTPUT_FILE" 2>&1
