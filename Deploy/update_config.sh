# private_host_ip=`echo $(hostname -I)`


# sed -i 's@127.0.0.1@'"$private_host_ip"'@' install_conf.json
sed -i 's@home@'"data"'@' install_conf.json
sed -i 's@sudoUserName@'"ubuntu"'@' install_conf.json
sed -i 's@/path/to/my_key.pem_rsa@'"/data/tigergraph/tigergraph.pem"'@' install_conf.json
sed -i '/comment/d' install_conf.json
sed -i 's/P\[or K\]/K/g' install_conf.json
sed -i 's/ReplicationFactor": 1/ReplicationFactor": 2/g' install_conf.json
