
@echo off
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 ECHO Unable to enable extensions

IF "%~1"=="" goto :USAGE

goto :MAIN

:COPY_DIR
FOR /F "tokens=*" %%g IN ('dir /b %~1\*%~2') do (SET BINARY_FOLDER=%%g)
SET BINARY_SOURCE_PATH=%~1\%BINARY_FOLDER%

if exist %BINARY_FOLDER% (
    echo Folder %BINARY_FOLDER% already exists
    if not "%~3"=="/f" (
        exit /b 1
    )
)

echo Copying %BINARY_FOLDER%
mkdir %BINARY_FOLDER%
xcopy /q /e /y %BINARY_SOURCE_PATH% %BINARY_FOLDER%
exit /b 0

:COPY_WORKING_BINARIES
p4 edit //Portal/Main/Engine/Binaries/ThirdParty/CEF3/%~1/...
FOR /F "tokens=*" %%g IN ('dir /b *%~2') do (SET BINARY_FOLDER=%%g)
echo %BINARY_FOLDER%
xcopy /q /y %BINARY_FOLDER%\Release\*.so ..\..\..\Binaries\ThirdParty\CEF3\%~1
xcopy /q /y %BINARY_FOLDER%\Release\*.bin ..\..\..\Binaries\ThirdParty\CEF3\%~1
xcopy /q /y %BINARY_FOLDER%\Release\chrome-sandbox ..\..\..\Binaries\ThirdParty\CEF3\%~1
xcopy /q /e /y %BINARY_FOLDER%\Resources ..\..\..\Binaries\ThirdParty\CEF3\%~1\Resources
xcopy /q /e /y %BINARY_FOLDER%\Resources\icudtl.dat ..\..\..\Binaries\ThirdParty\CEF3\%~1\icudtl.dat
xcopy /e /y /i %BINARY_FOLDER%\Release\swiftshader ..\..\..\Binaries\ThirdParty\CEF3\%~1\swiftshader
p4 reconcile //Portal/Main/Engine/Binaries/ThirdParty/CEF3/%~1/...
p4 revert -a //Portal/Main/Engine/Binaries/ThirdParty/CEF3/%~1/...

exit /b 0

:PRINT_RESULTS
FOR /F "tokens=*" %%g IN ('dir /b %~1\*%~2') do (SET BINARY_FOLDER=%%g)
echo %BINARY_FOLDER%
exit /b 0

:MAIN
call :COPY_DIR %~1 linux64 %~2 || goto :FAIL
call :COPY_WORKING_BINARIES Linux linux64
echo ""
echo ""
echo Updated Drop. New folders are:
call :PRINT_RESULTS %~1 linux64
echo ""
echo "Update CEF3.build.cs with these new folders"

exit /b 0

:USAGE
echo "%~0 <path to CEF drop update> [/f]"
exit /b 1

:FAIL
echo Failed.
exit /b 1