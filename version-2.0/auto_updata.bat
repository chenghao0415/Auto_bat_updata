@echo off

::setting

set auto_updata=true
set server_url=https://raw.githubusercontent.com/chenghao0415/Auto_bat_updata/main
set original_name=auto_updata.bat

::end_setting

set version=version-2.0
set file_name=%~nx0
set rand=%random%

title check updata
mode con lines=5 cols=25

if "%1%"=="--del" (
	if exist %cd%\%file_name%_updata.bat del %cd%\%file_name%_updata.bat
	exit
)

if not "%auto_updata%"=="true" goto main

::updata

if exist %cd%\%file_name%_updata.bat del %cd%\%file_name%_updata.bat
echo @echo off>>"%cd%\%file_name%_updata.bat"
echo title check version>>"%cd%\%file_name%_updata.bat"
echo mode con cols=20 lines=3 >>"%cd%\%file_name%_updata.bat"
echo echo check link>>"%cd%\%file_name%_updata.bat"
echo FOR /F "tokens=2 delims=/" %%%%i in ^("%server_url%"^) do set server_host=%%%%i>>"%cd%\%file_name%_updata.bat"
echo ping -n 2 %%server_host%%^>nul>>"%cd%\%file_name%_updata.bat"
echo if %%errorlevel%%==0 (>>"%cd%\%file_name%_updata.bat"
echo cls>>"%cd%\%file_name%_updata.bat"
echo goto updata>>"%cd%\%file_name%_updata.bat"
echo ) else (>>"%cd%\%file_name%_updata.bat"
echo goto end>>"%cd%\%file_name%_updata.bat"
echo )>>"%cd%\%file_name%_updata.bat"
echo :updata>>"%cd%\%file_name%_updata.bat"
echo echo check version>>"%cd%\%file_name%_updata.bat"
echo bitsadmin.exe /transfer "download" %server_url%/version.txt %%cd%%\version.txt^>nul>>"%cd%\%file_name%_updata.bat"
echo for /f %%%%i in (%%cd%%/version.txt) do set new_version=%%%%i>>"%cd%\%file_name%_updata.bat"
echo if "%%new_version%%"=="%version%" (>>"%cd%\%file_name%_updata.bat"
echo cls>>"%cd%\%file_name%_updata.bat"
echo echo This version is the latest!>>"%cd%\%file_name%_updata.bat"
echo del /q %%cd%%\version.txt>>"%cd%\%file_name%_updata.bat"
echo ping -w 500 -n 2 0.0.0.0^>nul>>"%cd%\%file_name%_updata.bat"
echo goto end>>"%cd%\%file_name%_updata.bat"
echo ) else (>>"%cd%\%file_name%_updata.bat"
echo title Download new version!>>"%cd%\%file_name%_updata.bat"
echo echo Download new version!>>"%cd%\%file_name%_updata.bat"
echo mode con cols=70 lines=15>>"%cd%\%file_name%_updata.bat"
echo del /q %%cd%%\version.txt>>"%cd%\%file_name%_updata.bat"
echo bitsadmin.exe /transfer "download" %server_url%/%%new_version%%/%original_name% %%cd%%\%file_name%>>"%cd%\%file_name%_updata.bat"
echo cls>>"%cd%\%file_name%_updata.bat"
echo )>>"%cd%\%file_name%_updata.bat"
echo :end>>"%cd%\%file_name%_updata.bat"
echo cls>>"%cd%\%file_name%_updata.bat"
echo mode con cols=20 lines=3 >>"%cd%\%file_name%_updata.bat"
echo title End!>>"%cd%\%file_name%_updata.bat"
echo echo end>>"%cd%\%file_name%_updata.bat"
echo ping -w 500 -n 2 0.0.0.0^>nul>>"%cd%\%file_name%_updata.bat"
echo start /min /i %cd%\%file_name% --del>>"%cd%\%file_name%_updata.bat"
echo exit>>"%cd%\%file_name%_updata.bat"

start /d "%cd%" /min /i %cd%\%file_name%_updata.bat

:main
cls

echo here is the main code!
pause
exit


