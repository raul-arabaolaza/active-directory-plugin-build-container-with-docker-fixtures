# active-directory-plugin-build-container

# Build the Docker image

```
docker build -t ad-build-container .
```

# Run the container

```
docker run --dns=127.0.0.1 \
	--dns=8.8.8.8 \
	--privileged \
	-v /Users/fbelzunc/.m2/:/root/.m2:rw \
	-v <PATH_TO_AD_PLUGIN>:/project -ti ad-build-container
```
