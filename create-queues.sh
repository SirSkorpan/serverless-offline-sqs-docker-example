#!/bin/sh
trap "exit 1" INT

AWS_ENDPOINT_URL=${AWS_ENDPOINT_URL:-http://localhost:9324}

QUEUES="TestQueue";
for QUEUE_NAME in $QUEUES
do 
    until aws sqs --endpoint-url ${AWS_ENDPOINT_URL} get-queue-url --queue-name ${QUEUE_NAME}  > /dev/null 2> /dev/null
    do
        echo "Creating queue $QUEUE_NAME at endpoint $AWS_ENDPOINT_URL."
        aws sqs --endpoint-url ${AWS_ENDPOINT_URL} create-queue \
            --queue-name ${QUEUE_NAME} --region eu-central-1 \
            > /dev/null 2> /dev/null
    done
done

trap - INT