@echo off

:: FTP Configuration
SET TRIES=2
SET INTERVAL=10

:: Credential Configuration
SET Server=[FTP_Server_Name]
SET Username=[Username]
SET Password=[Password]
SET Destination=[Local_Destination_Path]
SET Source=[Remote_Source_Path]

:: Log File Configuration
SET DateStamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%
SET LogFile="[LOG_FILE_ABSOLUTE_PATH]\%DateStamp%.log"

:: Email Configuration
SET SMTPServer=smtp.gmail.com
SET EmailPassword=[Email_Password]
SET EmailFrom=from@gmail.com
SET EmailTo=to@gmail.com
SET EmailCc=cc@gmail.com
SET EmailSubject=[Subject]
SET EmailAttachment="%LogFile%"
SET EmailBody="FTP transfer failed.`r`nLog file attached."

:Begin
SET HostKey=%ProdHostKey%

:Retry
:: Launch WinSCP
"C:\Program Files (x86)\WinSCP\WinSCP.com" ^
    /log="%LogFile%" /ini=nul ^
    /command ^
    "Option confirm off" ^
    "open ftp://%Username%:%Password%@%Server%" ^
    "synchronize local "%Destination%" "%Source%"" ^
    "Close" ^
    "Exit"	
	

SET WINSCP_RESULT=%ERRORLEVEL%
if %WINSCP_RESULT% equ 0 (
    echo Success
    ) else (
            SET /A TRIES=%TRIES%-1
            IF %TRIES% GTR 1 (
                echo Transfer failed, retrying using DR hostkey, in %INTERVAL% seconds...
                timeout /t %INTERVAL%
                SET HostKey=%DRHostKey%
                goto Retry
            ) else (
                    echo Connection failed, aborting and sending an email notification.
                    echo.
                    echo From: %EmailFrom%
                    echo To: %EmailTo%
                    echo Subject: %EmailSubject%
                    echo Attachments: %EmailAttachment%
                    echo Message: %EmailBody%
                    powershell.exe -NoLogo -NoProfile -Command ^
                            "$username='%EmailFrom%';" ^
                            "$password=ConvertTo-SecureString '%EmailPassword%' -AsPlainText -Force;" ^
                            "$Creds = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password);" ^
                            "Send-MailMessage" ^
                            "-Credential $Creds" ^
                            "-To '%EmailTo%'" ^
                            "-From '%EmailFrom%'" ^
                            "-Subject '%EmailSubject%'" ^
                            "-SmtpServer '%SMTPServer%'" ^
                            "-Body "%EmailBody%"" ^
                            "-UseSsl" ^
                            "-Port 587" ^
                            "-DeliveryNotificationOption never" ^
                            "-Attachments %EmailAttachment%" ^
                            "-Cc %EmailCc%"
                            
                    exit /b 1
                    )
)

exit /b %WINSCP_RESULT%