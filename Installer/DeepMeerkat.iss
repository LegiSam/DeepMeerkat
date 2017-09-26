; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!
                                                
[Setup]           
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{5C784574-7162-4518-849C-B2C13F88B122}
AppName=DeepMeerkat
AppVersion=0.0.1
AppPublisher=Ben Weinstein                                   
AppPublisherURL=benweinstein.weebly.com
AppSupportURL=benweinstein.weebly.com
AppUpdatesURL=benweinstein.weebly.com                  
DefaultDirName={pf}\DeepMeerkat
DefaultGroupName=DeepMeerkat
LicenseFile=C:\Users\Ben\Documents\DeepMeerkat\License.txt           
OutputBaseFilename=DeepMeerkatSetup
Compression=lzma
SolidCompression=yes
DisableDirPage=no
ArchitecturesInstallIn64BitMode=x64
                                                    
[Languages]                                                                           
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
                
[Files]
Source: "C:\Users\Ben\Documents\DeepMeerkat\Installer\dist\Lib\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs ignoreversion
Source: "C:\FFmpeg\bin\ffmpeg.exe";DestDir: "{app}\FFmpeg"; Flags: ignoreversion
Source: "vc_redist.x64.exe"; DestDir: "{app}"; Check: Is64BitInstallMode

; DeepMeerkat requires the VC 2015 redistributables so run the installer if this 
; or a later 2015 version is not already present

[Code]
function VCinstalled: Boolean;
 // Function for Inno Setup Compiler
 // Returns True if same or later Microsoft Visual C++ 2015 Redistributable is installed, otherwise False.
 var
  major: Cardinal;
  minor: Cardinal;
  bld: Cardinal;
  rbld: Cardinal;
  key: String;
 begin
  Result := False;
  key := 'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64';
  if RegQueryDWordValue(HKEY_LOCAL_MACHINE, key, 'Major', major) then begin
    if RegQueryDWordValue(HKEY_LOCAL_MACHINE, key, 'Minor', minor) then begin
      if RegQueryDWordValue(HKEY_LOCAL_MACHINE, key, 'Bld', bld) then begin
        if RegQueryDWordValue(HKEY_LOCAL_MACHINE, key, 'RBld', rbld) then begin
            Log('VC 2015 Redist Major is: ' + IntToStr(major) + ' Minor is: ' + IntToStr(minor) + ' Bld is: ' + IntToStr(bld) + ' Rbld is: ' + IntToStr(rbld));
            // Version info was found. Return true if later or equal to our 14.0.24212.00 redistributable
            // Note brackets required because of weird operator precendence
            Result := (major >= 14) and (minor >= 0) and (bld >= 24212) and (rbld >= 0)
        end;
      end;
    end;
  end;
 end;                                                     
[Icons]
Name: "{group}\DeepMeerkat"; Filename: "{app}\DeepMeerkat.exe"; IconFileName: "{app}\images\thumbnail.ico"
Name: "{commondesktop}\DeepMeerkat"; IconFileName: "{app}\images\thumbnail.ico"; Filename: "{app}\DeepMeerkat.exe"; Tasks: desktopicon

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\FFmpeg";

[Run]
Filename: "{app}\vc_redist.x64.exe"; Parameters: "/install /passive"; StatusMsg: "Installing vc redist"; Check: IsWin64 and not VCinstalled
Filename: "{app}\DeepMeerkat.exe"; Description: "{cm:LaunchProgram,DeepMeerkat}"; Flags: nowait postinstall skipifsilent
Filename: "https://github.com/bw4sz/DeepMeerkat/wiki"; Flags: shellexec runasoriginaluser postinstall; Description: "Open the Wiki."
           