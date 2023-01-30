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
        curl -sSLf -o $lfile $url
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

# https://dist.ipfs.io/

##dlapp fs-repo-migrations v2.0.2
dlapp ipfs-cluster-ctl v1.0.5
dlapp ipfs-cluster-follow v1.0.5
dlapp ipfs-cluster-service v1.0.5
##dlapp ipfs-ds-convert v0.6.0
dlapp ipfs-update v1.9.0
##dlapp ipget v0.9.1
dlapp kubo v0.18.1
dlapp libp2p-relay-daemon v0.3.0
