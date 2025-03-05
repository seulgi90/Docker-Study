# 빌드 이미지로 node:14 지정
FROM node:14 AS build
WORKDIR /app
# 라이브러리 설치에 필요한 파일만 복사
COPY package.json .
COPY package-lock.json .
# 외부 라이브러리 설치
RUN npm install
# 소스코드 복사
COPY . .
RUN npm run build

FROM nginx:1.21.4-alpine

# -- 동적 서버 구성
# 소스코드의 nginx.conf 파일을 이미지 빌드 시 template파일로 복사 기본 환경 변수 지정
COPY nginx.conf /etc/nginx/conf.d/default.conf.template
ENV BACKEND_HOST leafy
ENV BACKEND_PORT 8080

# 컨테이너 실행시 자동으로 실행될 스크립트 지정
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# 빌드 스테이지에서 생성된 빌드 결과물 복사
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
# 스크립트 실행 처리
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]


