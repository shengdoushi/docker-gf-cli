# GoFrame CLI Docker 镜像

这个项目提供了一个 Docker 镜像，用于运行 [GoFrame CLI](https://goframe.org/pages/viewpage.action?pageId=1114399) 工具。该镜像基于 Alpine Linux，支持 amd64 和 arm64 架构。

## 使用方法

### 从 Docker Hub 拉取镜像

```bash
docker pull guolihui/gf-cli:v2.8.3
```

### 运行 GoFrame CLI

```bash
docker run --rm -v $(pwd):/app guolihui/gf-cli:v2.8.3 [命令]
```

例如，创建一个新的 GoFrame 项目：

```bash
docker run --rm -v $(pwd):/app guolihui/gf-cli:v2.8.3 init -u demo
```

查看帮助信息：

```bash
docker run --rm guolihui/gf-cli:v2.8.3 --help
```

## 构建和推送镜像

如果您想自己构建并推送镜像到 Docker Hub，可以使用提供的脚本：

```bash
./build.sh v2.8.3 guolihui
```

这将构建支持 amd64 和 arm64 架构的镜像，并将它们推送到 Docker Hub。

### 手动构建

如果您想手动构建镜像，可以使用以下命令：

```bash
# 设置 buildx 构建器
docker buildx create --name gf-cli-builder --use
docker buildx inspect --bootstrap

# 构建并推送多架构镜像
docker buildx build --platform linux/amd64,linux/arm64 \
  --build-arg GFVERSION=v2.8.3 \
  -t guolihui/gf-cli:v2.8.3 \
  --push .
```

## 支持的架构

- linux/amd64
- linux/arm64

## 许可证

MIT 
