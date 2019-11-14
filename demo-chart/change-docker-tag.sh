echo $1

sed "s/tagVersion/$1/g" ./values-frame.yml > ./values.yml