FROM alpine:latest

# 添加架构参数，默认为 amd64
ARG TARGETARCH=amd64
ARG GFVERSION=latest

# 安装必要的依赖
RUN apk add --no-cache wget bash

# 设置工作目录
WORKDIR /app

# 安装 gf-cli 工具（根据目标架构）
RUN wget -O gf "https://github.com/gogf/gf/releases/${GFVERSION}/download/gf_linux_${TARGETARCH}" && \
    chmod +x gf && \
    ./gf install -y && \
    rm ./gf

# 设置环境变量
ENV PATH="/root/bin:${PATH}"

# 设置入口点
ENTRYPOINT ["gf"]
CMD ["--help"] 
