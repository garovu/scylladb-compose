# Overview

If you want to install and use `cassandra-stress` without installing the entire Apache Cassandra package, you can download and extract the relevant tools from the Apache Cassandra distribution. Here’s a step-by-step guide to achieve this on a Linux system:

## Step-by-Step Guide to Install `cassandra-stress` Only

### 1. Download Apache Cassandra Tarball

First, download the latest version of Apache Cassandra from the official website. You can use `wget` to do this:

```shell
wget https://downloads.apache.org/cassandra/4.0.3/apache-cassandra-4.0.3-bin.tar.gz
```

### 2. Extract the Tarball

Extract the downloaded tarball to your desired directory:

```shell
tar -xvzf apache-cassandra-4.0.3-bin.tar.gz
cd apache-cassandra-4.0.3
```

### 3. Locate `cassandra-stress`

The `cassandra-stress` tool is located in the `tools/bin` directory of the extracted Cassandra package. You can directly use it from there or add it to your PATH for convenience.

### 4. Make `cassandra-stress` Executable

Ensure that the `cassandra-stress` script is executable:

```shell
chmod +x tools/bin/cassandra-stress
```

### 5. Add `cassandra-stress` to PATH (Optional)

To make it easier to use `cassandra-stress` from any location, you can add it to your system’s PATH. Open your `.bashrc` or `.bash_profile` file and add the following line:

```shell
export PATH=$PATH:/path/to/apache-cassandra-4.0.3/tools/bin
```

Replace `/path/to/apache-cassandra-4.0.3` with the actual path to the extracted directory. Then, source the file to update the PATH:

```shell
source ~/.bashrc
```

### 6. Verify Installation

Verify that `cassandra-stress` is accessible by checking its version or running a basic command:

```shell
cassandra-stress help
```
