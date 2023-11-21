# **FTP Sync**

**FTP Sync** is a batch script designed for automating file synchronization between a local destination and a remote source using WinSCP, a popular SFTP and FTP client for Windows.

## **Features**

- **Retry Mechanism:** The script includes a retry mechanism to handle synchronization failures. It will attempt to sync the files multiple times with different host keys.
- **Email Notification:** In case of synchronization failure, the script sends an email notification to alert users. The email includes details such as sender, recipient, subject, and an attached log file for further analysis.

## **Usage**

1. **Configuration:**
    - Edit the script and configure the FTP settings, credentials, log file paths, and email configurations according to your environment.
2. **Run the Script:**
    - Execute the script by double-clicking it or running it through the command line.

## **Configuration Parameters**

- **FTP Configuration:**
    - **`TRIES`**: Number of synchronization attempts.
    - **`INTERVAL`**: Time interval between retry attempts.
    - **`Server`**: FTP server name.
    - **`Username`** and **`Password`**: FTP credentials.
    - **`Destination`**: Local destination path.
    - **`Source`**: Remote source path.
- **Log File Configuration:**
    - **`LogFile`**: Absolute path for the log file.
- **Email Configuration:**
    - **`SMTPServer`**: SMTP server for email notifications.
    - **`EmailPassword`**: Password for the sender's email account.
    - **`EmailFrom`**: Sender's email address.
    - **`EmailTo`** and **`EmailCc`**: Recipient email addresses.
    - **`EmailSubject`**: Subject of the email.
    - **`EmailAttachment`**: Path to the log file to be attached.
    - **`EmailBody`**: Email body content.

## **Dependencies**

- [WinSCP](https://winscp.net/): The script uses WinSCP for FTP file synchronization.

## **License**

This project is licensed under the [MIT License](.\LICENSE).

## **Author**

Mustafa Nafiz Durukan

## **Acknowledgments**

- Special thanks to the creators of WinSCP for providing a reliable FTP synchronization tool.