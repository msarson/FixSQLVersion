
                    PROGRAM


                    MAP
                    END

  INCLUDE('StringTheory.inc'),ONCE
  INCLUDE('ConsoleSupport.inc'),ONCE

Console             CLASS(ConsoleSupport).


VersionType:TPS     EQUATE(0)
VersionType:SQL     EQUATE(1)

stVersion           StringTheory
stProject           StringTheory
VersionType         BYTE ! 0 TPS 1 SQL
ResultVersionTPS    LONG
ResultVersionSQL    LONG

ProjectFiles        QUEUE(FILE:Queue),PRE(PFI).
ProjectCounter      LONG
stPath StringTheory
  CODE
  stPath.SetValue(stPath.PathOnly(COmmand(0)))
  Console.Init(0)
  IF ~stVersion.LoadFile(stPath.GetValue() & '\version.ini') THEN
    Console.WriteLine('No Verion.Ini in Directory: ' & stPath.GetValue())
    RETURN
  END
  if stVersion.Instring('Driver=TPS')
    VersionType = VersionType:TPS
  ELSif stVersion.Instring('Driver=SQL')
    VersionType = VersionType:SQL
  ELSE
    !Not known version type
    Console.WriteLine('Unknown Version type in Version.ini')
    RETURN
  END
  SETPATH(stPath.GetValue())
  DIRECTORY(ProjectFiles,'*.cwproj',ff_:DIRECTORY) 
  IF NOT RECORDS(ProjectFiles)
    Console.WriteLine('No Project files to parse')
  END
  
  LOOP ProjectCounter = 1 to RECORDS(ProjectFiles)
    GET(ProjectFiles, ProjectCounter)
  

  !Try to load passed in project
    IF ~stProject.LoadFile(ProjectFiles.Name)
      CYCLE
    END
  
    ResultVersionTPS = stProject.Instring('SQLVersion=&gt;0')
    IF NOT ResultVersionSQL
    !CHECK FOR SQL
      ResultVersionSQL = stProject.Instring('SQLVersion=&gt;1')
    END
  
  !Version set at neither
    IF NOT ResultVersionTPS + ResultVersionSQL THEN
      CYCLE
    END
  
    IF VersionType = VersionType:TPS and ResultVersionSQL THEN
      IF stProject.Replace('SQLVersion=&gt;1','SQLVersion=&gt;0')
        IF stProject.SaveFile(ProjectFiles.Name)
          Console.WriteLine('Fixed: ' & CLIP(ProjectFiles.Name))
          CYCLE
        END
      END
    END
  
    IF VersionType = VersionType:SQL and ResultVersionTPS THEN
      IF stProject.Replace('SQLVersion=&gt;0%','SQLVersion=&gt;1%')
        IF stProject.SaveFile(ProjectFiles.Name)
          Console.WriteLine('Fixed: ' & CLIP(ProjectFiles.Name))
          CYCLE
        END
      END
    END
  END
  
  
  

  