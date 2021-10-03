#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://dist.ipfs.io

# https://dist.ipfs.io/go-ipfs/v0.4.23/go-ipfs_v0.4.23_darwin-386.tar.gz
# https://dist.ipfs.io/gx-go/v1.9.0/gx-go_v1.9.0_windows-amd64.zip

dl()
{
    local app=$1
    local ver=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-tar.gz}
    local platform="${os}-${arch}"
    local file=${app}_${ver}_${platform}.${archive_type}
    local url=$MIRROR/$app/$ver/$file
    local lfile=$DIR/$file

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dlapp()
{
    local app=$1
    local ver=$2
    printf "  %s:\n" $app
    printf "    %s:\n" $ver
    dl $app $ver darwin amd64
    dl $app $ver freebsd 386
    dl $app $ver freebsd amd64
    dl $app $ver freebsd arm
    dl $app $ver linux 386
    dl $app $ver linux amd64
    dl $app $ver linux arm
    dl $app $ver linux arm64
    dl $app $ver windows 386 zip
    dl $app $ver windows amd64 zip
}


dlapp fs-repo-migrations v2.0.2
dlapp go-ipfs v0.10.0
#dlapp gx v0.14.2
#dlapp gx-go v1.9.0
dlapp ipfs-cluster-ctl v0.14.1
dlapp ipfs-cluster-follow v0.14.1
dlapp ipfs-cluster-service v0.14.1
#dlapp ipfs-ds-convert v0.6.0
#dlapp ipfs-pack v0.6.0
#dlapp ipfs-see-all v1.0.0
#dlapp ipfs-update v1.7.1
#dlapp ipget v0.7.0
