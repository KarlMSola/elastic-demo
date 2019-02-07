# Install new Elastic stack for quick testing

Requirements:
Relatively recent Java JDK, operating system is either Linux or OSX

Create "landing zone" and give yourself ownership of the directory
```bash
sudo mkdir -p /export/elk66/
sudo chown karl /export/elk66/
```

Fetch the files from elastic.co and unpack them in the directory just created
```bash
cd /export/elk66/
wget --no-check-certificate https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.6.0.tar.gz
wget --no-check-certificate https://artifacts.elastic.co/downloads/kibana/kibana-6.6.0-linux-x86_64.tar.gz
wget --no-check-certificate https://artifacts.elastic.co/downloads/logstash/logstash-6.6.0.tar.gz
tar zxf elasticsearch-6.6.0.tar.gz
tar zxf kibana-6.6.0-linux-x86_64.tar.gz
tar zxf logstash-6.6.0.tar.gz
```

Set up your own Elasticsearch server config on a non default port, 9201 in this case:
```bash
cd /export/elk66/elasticsearch-6.6.0/config/
cat > elasticsearch.yml <<EOF
cluster.name: "elk66"
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
discovery.type: single-node
http.port: 9201
path.data: /export/elk66/elasticsearch/data
path.logs: /export/elk66/elasticsearch/logs
EOF
```

Start the single node cluster (press Ctrl-c to exit)
```bash
cd /export/elk66/elasticsearch-6.6.0
bin/elasticsearch
```

In a separate terminal, start Kibana, pointing to the elasticsearch instance just started
```bash
cd /export/elk66/
bin/kibana -p 5601 -e http://localhost:9201
```


Do whatever testing is needed. Kibana should be available on http://localhost:5601

Delete the whole lot when done testing
```bash
sudo rm -rf /export/elk66/
```
