FROM node
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list \
    && sed -i "s/security.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list

RUN apt update
RUN apt install -y ca-certificates curl wget cmake git bash python make gcc g++ autoconf automake file nasm \
  && update-ca-certificates

# YApi 版本
ENV YAPI_VERSION=1.9.2
WORKDIR /yapi/vendors

RUN https_proxy=http://192.168.31.5:10809 git clone \
  --branch "v${YAPI_VERSION}" \
  --single-branch \
  --depth 1 \
  https://github.com/YMFE/yapi.git .

RUN cp config_example.json ../config.json
#RUN npm install --production --registry https://registry.npm.taobao.org
RUN npm install -g ykit --registry https://registry.npm.taobao.org
RUN npm install --production --registry https://registry.npm.taobao.org
