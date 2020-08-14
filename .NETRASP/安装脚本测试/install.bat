cls
set input=%1
certutil -encode %input% %output%
echo %output%
pause
:: 检测IastNetAgent是否存在
:: 将IastNetAgent复制到目标目录下