echo $1

sed "s/tagVersion/$1/g" ./values.yml #> ./values.yml