@echo off

SET installPath=C:\inetpub\wwwroot\mopen\eopen
SET needBackupConfig=Y
SET installMode=2
FOR /F "tokens=1,2,3 delims==(" %%G IN (.\install_config.init) DO (
    @echo %%G=%%H
    SET %%G=%%H
)
echo ***************************
echo 歡迎使用 eOpen 安裝程式
echo ***************************
echo.
echo 檢查安裝目錄:%installPath%
echo.
IF EXIST %installPath%\build.info (
    echo 您已經安裝 eOpen
    echo 您目前的版本資訊如下：
    FOR /F "tokens=1,2,3 delims==(" %%G IN (%installPath%\build.info) DO (
        @echo %%G=%%H
        SET %%G=%%H
    )
    echo.
    echo 請選擇本次安裝模式：
    echo 1. 完整安裝^(移除上一個版本，並重新安裝，設定檔將會初始化^)
    echo 2. 差異安裝^(只更新差異檔案^)
    SET /P installMode="請選擇:"
) ELSE (
    echo 您尚未安裝 eOpen
    SET installMode=1
)
echo 檢查安裝檔
IF NOT EXIST eopen_*.zip (
    echo 安裝檔不存在
    goto END
) ELSE (
    echo OK!
)

echo 資料備份中...
RD .\eOpen_backup_%version% /Q /S
MD .\eOpen_backup_%version% >> nul
XCOPY %installPath%\* .\eOpen_backup_%version% /Y /Q /S >>nul
echo 安裝開始
echo.>>installLog.log
echo.>>installLog.log
echo ********************************************************>>installLog.log
DATE /T >>installLog.log
TIME /T >>installLog.log
echo 安裝開始>>installLog.log

IF /I %installMode%==2 (
    goto MODE_2
) ELSE (
    goto MODE_1
)

:MODE_1
echo 完整安裝進行中
echo 完整安裝進行中>>installLog.log
RD %installPath% /Q /S >> nul
MD %installPath% >> nul
bin\unzip eopen_*.zip -d %installPath% >>installLog.log
echo 安裝完成
echo 安裝完成>>installLog.log
echo ********************************************************>>installLog.log
goto END

:MODE_2
echo 差異安裝進行中
echo 差異安裝進行中>>installLog.log
RD %installPath% /Q /S >> nul
MD %installPath% >> nul
bin\unzip eopen_*.zip -d %installPath% >>installLog.log
XCOPY .\eOpen_backup_%version%\config\* %installPath%\config /Y /D /S >>installLog.log
echo 安裝完成
echo 安裝完成>>installLog.log
echo ********************************************************>>installLog.log
goto END
:END
echo 安裝記錄請參考 installLog.log
pause
