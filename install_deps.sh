#! /bin/bash
CURRENT_DIR=$(cd $(dirname $0); pwd)
FILE_NAME=$0
LOG_FILE=${CURRENT_DIR}/logs/${FILE_NAME%%.*}.log

. ${CURRENT_DIR}/common/log.sh

function main() {
    log_always $LOG_FILE
    exit 0
    docker version
    if [ $? -ne 0 ];then
      yum install -y docker && echo "docker安装成功" || echo "docker安装失败"
    fi

    rpmbuild -V
    if [ $? -ne 0 ];then
      yum install -y docker && echo "rpmbuild安装成功" || echo "rpmbuild安装失败"
    fi

    helm
    if [ $? -ne 0 ];then
      yum install -y docker && echo "rpmbuild安装成功" || echo "rpmbuild安装失败"
    fi
}
main @