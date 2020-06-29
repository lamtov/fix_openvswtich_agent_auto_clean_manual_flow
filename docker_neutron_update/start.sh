#!/bin/bash

sudo -E copy_file.sh

#Check NEUTRON_START Env variable
if [ -z ${NEUTRON_START+x} ]; then
  echo "ENV START_NEUTRON is unset"
  /bin/bash
elif [ "$NEUTRON_START" = "BOOTSTRAP" ]; then
  #if bootstrap
  neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head
elif [ "$NEUTRON_START" = "UPGRADE" ]; then
  #if UPGRADE
  neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade --expand
elif [ "$NEUTRON_START" = "CONTRACT" ]; then
  #if contract after upgrade finish
  neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade --contract
elif [ "$NEUTRON_START" = "START_NEUTRON_SERVER" ]; then
  neutron-server --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini  --config-file /etc/neutron/plugins/ml2/ml2_conf_sriov.ini   --log-file /var/log/neutron/neutron-server.log
elif [ "$NEUTRON_START" = "START_NEUTRON_DHCP_AGENT" ]; then
  neutron-dhcp-agent --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/dhcp_agent.ini --log-file=/var/log/neutron/neutron-dhcp-agent.log
elif [ "$NEUTRON_START" = "START_NEUTRON_METADATA_AGENT" ]; then
  neutron-metadata-agent --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/metadata_agent.ini --log-file=/var/log/neutron/neutron-metadata-agent.log
elif [ "$NEUTRON_START" = "START_NEUTRON_OVS_AGENT" ]; then
  neutron-openvswitch-agent --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/plugins/ml2/openvswitch_agent.ini --log-file=/var/log/neutron/neutron-openvswitch-agent.log
elif [ "$NEUTRON_START" = "START_NEUTRON_SRIOV_AGENT" ]; then
  neutron-sriov-nic-agent  --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/plugins/ml2/sriov_agent.ini --log-file=/var/log/neutron/neutron-sriov-agent.log


else
 echo "NEUTRON_START is set to '$NEUTRON_START'"
fi


