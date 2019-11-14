echo $1

sed "s/tagVersion/$1/g" ./demo-chart/values-frame.yaml > ./demo-chart/values.yaml