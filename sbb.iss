#define CertFile "sbb.crt"
#define CertStore "Root"

[Setup]
AppName=Certificate Installer
AppVersion=1.0
DefaultDirName={tmp}
DisableDirPage=yes
DisableProgramGroupPage=yes
Uninstallable=no

[Files]
Source: "{#CertFile}"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
Filename: "powershell.exe"; \
Parameters: "-ExecutionPolicy Bypass -NoProfile -Command Import-Certificate -FilePath ""{tmp}\{#CertFile}"" -CertStoreLocation Cert:\CurrentUser\{#CertStore}"; \
Flags: runhidden waituntilterminated

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    MsgBox(
      'The certificate has been installed successfully.'#13#13 +
      'Please close any open browser windows and reopen them before continuing.',
      mbInformation,
      MB_OK
    );
  end;
end;