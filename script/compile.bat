@echo off

if "%GRAALVM_HOME%"=="" (
    echo Please set GRAALVM_HOME
    exit /b
)

set JAVA_HOME=%GRAALVM_HOME%
set PATH=%GRAALVM_HOME%\bin;%PATH%

set /P VERSION=< resources\POD_BABASHKA_MALLI_VERSION
echo Building version %VERSION%

if "%GRAALVM_HOME%"=="" (
echo Please set GRAALVM_HOME
exit /b
)

bb --clojure -X:native:uberjar

call %GRAALVM_HOME%\bin\gu.cmd install native-image

call %GRAALVM_HOME%\bin\native-image.cmd ^
  "-cp" "pod-babashka-malli.jar" ^
  "-H:Name=pod-babashka-malli" ^
  "-H:+ReportExceptionStackTraces" ^
  "--initialize-at-build-time" ^
  "-H:EnableURLProtocols=jar" ^
  "--report-unsupported-elements-at-runtime" ^
  "--verbose" ^
  "--no-fallback" ^
  "--no-server" ^
  "-J-Xmx3g" ^
  "pod.babashka.malli"

if %errorlevel% neq 0 exit /b %errorlevel%

echo Creating zip archive
jar -cMf pod-babashka-malli-%VERSION%-windows-amd64.zip pod-babashka-malli.exe
