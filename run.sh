docker stop mf
docker rm mf

#	--user mysql \

docker run -itd \
	--rm \
	-v $PWD/volumes/var/lib/mysql/:/var/lib/mysql/ \
	-p 3307:3306 \
	--name mf \
	mf
