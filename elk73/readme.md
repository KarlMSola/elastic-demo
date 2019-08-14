# Install new Elastic stack for quick testing

Requirements:
Relatively recent Java JDK, operating system is either Linux or OSX

Create "landing zone" and give yourself ownership of the directory (assuming karl is the username)
```bash
sudo mkdir -p /export/elk73/
sudo chown karl /export/elk73/
```

Fetch the files from elastic.co and unpack them in the directory just created
```bash
cd /export/elk7x/
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.3.0-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.3.0-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.3.0.tar.gz
tar zxf elasticsearch-7.3.0-linux-x86_64.tar.gz
tar zxf kibana-7.3.0-linux-x86_64.tar.gz
tar zxf logstash-7.3.0.tar.gz
```

Set up your own Elasticsearch server config on a non default port, 9201 in this case:
```bash
cd /export/elk73/elasticsearch-7.3.0/config/
cat > elasticsearch.yml <<EOF
cluster.name: "elk73"
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
discovery.type: single-node
http.port: 9201
path.data: /export/elk73/elasticsearch/data
path.logs: /export/elk73/elasticsearch/logs
EOF
```

Start the single node cluster (press Ctrl-c to exit)
```bash
cd /export/elk73/elasticsearch-7.3.0
bin/elasticsearch
```

In a separate terminal, start Kibana, pointing to the elasticsearch instance just started
```bash
cd /export/elk73/
bin/kibana -p 5601 -e http://localhost:9201
```


Do whatever else experimenting and testing you need. Kibana should be available on http://localhost:5601

Delete the whole lot when done testing
```bash
sudo rm -rf /export/elk73/
```
