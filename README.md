# docker-apt-mirror
Docker image to execute apt-mirror to create apt repository.

# Usage

## Download Ubuntu 18.04 (bionic) repository

```
# docker run --rm -d -it -v /path-to-your-repo-dir:/repo --name apt-mirror tmatsuo/apt-mirror
```

## Specify repositry and download

```
# docker run --rm -d -it -v /path-to-your-repo-dir:/repo --name apt-mirror tmatsuo/apt-mirror init
```

It create "conf" and "repo" direcotry into /path-to-your-repo-dir and create conf/mirror.list file.
You can customize /path-to-your-repo-dir/conf/mirror.list.

And let's download and create repository.

```
# docker run --rm -d -it -v /path-to-your-repo-dir:/repo --name apt-mirror tmatsuo/apt-mirror
```

# ENV

* PROXY
  * It specify http proxy server. 

