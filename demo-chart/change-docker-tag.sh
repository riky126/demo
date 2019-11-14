echo $1

sed "s/tagVersion/$1/g" ./values-frame.yaml > ./values.yaml