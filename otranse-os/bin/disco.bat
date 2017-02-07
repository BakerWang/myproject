@echo off
title Disco
color a
rem by lengyu 2012-12-05 11:54
if "%OS%"=="Windows_NT" SETLOCAL
:init
if "%JAVA_HOME%"=="" goto nojava
goto main
goto eof

:main
if not exist ../src/core/src/main/resources/cn/disco/web/resources/disco-web.xml (
    @set ROOT=0
    @call setenv.bat
) else (
    @set ROOT=1
)

if "%1"=="war" goto war
if "%1"=="run" goto run
if "%1"=="crud" goto crud
if "%1"=="project" goto project

if "%1"=="" goto usage
goto eof


:usage
@echo ---------------------------------------------------------------------------------------------------------------------------
@echo ����������Ŀ��/binĿ¼��ִ�С�                                                                                                              
@echo ---------------------------------------------------------------------------------------------------------------------------
@echo disco war                               ���������ǰ���̳�һ��war��
@echo disco run                               ������Mavenֱ�����б�����
@echo disco crud cn.disco.domain.Example      ��������һ�����������������Ӧ��
@echo disco crud cn.disco.domain.Example ../src/main/java/cn/disco/domain/Example.java  ��������һ��JAVAԴ�ļ��������������Ӧ��
@echo ��������crudֻ��crud�ļ������ʹ�÷�����������ּ���ǣ���һ��JAVA�࣬�������JAVA��������Ӧ�������ļ���
@echo.
@echo ---------------------------------------------------------------------------------------------------------------------------
@echo ����Ŀ¼ΪDisco��ܵ�/binĿ¼ʱ��
@echo ---------------------------------------------------------------------------------------------------------------------------
@echo disco project d:\myapp           ������d:\������һ����Ϊmyapp�ļ�MVCӦ��
@echo disco project d:\myapp -djs      ������d:\������һ����Ϊmyapp��Ӧ������ĿΪ(disco + JPA + Spring)�Ľṹ
@echo disco project d:\myapp -djs -maven            ������d:\������һ����Ϊmyapp���й���Maven��Ӧ��
@echo disco project d:\myapp -djs -extjs            �������ɻ���DJS(Disco+JPA+Spring)���ܼ��������ExtJS��Ӧ����Ŀ
@echo disco project d:\myapp -ssh -extjs            �������ɻ���SSH1(Struts1.X+Hibernate+Spring)���ܼ��������ExtJS��Ӧ����Ŀ
@echo disco project d:\myapp -ssh2 -extjs           �������ɻ���SSH2(Struts2.X+Hibernate+Spring)���ܼ��������ExtJS��Ӧ����Ŀ
@echo disco project d:\myapp -djs -extjs -maven -platform  ��������Disco��ҵ�����ٿ���ƽ̨
@echo ---------------------------------------------------------------------------------------------------------------------------
goto eof

:crud
@if "1"=="%ROOT%" @goto isDISCOPROJECT
if "%2"=="" goto usage
@echo start crud %2
title ����%2 CRUD
if not "%3"=="" @javac %3 -d ../src/main/webapp/WEB-INF/classes/ -encoding UTF-8
java cn.disco.generator.Generator %2
goto eof

:project
if "%2"=="" goto usage
if "0"=="%ROOT%" goto notDISCOPROJECT

if "%6"=="-platform" goto PROJECT_DJS_PLATFORM
if "%6"=="platform" goto PROJECT_DJS_PLATFORM

if "%4"=="-maven" goto projectDJSMAVEN
if "%4"=="maven" goto projectDJSMAVEN
if "%4"=="-mvn" goto projectDJSMAVEN
if "%4"=="mvn" goto projectDJSMAVEN

if "%4"=="-extjs" goto projectDJSEXTJS
if "%4"=="extjs" goto projectDJSEXTJS


if "%3"=="-extjs" goto projectEXTJS
if "%3"=="extjs" goto projectEXTJS


if "%3"=="djs" goto projectDJS
if "%3"=="-djs" goto projectDJS

if "%3"=="ssh" goto projectSSHEXTJS
if "%3"=="-ssh" goto projectSSHEXTJS

if "%3"=="ssh2" goto projectSSH2EXTJS
if "%3"=="-ssh2" goto projectSSH2EXTJS

