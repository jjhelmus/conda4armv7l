:: Configure
set CONF=Release
if "%ARCH%" == "64" (
  set ARCH=x64
) else (
  set ARCH=Win32
)

set SLN_FILE=zstd.sln
if "%VS_YEAR%" == "2008" goto skip_2015
  set TOOLSET=v140
  set SLN_DIR=%SRC_DIR%\build\VS2010
  set OUTPUT_DIR=%SRC_DIR%\build\VS2010\bin\%ARCH%_%CONF%
  cd %SLN_DIR% || exit 1
  call devenv %SLN_FILE% /Upgrade
  goto skip_2008
:skip_2015
  set TOOLSET=v90
  set SLN_DIR=%SRC_DIR%\build\VS2008
  set OUTPUT_DIR=%SRC_DIR%\build\VS2008\bin\%ARCH%\%CONF%
  cd %SLN_DIR% || exit 1
:skip_2008

if "%VS_YEAR%" == "" (
  echo Unknown VS version
  exit 1
)

:: Build
msbuild %SLN_FILE% ^
  /t:Build /v:minimal ^
  /p:Configuration=%CONF% ^
  /p:Platform=%ARCH% ^
  /p:PlatformToolset=%TOOLSET% ^
  /p:SolutionDir=%SLN_DIR%\ ^
  /p:OutDir=%OUTPUT_DIR%\
if errorlevel 1 exit 1

dir /s /b

:: Install
copy %OUTPUT_DIR%\zstd.exe %LIBRARY_BIN% || exit 1

copy %OUTPUT_DIR%\libzstd.dll %LIBRARY_BIN% || exit 1
copy %OUTPUT_DIR%\libzstd.lib %LIBRARY_LIB% || exit 1
if exist %OUTPUT_DIR%\libzstd_static.lib copy %OUTPUT_DIR%\libzstd_static.lib %LIBRARY_LIB% || exit 1
if exist %SRC_DIR%\lib\dll\libzstd.def copy %SRC_DIR%\lib\dll\libzstd.def %LIBRARY_LIB% || exit 1
copy %SRC_DIR%\lib\zstd.h %LIBRARY_INC% || exit 1
