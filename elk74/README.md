# Install new Elastic stack for quick testing

Requirements:
Operating system is OSX (Linux is very similar.) Elasticsearch is now bundled with a suitable Java version.

Create "landing zone", a directory into which we will download and extract the required files from Elastic 
```bash
mkdir -p ~/elk74/
```

Fetch the files from elastic.co and unpack them in the directory just created
```bash
cd ~/elk74/
wget https://artifacts.elastic.co/downloads/kibana/kibana-7.4.2-darwin-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.2-darwin-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/logstash/logstash-7.4.2.tar.gz
tar zxf elasticsearch-7.4.2-darwin-x86_64.tar.gz
tar zxf kibana-7.4.2-darwin-x86_64.tar.gz
tar zxf logstash-7.4.2.tar.gz
```

Set up your own Elasticsearch server config on a non default ports, 9201/9301 in this case:
```bash
cd ~/elk74/elasticsearch-7.4.2/config/
cat > elasticsearch.yml <<EOF
cluster.name: "elk74"
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
discovery.type: single-node
http.port: 9201
transport.port: 9301
path.data: data
path.logs: logs
EOF
```

Start the single node cluster (press Ctrl-c to exit)
```bash
cd ~/elk74/elasticsearch-7.4.2
bin/elasticsearch
```

In a separate terminal, start Kibana, pointing to the elasticsearch instance just started
```bash
cd ~/elk74/kibana-7.4.2-darwin-x86_64
bin/kibana -p 5601 -e http://localhost:9201
```


Do whatever else experimenting and testing you need. Kibana should be available on http://localhost:5601

Delete the whole lot when done testing
```bash
sudo rm -rf ~/elk74/
```
