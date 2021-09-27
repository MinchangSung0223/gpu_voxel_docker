#!/bin/bash

rm -r mm_gpu_voxel;
git clone https://github.com/tjdalsckd/mm_gpu_voxel ;
git clone https://github.com/tjdalsckd/gpu_voxel_indy ;

docker rm -f gpu_voxels ||
docker rm -f gpu_voxels:latest ||

xhost +local:root
 docker  run  --rm -it -d --name gpu_voxels --privileged  --volume=/dev:/dev --gpus all --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 tjdalsckd/gpu_voxels:latest bash &&
docker cp mm_gpu_voxel gpu_voxels:/root/workspace;
docker cp gpu_voxel_indy gpu_voxels:/root/workspace;
docker cp ~/.ssh/id_rsa gpu_voxels:/root/.ssh/
docker cp ~/.ssh/id_rsa.pub gpu_voxels:/root/.ssh/
xhost +local:root
bash multi_terminal.sh

