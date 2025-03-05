#!/bin/sh
# 스크립트에서 오류 발생시 중단하도록 설정
set -e

# default.conf.template 파일에서 환경 변수를 대체하고 결과를 default.conf에 저장
# 템플릿 파일과 환경 변수를 읽은 뒤 nginx.conf 파일을 구성하여 nginx 설정으로 복사
envsubst '${BACKEND_HOST} ${BACKEND_PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# 다음 명령어를 실행
# 옵션으로 제공 받은 값 CMD [ "nginx", "-g", "daemon off;" ] 을 의미
exec "$@"
