#!/bin/bash

# 确保脚本在出错时退出
set -e

# 检查是否提供了 Docker Hub 用户名
if [ -z "$1" ]; then
  echo "请提供 Docker Hub 用户名"
  echo "用法: $0 <docker_username>"
  exit 1
fi

DOCKER_USERNAME=$1
IMAGE_NAME="${DOCKER_USERNAME}/gf-cli"
PLATFORMS="linux/amd64,linux/arm64"
IMAGE_TAG=v2.10.3

# 登录到 Docker Hub
echo "登录到 Docker Hub..."
docker login -u ${DOCKER_USERNAME}

# 创建并使用 buildx 构建器
echo "设置 Docker buildx..."
docker buildx create --name gf-cli-builder --use || true
docker buildx inspect --bootstrap

# 构建并推送多架构镜像
echo "构建并推送多架构镜像..."
docker buildx build --platform ${PLATFORMS} \
  -t ${IMAGE_NAME}:${IMAGE_TAG} \
  --push .

echo "完成！镜像已推送到 Docker Hub: ${IMAGE_NAME}:${IMAGE_TAG}" 
