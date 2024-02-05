# 底座，可以理解为运行环境
FROM livingobjects/jre8
# 镜像作者
LABEL maintainer CWQ

# 创建构建目录，注意是容器内目录
RUN mkdir -p /hhd-link-ig-vedio/

# 复制文件到容器内目录
COPY hhd-link-ig-vedio-1.0.0-SNAPSHOT.jar  /hhd-link-ig-vedio/

# 工作空间
WORKDIR /hhd-link-ig-vedio/

# 声明暴露端口
EXPOSE 8000

# 实际执行指令
CMD [ "sh", "-ec", "exec java ${JAVA_OPTS} -Xms1024m -Xmx2046m -Dfile.encoding=UTF-8 -Duser.timezone=GMT+08 -jar hhd-link-ig-vedio-1.0.0-SNAPSHOT.jar" ]