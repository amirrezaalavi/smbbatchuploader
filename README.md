# smb batch uploader
This is a simple batch script (Aimed at Windows) that lets you upload your files based on file format to a remote SMB server.

## How to run the program
Simply clone the repo using git or any other tool, then go to the location using cmd or Powershell on Windows and run the program :
```batch
.\main.bat
```
You will be asked to Enter some information, then the script will run it self, and create a log file in the same directory.
## Example Usage:
```
Enter file format (e.g., .txt, .pdf, .doc): .pdf
Enter local directory path: C:\Documents
Enter SMB server path (e.g., \\server\share): \\server\share
Enter SMB username: user123
Enter SMB password: pass123
Enter remote folder name: folder1
```
