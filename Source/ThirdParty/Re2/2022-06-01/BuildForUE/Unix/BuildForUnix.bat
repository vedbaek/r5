@rem Copyright Epic Games, Inc. All Rights Reserved.
@echo off

set ENGINE_ROOT=%~dp0..\..\..\..\..\..
set THIRDPARTY_ROOT=%ENGINE_ROOT%\Source\ThirdParty
set CMAKE_ADDITIONAL_ARGUMENTS=-DRE2_BUILD_TESTING=OFF -DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=OFF -DBUILD_WITH_LIBCXX=ON
call "%ENGINE_ROOT%\Build\BatchFiles\RunUAT.bat" BuildCMakeLib -TargetPlatform=Unix -TargetArchitecture=x86_64-unknown-linux-gnu -TargetLib=re2 -TargetLibVersion=2022-06-01 -TargetConfigs=Release -LibOutputPath=lib -CMakeGenerator=Makefile -CMakeAdditionalArguments="%CMAKE_ADDITIONAL_ARGUMENTS%" -SkipCreateChangelist || exit /b
call "%ENGINE_ROOT%\Build\BatchFiles\RunUAT.bat" BuildCMakeLib -TargetPlatform=Unix -TargetArchitecture=aarch64-unknown-linux-gnueabi -TargetLib=re2 -TargetLibVersion=2022-06-01 -TargetConfigs=Release -LibOutputPath=lib -CMakeGenerator=Makefile -CMakeAdditionalArguments="%CMAKE_ADDITIONAL_ARGUMENTS%" -SkipCreateChangelist || exit /b
