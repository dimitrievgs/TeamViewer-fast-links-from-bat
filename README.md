# TeamViewer-fast-links-from-bat

This bat script generates one-click-to-open links to control remote PC via TeamViewer for given ID and password.

## Create shortcuts for quick connection

Shortcuts for quick remote connection via Teamviewer to another computer should contain a command of the following form:
```
"C:\Program Files (x86)\TeamViewer\TeamViewer.exe" -i <TeamViewerID> --Password <Password>
```
where \<TeamViewerID\> is the Teamviewer ID of the remote computer, \<Password\> is the permanent password.

## Setting or changing a permanent Teamviewer password on a computer

Depending on the Teamviewer's version:

Options - Security
<br>
Options - Security - Change or remove password 