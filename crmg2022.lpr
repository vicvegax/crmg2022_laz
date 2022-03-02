program crmg2022;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, cadUsuario, dataMod, funcoes, cadpessoal
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='CRMG 2022';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.

