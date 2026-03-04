@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  dse-stats-converter startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and DSE_STATS_CONVERTER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\dse-stats-converter-0.1.jar;%APP_HOME%\lib\kotlin-stdlib-jdk8-1.4.21.jar;%APP_HOME%\lib\kotlin-reflect-1.4.21.jar;%APP_HOME%\lib\cassandra-all-4.0.19.jar;%APP_HOME%\lib\metrics-logback-3.1.5.jar;%APP_HOME%\lib\logback-classic-1.2.13.jar;%APP_HOME%\lib\java-driver-core-4.2.0.jar;%APP_HOME%\lib\metrics-jvm-3.1.5.jar;%APP_HOME%\lib\reporter-config3-3.0.3.jar;%APP_HOME%\lib\metrics-core-4.0.5.jar;%APP_HOME%\lib\log4j-over-slf4j-1.7.25.jar;%APP_HOME%\lib\jcl-over-slf4j-1.7.25.jar;%APP_HOME%\lib\chronicle-queue-5.20.123.jar;%APP_HOME%\lib\chronicle-wire-2.20.117.jar;%APP_HOME%\lib\chronicle-bytes-2.20.111.jar;%APP_HOME%\lib\chronicle-threads-2.20.111.jar;%APP_HOME%\lib\chronicle-core-2.20.126.jar;%APP_HOME%\lib\reporter-config-base-3.0.3.jar;%APP_HOME%\lib\compiler-2.4.1.jar;%APP_HOME%\lib\affinity-3.20.0.jar;%APP_HOME%\lib\ohc-core-j8-0.5.1.jar;%APP_HOME%\lib\ohc-core-0.5.1.jar;%APP_HOME%\lib\slf4j-api-1.7.32.jar;%APP_HOME%\lib\logback-core-1.2.13.jar;%APP_HOME%\lib\commons-io-2.6.jar;%APP_HOME%\lib\joda-time-2.9.3.jar;%APP_HOME%\lib\commons-cli-1.4.jar;%APP_HOME%\lib\airline-0.8.jar;%APP_HOME%\lib\guava-27.0-jre.jar;%APP_HOME%\lib\stream-2.7.0.jar;%APP_HOME%\lib\caffeine-2.6.2.jar;%APP_HOME%\lib\jamm-0.3.3.jar;%APP_HOME%\lib\commons-lang3-3.18.0.jar;%APP_HOME%\lib\kotlin-stdlib-jdk7-1.4.21.jar;%APP_HOME%\lib\kotlin-stdlib-1.4.21.jar;%APP_HOME%\lib\fastutil-6.5.7.jar;%APP_HOME%\lib\native-protocol-1.4.6.jar;%APP_HOME%\lib\netty-handler-4.1.39.Final.jar;%APP_HOME%\lib\java-driver-shaded-guava-25.1-jre.jar;%APP_HOME%\lib\config-1.3.4.jar;%APP_HOME%\lib\jnr-posix-3.0.50.jar;%APP_HOME%\lib\jnr-ffi-2.1.10.jar;%APP_HOME%\lib\HdrHistogram-2.1.12.jar;%APP_HOME%\lib\jcip-annotations-1.0-1.jar;%APP_HOME%\lib\spotbugs-annotations-3.1.12.jar;%APP_HOME%\lib\snappy-java-1.1.10.4.jar;%APP_HOME%\lib\lz4-java-1.8.0.jar;%APP_HOME%\lib\commons-codec-1.9.jar;%APP_HOME%\lib\commons-math3-3.2.jar;%APP_HOME%\lib\ST4-4.0.8.jar;%APP_HOME%\lib\antlr-runtime-3.5.2.jar;%APP_HOME%\lib\jackson-annotations-2.19.2.jar;%APP_HOME%\lib\jackson-databind-2.19.2.jar;%APP_HOME%\lib\jackson-core-2.19.2.jar;%APP_HOME%\lib\json-simple-1.1.jar;%APP_HOME%\lib\high-scale-lib-1.0.6.jar;%APP_HOME%\lib\snakeyaml-1.26.jar;%APP_HOME%\lib\jbcrypt-0.4.jar;%APP_HOME%\lib\jna-platform-5.5.0.jar;%APP_HOME%\lib\jna-5.6.0.jar;%APP_HOME%\lib\netty-all-4.1.58.Final.jar;%APP_HOME%\lib\sigar-1.6.4.jar;%APP_HOME%\lib\ecj-4.6.1.jar;%APP_HOME%\lib\jctools-core-3.1.0.jar;%APP_HOME%\lib\asm-commons-7.1.jar;%APP_HOME%\lib\asm-util-7.1.jar;%APP_HOME%\lib\asm-analysis-7.1.jar;%APP_HOME%\lib\asm-tree-7.1.jar;%APP_HOME%\lib\asm-7.1.jar;%APP_HOME%\lib\hppc-0.8.1.jar;%APP_HOME%\lib\mxdump-0.14.jar;%APP_HOME%\lib\sjk-core-0.14.jar;%APP_HOME%\lib\sjk-cli-0.14.jar;%APP_HOME%\lib\sjk-hflame-0.14.jar;%APP_HOME%\lib\sjk-jfr5-0.5.jar;%APP_HOME%\lib\sjk-jfr6-0.7.jar;%APP_HOME%\lib\sjk-jfr-standalone-0.7.jar;%APP_HOME%\lib\sjk-nps-0.5.jar;%APP_HOME%\lib\sjk-stacktrace-0.14.jar;%APP_HOME%\lib\jvm-attach-api-1.5.jar;%APP_HOME%\lib\jcommander-1.30.jar;%APP_HOME%\lib\sjk-json-0.14.jar;%APP_HOME%\lib\zstd-jni-1.5.7-2.jar;%APP_HOME%\lib\psjava-0.1.19.jar;%APP_HOME%\lib\netty-tcnative-boringssl-static-2.0.36.Final.jar;%APP_HOME%\lib\javax.inject-1.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\snowball-stemmer-1.3.0.581.1.jar;%APP_HOME%\lib\concurrent-trees-2.4.0.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.4.21.jar;%APP_HOME%\lib\chronicle-analytics-2.20.2.jar;%APP_HOME%\lib\annotations-19.0.0.jar;%APP_HOME%\lib\netty-codec-4.1.39.Final.jar;%APP_HOME%\lib\netty-transport-4.1.39.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.39.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.39.Final.jar;%APP_HOME%\lib\netty-common-4.1.39.Final.jar;%APP_HOME%\lib\jffi-1.2.19.jar;%APP_HOME%\lib\jffi-1.2.19-native.jar;%APP_HOME%\lib\jnr-a64asm-1.0.0.jar;%APP_HOME%\lib\jnr-x86asm-1.0.2.jar;%APP_HOME%\lib\jnr-constants-0.9.12.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\failureaccess-1.0.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\checker-qual-2.5.2.jar;%APP_HOME%\lib\error_prone_annotations-2.2.0.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.17.jar


@rem Execute dse-stats-converter
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %DSE_STATS_CONVERTER_OPTS%  -classpath "%CLASSPATH%" com.datastax.dsestatsconverter.ConvertKt %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable DSE_STATS_CONVERTER_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%DSE_STATS_CONVERTER_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
