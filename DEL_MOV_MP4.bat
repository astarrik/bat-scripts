@echo off
set "sourceFolder=Y:\TEST"


REM Отримання поточної дати мінус 12 днів
for /f %%a in ('powershell -Command "(Get-Date).AddDays(-10).ToString('yyyy-MM-dd')"') do set "cutoffDate=%%a"

for /r "%sourceFolder%" %%F in (*.mov *.mp4 *.mxf) do (
    for /f %%d in ('powershell -Command "if ((Get-Item -LiteralPath '%%~fF').LastWriteTime -lt (Get-Date).AddDays(-10)) { Write-Output 'true' }"') do (
        if "%%d"=="true" (
            echo Deleting file: "%%F"
            del "%%F"
        )
    )
)

