# Surf's Prio

These commands will add a persistent setting in windows's registry to force constant process priority for a specified executable (name related) (aka high priority for NAME.EXE)

# How to use

Everything is included in a ready-to-use batch script.
Just run "Surf's Prio.bat" as Administrator. UAC Prompt may pop up, if so, click yes.

Update : A 32bit executable has been released. It's just the compiled version of the Batch script.

# How does it work

It creates the following entry in the windows registry :
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PROCESSNAME.EXE\PerfOptions]
  "CpuPriorityClass"=dword:00000003

# How to cancel changes

Just remove the new register entry :
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PROCESSNAME.EXE]
