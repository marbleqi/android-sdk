FROM cirrusci/flutter:2.10.5 as builder
FROM gradle:6.5.0-jdk11 as builder2


FROM jenkins/jenkins:2.397-jdk11
USER root

ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV ANDROID_HOME="/opt/android-sdk"
ENV PATH="/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/android-sdk/cmdline-tools/latest/bin:/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:/opt/gradle/bin:$PATH"

WORKDIR /opt 
COPY --from=builder /sdks/flutter ./flutter
COPY --from=builder /opt/android-sdk-linux ./android-sdk
COPY --from=builder2 /opt/gradle ./gradle

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone