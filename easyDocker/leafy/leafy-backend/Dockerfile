
# 빌드 이미지로 openJDK 11& gradle을 지정
FROM gradle:7.6.1-jdk11 AS build

# 소스코드를 복사할 작업 디렉토리를 생성
WORKDIR /app

# 외부 라이브러리 설치에 필요한 build.gradle 과 settings.gradle 파일만 복사
COPY build.gradle settings.gradle ./

# 의존 라이브러리 설치
RUN gradle dependencies --no-daemon


# 호스트 머신의 소스코드를 작업 디렉토리로 복사
COPY . /app

# gradle빌드를 실행하여 jar파일 생성
RUN gradle clean build --no-daemon

# 런타임 이미지로 openJDK11 JRE-slim 지정
FROM openjdk:11-jre-slim

# 애플리케이션을 실행할 작업 디렉토리를 생성
WORKDIR /app

# 빌드 이미지에서 생성된 jar파일을 런타임 이미지로 복사
COPY --from=build /app/build/libs/Leafy-0.0.1-SNAPSHOT.jar /app/leafy.jar

EXPOSE 8080
EXPOSE 5005

ENTRYPOINT ["java"]
CMD ["-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005","-jar", "leafy.jar"]
