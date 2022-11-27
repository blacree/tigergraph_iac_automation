private_host_ip=`echo $(hostname -I)`
secondary_host_ips="$(aws ec2 describe-instances --filters "Name=tag:Name,Values=Testing" --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text) "

m2=$(echo $secondary_host_ips | cut -d " " -f 1)
m3=$(echo $secondary_host_ips | cut -d " " -f 2)
m4=$(echo $secondary_host_ips | cut -d " " -f 3)

sed -i 's@"m1: 127.0.0.1"@'"\"m1:$private_host_ip\",\"m2:$m2\",\"m3:$m3\",\"m4:$m4\""'@' install_conf.json
sed -i 's@home@'"data"'@' install_conf.json
sed -i 's@sudoUserName@'"ubuntu"'@' install_conf.json
sed -i 's@/path/to/my_key.pem_rsa@'"/data/tigergraph/tigergraph"'@' install_conf.json
sed -i '/comment/d' install_conf.json
sed -i 's/P\[or K\]/K/g' install_conf.json
sed -i 's/ReplicationFactor": 1/ReplicationFactor": 2/g' install_conf.json
