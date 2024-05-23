#!/bin/bash

docker run --name some-scylla --hostname some-scylla \
    -d scylladb/scylla --smp 1
