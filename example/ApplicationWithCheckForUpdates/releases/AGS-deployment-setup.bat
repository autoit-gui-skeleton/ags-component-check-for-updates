::------------------------------------------------------------------------------
::
::    Copyright © 2018-05
::
::    @name           : AGS-deployment-setup
::    @version        : 1.0.1
::    @AGS package    : AGS v1.0.0
::    @AutoIt version : v3.3.14.5
::    @authors        : 20100 <vb20100bv@gmail.com>
::
::------------------------------------------------------------------------------


cls
@echo off

:: Change value for this variables
set VERSION=0.9.0
set NAME_PROJECT=ApplicationWithCheckForUpdates

:: Deployment variables
set FOLDER_CURRENT=%cd%
set NAME_EXE=%NAME_PROJECT%_v%VERSION%.exe
set FOLDER_SRC=%FOLDER_CURRENT%\..\
cd %FOLDER_SRC%
set FOLDER_SRC=%cd%
set FOLDER_OUT=%FOLDER_CURRENT%\v%VERSION%\%NAME_PROJECT%_v%VERSION%

:: AutoIt compiler
Set AUT2EXE_AU3=ApplicationWithCheckForUpdates.au3
set AUT2EXE_ICON=%FOLDER_SRC%\assets\images\myApplication.ico
set AUT2EXE_ARGS=/in "%FOLDER_SRC%\%AUT2EXE_AU3%" /out "%FOLDER_OUT%\%NAME_EXE%" /icon "%AUT2EXE_ICON%"

:: Path binaries
set ZIP_CLI="C:\Program Files\7-Zip\7z.exe"
set ISCC_CLI="C:\Program Files (x86)\Inno Setup 5\ISCC.exe"
set ISCC_SCRIPT=AGS-deployment-setup.iss


echo.
echo.
echo      [  AGS-deployment-setup  ]
echo.     
echo.


echo ----[ Variables for generation ]----
echo * VERSION        = %VERSION%
echo * NAME_PROJECT   = %NAME_PROJECT%
echo * FOLDER_CURRENT = %FOLDER_CURRENT%
echo * NAME_EXE       = %NAME_EXE%
echo * FOLDER_SRC     = %FOLDER_SRC%
echo * FOLDER_OUT     = %FOLDER_OUT%
echo * AUT2EXE_ICON   = %AUT2EXE_ICON%
echo * AUT2EXE_AU3    = %AUT2EXE_AU3%
echo * AUT2EXE_ARGS   = %AUT2EXE_ARGS%
echo * ZIP_CLI        = %ZIP_CLI%
echo * ISCC_CLI       = %ISCC_CLI%
echo * ISCC_SCRIPT    = %ISCC_SCRIPT%
echo -------------------------------------

echo.
echo.

echo ----[ Step 1/7 - Creating directories ]----
cd %FOLDER_CURRENT%
echo * Attempt to create : "%cd%\v%VERSION%\"
mkdir v%VERSION%
cd v%VERSION%
echo.
echo * Attempt to create : %cd%\%NAME_PROJECT%_v%VERSION%\
mkdir %NAME_PROJECT%_v%VERSION%
cd %FOLDER_CURRENT%
echo -------------------------------------

echo.
echo.


echo ----[ Step 2/7 - Launch AutoIt compilation ]----
echo * Run compilation with aut2exe and AUT2EXE_ARGS.
aut2exe %AUT2EXE_ARGS%
echo * Compilation AutoIt is finished.
echo -------------------------------------

echo.
echo.


echo ----[ Step 3/7 - Copy assets files ]----
echo * Create the file xcopy_EXCLUDE.txt in order to ignore some file and directory.
echo .au3 > xcopy_Exclude.txt
echo /releases/ >> xcopy_Exclude.txt
echo /src/ >> xcopy_Exclude.txt
echo /vendor/ >> xcopy_Exclude.txt
echo *   - ignore all .au3 files
echo *   - ignore all .pspimage files
echo * The file xcopy_EXCLUDE.txt is created.
echo.
echo * Copy additional files store in assets, config, docs directories
xcopy "%FOLDER_SRC%\assets" "%FOLDER_OUT%\assets\" /E /H /Y /EXCLUDE:xcopy_Exclude.txt
xcopy "%FOLDER_SRC%\config" "%FOLDER_OUT%\config\" /E /H /Y /EXCLUDE:xcopy_Exclude.txt
xcopy "%FOLDER_SRC%\docs" "%FOLDER_OUT%\docs\" /E /H /Y /EXCLUDE:xcopy_Exclude.txt
@copy "%FOLDER_SRC%\package.json" "%FOLDER_OUT%\package.json" /Y > log
echo "%FOLDER_SRC%\package.json" is copied.
@copy "%FOLDER_SRC%\README.md" "%FOLDER_OUT%\README.md" /Y > log
echo "%FOLDER_SRC%\README.md" is copied.
echo * Ok all files and directory are copied.
echo.
echo * Delete xcopy_Exclude.txt.
del xcopy_Exclude.txt
del log
echo -------------------------------------

echo.
echo.


echo ----[ Step 4/7 - Create additional files ]----
echo * Create file ".v%VERSION%" in FOLDER_OUT.
cd %FOLDER_OUT%
echo Last compilation of application %NAME_PROJECT% version %VERSION% the %date% at %time% > .v%VERSION%
echo * This file has been created.
echo -------------------------------------

echo.
echo.


echo ----[ Step 5/7 - Create zip archive ]----
echo * Move in the folder %FOLDER_CURRENT%\v%VERSION%
cd %FOLDER_CURRENT%\v%VERSION%
echo * Zip the folder %NAME_PROJECT%_v%VERSION%
%ZIP_CLI% a -tzip %NAME_PROJECT%_v%VERSION%.zip "%NAME_PROJECT%_v%VERSION%
echo * The zip has been created.
echo -------------------------------------

echo.
echo.

echo ----[ Step 6/7 - Make setup with InnoSetup command line compilation ]----
cd %FOLDER_CURRENT%
echo * Launch compilation with iscc
%ISCC_CLI% %ISCC_SCRIPT% /dApplicationVersion=%VERSION% /dApplicationName=%NAME_PROJECT%
echo.
echo * Compilation has been finished.
echo -------------------------------------

echo.
echo.

echo ----[ Step 7/7 - Delete temp folder use for ISS compilation ]----
cd %FOLDER_CURRENT%
echo * Delete the folder %FOLDER_CURRENT%\v%VERSION%\%NAME_PROJECT%_v%VERSION%\
rmdir %FOLDER_CURRENT%\v%VERSION%\%NAME_PROJECT%_v%VERSION% /S /Q
echo -------------------------------------

echo.
echo.

cd %FOLDER_CURRENT%
echo ----[ End process ]----
echo.