@echo ��ʼ����MINI��Ŀ%2
title ����%2 MINI Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\mini" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@rem copy the disco jars to target dir
@copy "..\lib\disco-core-*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\required\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "lib\build\*.jar" "%2\bin\lib\build\" >nul 2>nul
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof

:projectDJS
if "%3"=="" goto usage
@echo ��ʼ����Disco JPA Spring Project��Ŀ %2
title ����%2 Disco JPA Spring Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@rem copy the disco jars to target dir
@copy "..\lib\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\required\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul

@copy "..\lib\jpa\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\spring\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\other\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul


@copy "lib\build\*.jar" "%2\bin\lib\build\" >nul 2>nul
rem @del "%2\src\main\webapp\WEB-INF\lib\servlet-api-2.5-6.1.4.jar" /q >nul 2>nul
rem @del "%2\pom.xml" /q
@rd "%2\4maven" /S /Q
@del "%2\djs.launch" /q
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof

:projectDJSMAVEN
if "%3"=="" goto usage
if "%4"=="" goto usage
@echo ��ʼ����Disco JPA Spring Project��Ŀ��(ʹ��MAVEN������Ŀ) %2
title ����%2 Disco JPA Spring Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" @explorer "%2"
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
cd /d "%2"
@echo ��������eclipse maven����
call mvn eclipse:eclipse install
@echo �ɹ�������Ŀ�����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof

:PROJECT_DJS_PLATFORM
if "%3"=="" goto usage
if "%4"=="" goto usage
if "%5"=="" goto usage
if "%6"=="" goto usage
@echo ��ʼ����Disco���ٿ���ƽ̨��(ʹ��MAVEN������Ŀ) %2
@echo �����ĵȴ������ڸ���ƽ̨����Ҫ�������ļ���
title ����%2 Disco���ٿ���ƽ̨
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" @explorer "%2"
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@xcopy "templates\platform" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
cd /d "%2"
@echo ��������eclipse maven����
call mvn eclipse:eclipse install
@echo �ɹ�������Ŀ�����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof



:projectDJSEXTJS
if "%3"=="" goto usage
if "%3"=="-ssh2" goto projectSSH2EXTJS
if "%3"=="ssh2" goto projectSSH2EXTJS
if "%3"=="-ssh" goto projectSSHEXTJS
if "%3"=="ssh" goto projectSSHEXTJS
@echo ��ʼ����Disco JPA Spring Project��Ŀ %2
title ����%2 Disco JPA Spring Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@xcopy "..\lib\extjs\ext-3.2" "%2\src\main\webapp\plugins\extjs\ext-3.2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@copy "templates\extjs\*.*" "%2\templates\" >nul 2>nul
@xcopy "templates\extjs\disco\*.*" "%2\src\main\webapp\plugins\extjs\disco\" /E /C /F /I /Q /R /K /Y>nul 2>nul
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul

@echo ��������eclipse maven����
cd /d "%2"
call mvn eclipse:eclipse install

@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof


:projectSSH2EXTJS
if "%3"=="" goto usage
@echo ��ʼ����Disco JPA Spring Project��Ŀ %2
title ����%2 Disco JPA Spring Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@rem copy the disco jars to target dir
@copy "..\lib\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\required\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul

@copy "..\lib\jpa\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\spring\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\other\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\struts2\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul

@xcopy "..\lib\extjs\ext-3.2" "%2\src\main\webapp\plugins\extjs\ext-3.2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@copy "lib\build\*.jar" "%2\bin\lib\build\" >nul 2>nul
@copy "templates\extjs\*.*" "%2\templates\" >nul 2>nul
@xcopy "templates\extjs\disco\*.*" "%2\src\main\webapp\plugins\extjs\disco\" /E /C /F /I /Q /R /K /Y >nul 2>nul

@del "%2\src\main\webapp\WEB-INF\disco-web.xml" >nul 2>nul
@del "%2\src\main\webapp\WEB-INF\mvc.xml" >nul 2>nul

@xcopy "templates\struts2\*.*" "%2\" /E /C /F /I /Q /R /K /Y>nul 2>nul
rem @del "%2\src\main\webapp\WEB-INF\lib\servlet-api-2.5-6.1.4.jar" /q >nul 2>nul
rem @del "%2\pom.xml" /q
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof

