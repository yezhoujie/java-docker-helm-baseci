# java-docker-helm-baseci
基础镜像：给gitLab-ci使用 mvn + java+docker+helm

## 这是一个给gitlab-ci runner 使用的基础镜像，主要给ci提供一些预装软件

命令行 | 备注
---|---
curl | 基础命令
wget | 基础命令
git | 用于获取仓库信息
helm | 用户打包Chart包
maven | 用于测试及打包Java程序
docker | 用于镜像构建阶段
mysql-client | 用于数据库初始化脚本测试
xmlstarlet | 用户HAP框架配置文件修改、POM文件修改
yq | 用于yaml文件解析
jq | 用于json文件解析

- 在安装helm的时候，因为上面提过的/root下面的文件夹会被删除的问题，我们把/root/.helm 文件夹复制到了/tmp/下面，后面在把这个文件夹挪到/root 下，给helm使用
- 如果runner的的executor是在docker或者k8s中，这里装的docker在容器内是启动不了的，这里的一种解决方案，是把宿主机的/var/run/docker.sock文件暴露给runner来使用

```
[[runners.kubernetes.volumes.host_path]]
           name = "docker"
           mount_path = "/var/run/docker.sock"
           host_path = "/var/run/docker.sock" 
```


[javaDemo参考: https://github.com/yezhoujie/hello-world-ci-final](https://github.com/yezhoujie/hello-world-ci-final)

[gitlab-runner 配置参考: https://github.com/yezhoujie/gitlab-runner-kubernetes](https://github.com/yezhoujie/gitlab-runner-kubernetes)

