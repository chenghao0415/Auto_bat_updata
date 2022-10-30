@echo off

::goto start
::如果不要自動更新,刪除上方那行的::

set version=version-1
set file_name=%~n0.bat

title check updata
mode con lines=5 cols=25

::link

set server_host=github.com
set server_url=https://raw.githubusercontent.com/chenghao0415/Auto_bat_updata/main

del /f /q %cd%\updata.bat
cls

ping -n 2 %server_host%>nul

if %errorlevel%==0 (
	goto updata
) else (
	goto start
)

:updata

echo check version

bitsadmin.exe /transfer "download" %server_url%/version.txt %cd%\version.txt>nul

for /f %%i in (%cd%/version.txt) do set new_version=%%i

if %new_version%==%version% (
	echo This version is the latest!
	del /q %cd%\version.txt
	goto start
) else (
	echo Download new version!
	del /q %cd%\version.txt
	echo @echo off>>%cd%\updata.bat
	echo title updata>>%cd%\updata.bat
	echo mode con cols=70 lines=15>>%cd%\updata.bat
	echo echo Download new version!>>%cd%\updata.bat
	echo del /q %cd%\%file_name%>>%cd%\updata.bat
	echo bitsadmin.exe /transfer "download" %server_url%/%new_version%/%file_name% %cd%\%file_name%>>%cd%\updata.bat
	echo cls>>%cd%\updata.bat
	echo start /d %cd% %cd%\%file_name%>>%cd%\updata.bat
	echo exit>>%cd%\updata.bat
	start /d %cd% /min /i %cd%\updata.bat
	exit
)

:start
cls

echo ya
pause
exit
