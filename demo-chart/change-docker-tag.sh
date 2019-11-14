echo $1

sed "s/tagVersion/$1/g" ./values.yaml #> ./values.yml