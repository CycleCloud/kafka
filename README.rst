Basic Kafka Cluster
===================
This example implements a simple Kafka cluster with running on the same nodes as
its Zookeeper ensemble.

In general, a Kafka application will consist of a Kafka Cluster and one or more
Kafka Client Applications connecting from other clusters.

Usage
-----

1. Import the cluster template:
::

    $ cyclecloud import_template Kafka -f ./kafka.txt

2. Create the cluster via the GUI.

3. Start the cluster and log in to ``broker-1``.
::

    $ cyclecloud connect broker-1
    [cyclecloud@ip-10-142-234-201 ~]$ sudo su - kafka
    -bash-4.1$ cd /opt/kafka
    -bash-4.1$ bin/kafka-topics.sh --create --zookeeper localhost:2182 --replication-factor 1 --partitions 1 --topic test
    -bash-4.1$ bin/kafka-topics.sh --list --zookeeper 10.171.83.138:2182

4. Start a cluster with Kafka Clients to use the new Kafka cluster

TODO
----

1. Fix names to be kafka-esque rather than zookeeper oriented

