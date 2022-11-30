# Export $JAVA_HOME
export JAVA_HOME=$(dirname $(find $(gadmin config get System.AppRoot)/.syspre -name java))

# Add to $PATH
export PATH=$PATH:$JAVA_HOME
  
# gadmin config_1
$(gadmin config get System.AppRoot)/zk/bin/zkCli.sh -server 127.0.0.1:19999 ls /tigergraph/dict/objects/__services/GPE/_runtime_nodes | tail -1

# gadmin_config_2
$(gadmin config get System.AppRoot)/zk/bin/zkCli.sh -server 127.0.0.1:19999 deleteall /tigergraph/dict/objects/__services/GPE/_runtime_nodes/GPE_1_3
  
# gadmin_config 3
gadmin stop GPE_1#3 -y
