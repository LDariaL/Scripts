name=$RANDOM
url='http://localhost:9093/api/v1/alerts'
summary='Testing summary!'
default_severity='warning'
# Function to send alert
send_alert() {
    local status=$1
    local custom_severity=$2
    local current_severity=${custom_severity:-$default_severity}
wget --post-data "[
        {
            \"status\": \"$status\",
            \"labels\": {
                \"alertname\": \"$name\",
                \"service\": \"my-service\",
                \"severity\":\"$current_severity\",
                \"team\": \"$team\"
            },
            \"annotations\": {
                \"summary\": \"$summary\"
            }
        }
    ]" $url
    echo ""
}
# Main script
echo "Firing up alert $name"
send_alert "firing" "$1"
read -p "Press enter to resolve alert"
echo "Sending resolve"
send_alert "resolved" "$1"