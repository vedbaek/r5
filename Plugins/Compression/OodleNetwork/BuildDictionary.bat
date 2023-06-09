@echo off

echo This batch file, goes through the fully automated process of building Oodle dictionaries from packet captures.
echo.


REM This batch file should be run from \engine\plugins\compression\oodlenetwork
set BaseFolder="..\..\..\.."

if exist %BaseFolder:"=%\Engine goto SetUEEditor

echo Could not locate Engine folder. This .bat must be run from \engine\plugins\compression\oodlenetwork
goto End


:SetUEEditor
set UEEditorLoc="%BaseFolder:"=%\Engine\Binaries\Win64\UnrealEditor.exe"

if exist %UEEditorLoc:"=% goto GetGame

echo Could not locate UnrealEditor.exe
goto End


:GetGame
set /p GameName=Type the name of the game you are working with: 
echo.



:AutoGenDictionaries
set AutoGenDictionariesParms=-run=OodleNetworkTrainerCommandlet AutoGenerateDictionaries
set FinalGenCmdLine=%GameName:"=% %AutoGenDictionariesParms% -forcelogflush

echo Executing dictionary generation commandlet - commandline:
echo %FinalGenCmdLine%

@echo on
%UEEditorLoc:"=% %FinalGenCmdLine%
@echo off
echo.


if %errorlevel%==0 goto End

echo WARNING! Detected error, dictionaries may not have been generated. Check output and logfile for errors.
pause


:End
echo Execution complete.
pause


REM Put nothing past here.

