#!/bin/sh

set -e
set -x

pushd ./sources/openssl
git reset --hard HEAD && git clean -dxf
popd
pushd ./sources/pcre
git reset --hard HEAD && git clean -dxf
popd
pushd ./sources/zlib
git reset --hard HEAD && git clean -dxf
popd
pushd ./sources/nginx
git reset --hard HEAD && git clean -dxf
cp "${PROJECT_DIR}"/scripts/makefile.msvc ./auto/lib/openssl/
./auto/configure \
    --with-cc=cl \
    --with-cc-opt=-DFD_SETSIZE=1024 \
    --builddir=objs \
    --prefix= \
    --conf-path=conf/nginx.conf \
    --pid-path=logs/nginx.pid \
    --http-log-path=logs/access.log \
    --error-log-path=logs/error.log \
    --sbin-path=nginx.exe \
    --http-client-body-temp-path=temp/client_body_temp \
    --http-proxy-temp-path=temp/proxy_temp \
    --http-fastcgi-temp-path=temp/fastcgi_temp \
    --http-scgi-temp-path=temp/scgi_temp \
    --http-uwsgi-temp-path=temp/uwsgi_temp \
    --with-openssl=../openssl \
    --with-pcre=../pcre \
    --with-zlib=../zlib \
    --with-select_module  \
    --with-poll_module \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-pcre \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module
    
nmake
popd
rm -rf build
mkdir -p ./build/dist
cp ./sources/nginx/objs/nginx.exe ./build/dist/
cp -r ./sources/nginx/conf ./build/dist/
mkdir ./build/dist/temp
mkdir ./build/dist/logs
echo "Build completed successfully"