:projectSSHEXTJS
if "%3"=="" goto usage
@echo ��ʼ����Disco JPA Spring Project��Ŀ %2
title ����%2 Disco JPA Spring Project
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\djs" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@rem copy the disco jars to target dir
@copy "..\lib\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\required\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul

@copy "..\lib\jpa\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\spring\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\other\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\struts1\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul

@xcopy "..\lib\extjs\ext-3.2" "%2\src\main\webapp\plugins\extjs\ext-3.2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@copy "lib\build\*.jar" "%2\bin\lib\build\" >nul 2>nul
@copy "templates\extjs\*.*" "%2\templates\" >nul 2>nul
@xcopy "templates\extjs\disco\*.*" "%2\src\main\webapp\plugins\extjs\disco\" /E /C /F /I /Q /R /K /Y>nul 2>nul

@del "%2\src\main\webapp\WEB-INF\disco-web.xml" >nul 2>nul
@del "%2\src\main\webapp\WEB-INF\mvc.xml" >nul 2>nul

@xcopy "templates\struts1\*.*" "%2\" /E /C /F /I /Q /R /K /Y>nul 2>nul
rem @del "%2\src\main\webapp\WEB-INF\lib\servlet-api-2.5-6.1.4.jar" /q >nul 2>nul
rem @del "%2\pom.xml" /q
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof


:projectEXTJS
@echo ��ʼ����EXTJS��Ŀ%2
title ����%2 MINI ProjectEXTJS
if exist "%2" @echo %2�Ѵ����ˣ�Ϊ�˰�ȫ���������ɾ����Ŀ¼��ָ��һ�������ڵ�Ŀ¼��
if exist "%2" goto eof
if not exist "%2" md "%2"
@xcopy "templates\mini" "%2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@rem copy the disco jars to target dir
@copy "..\lib\disco-core-*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@copy "..\lib\required\*.jar" "%2\src\main\webapp\WEB-INF\lib\" >nul 2>nul
@xcopy "..\lib\extjs\ext-3.2" "%2\src\main\webapp\plugins\extjs\ext-3.2" /E /C /F /I /Q /R /K /Y >nul 2>nul
@copy "lib\build\*.jar" "%2\bin\lib\build\" >nul 2>nul
if not exist "%2\bin" md "%2\bin"
@copy "*.bat" "%2\bin\" >nul 2>nul
@echo �ɹ���ɣ����ڴ�Ŀ��Ŀ¼
@explorer "%2"
goto eof




:war
@if "1"=="%ROOT%" @goto isDISCOPROJECT
@call build war
goto eof

:run
@if "1"=="%ROOT%" @goto isDISCOPROJECT
@echo ��ʼ���б���Ŀ
cd ..
@mvn jetty:run
goto eof


:nojava
@echo �����Ĳ���ϵͳ��û�а�װJAVA���л�������������JAVA_HOME����������װJDK
goto eof

:isDISCOPROJECT
@echo ����Ŀ��DISCO��Ŀ�������ڴ�ִ�е�ǰ���
@echo.
@echo �˴�����ִ�е������У�
@echo disco project d:\myapp              ������d:\������һ����Ϊmyapp�ļ�MVCӦ��
@echo disco project d:\myapp -djs         ������d:\������һ����Ϊmyapp��Ӧ��
@echo ����ĿΪ��Disco + JPA + Spring���Ľṹ
@echo disco project d:\myapp -djs -maven          ������d:\������һ����Ϊmyapp���й���Maven��Ӧ��
goto eof

:notDISCOPROJECT
@echo ����Ŀ����DISCO��Ŀ������Disco��Ŀ��ִ�б�������
@echo.
@echo �˴�����ִ�е������У�
@echo disco war                         ���������ǰ���̳�һ��war��
@echo disco run                         ������Mavenֱ�����б�����
@echo disco crud cn.disco.domain.Example                ��������һ�����������������Ӧ��
@echo disco crud  cn.disco.domain.Example ../src/main/java/org/disco/domain/Example.java   ��������һ��JAVAԴ�ļ��������������Ӧ��
@echo ��������crudֻ��crud�ļ������ʹ�÷�����������ּ���ǣ���һ��JAVA�࣬�������JAVA��������Ӧ�������ļ���

:eof
@rem pause

if "%OS%"=="Windows_NT" ENDLOCAL
