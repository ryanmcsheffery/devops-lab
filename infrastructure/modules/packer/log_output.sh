#!/bin/bash

# Install the CloudWatch Logs agent
wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
chmod +x awslogs-agent-setup.py
./awslogs-agent-setup.py -n -r ${aws_region} -c /tmp/awslogs.conf

# Configure the CloudWatch Logs agent to report logs to your log group
cat <<EOF >> /tmp/awslogs.conf
[general]
state_file = /var/awslogs/state/agent-state
use_gzip_http_content_encoding = true

[${log_stream}]
log_group_name = ${log_group}
log_stream_name = {instance_id}/${log_stream}
datetime_format = %b %d %H:%M:%S

# Add more log files and configurations as needed

EOF

# Start the CloudWatch Logs agent
service awslogs start
