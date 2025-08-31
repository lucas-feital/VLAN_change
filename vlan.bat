@echo off
chcp 65001 > nul
cls

:MENU
echo Escolha uma das opções abaixo:
echo 1 - Rede 1 (VLan 0)
echo 2 - Rede 2 (VLan 900)
echo 3 - Rede 3 (VLan 1000)
echo 4 - Rede 4 (VLan 2000)
echo 5 - Rede 5 (VLan 750)
echo 6 - Rede 6 (VLan 1500)

set /p opcao=Digite o número da opção desejada: 

if "%opcao%"=="1" (
    set "valor=0"
) else if "%opcao%"=="2" (
    set "valor=900"
) else if "%opcao%"=="3" (
    set "valor=1000"
) else if "%opcao%"=="4" (
    set "valor=2000"
) else if "%opcao%"=="5" (
    set "valor=750"
) else if "%opcao%"=="6" (
    set "valor=1500"
) else (
    cls
    echo Opção inválida. Por favor, selecione um número válido.
    echo.
    goto MENU
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "RegVlanid" /t REG_SZ /d %valor% /f

echo O valor do registro RegVlanid foi alterado.

echo Reiniciando o adaptador de rede...
netsh interface set interface "Ethernet" admin=disabled
timeout /t 3 > nul
netsh interface set interface "Ethernet" admin=enabled

echo Aguarde... Obtendo endereço IP por DHCP...
ipconfig /renew

echo A placa de rede obteve um endereço IP válido por DHCP.
