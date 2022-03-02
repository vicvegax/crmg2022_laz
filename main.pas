unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, ActnList, ulazautoupdate, LR_Class, windows;

type

  { TfMain }

  TfMain = class(TForm)
    acInc: TAction;
    acAlt: TAction;
    acExc: TAction;
    acConf: TAction;
    ActionList1: TActionList;
    btAtu: TButton;
    LazAutoUpdate1: TLazAutoUpdate;
    pnAtu: TPanel;
    pnPag: TPanel;
    pnAcao: TPanel;
    pnCap: TPanel;
    pnCad: TPanel;
    gpCad: TPanel;
    ScrollBox1: TScrollBox;
    btInc: TSpeedButton;
    btAlt: TSpeedButton;
    btExc: TSpeedButton;
    btConf: TSpeedButton;
    btInv: TSpeedButton;
    btCat: TSpeedButton;
    btLoc: TSpeedButton;
    btPes: TSpeedButton;
    btUsu: TSpeedButton;
    procedure acConfExecute(Sender: TObject);
    procedure acModoExecute(Sender: TObject);
    procedure btPesClick(Sender: TObject);
    procedure btAtuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCadastroClick(Sender: TObject);
    procedure pnPagClick(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    procedure atuCaption(st: String);
    var
      fChild: TForm;
      lCaption: String;
  public

  end;

var
  fMain: TfMain;

implementation

uses cadUsuario, funcoes, cadpessoal;

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
begin
with LazAutoUpdate1 do begin
  VersionsININame:='crmg2022.ini';
  ZipfileName:='crmg2022.zip';
  CopyTree:=False;
  ShowDialogs:=False;
  UpdatesFolder:='updates';
  DebugMode:= true;
  ProjectType:= auGitHubReleaseZip; //precisa ficar antes do Git***** - 09/02/2022
  GitHubBranchOrTag:= 'main';
  GitHubProjectname:='vicvegax';
  GitHubRepositoryName:= 'crmg2022_laz';
end;
fMain.Caption := fMain.caption + ' v' + LazAutoUpdate1.AppVersion;

end;

procedure TfMain.acModoExecute(Sender: TObject);
begin
if(not Assigned(fChild)) then Exit;

 wModo:= TComponent(Sender).Tag;
 if(wModo = 1) then btInc.Down:= true
 else if(wModo = 2) then btAlt.Down:= true
 else btExc.Down:= true;

 //fChild.Tag:= lModo;

 fChild.Caption:= lCaption + ' - Modo de ' + kModo[wModo];
 atuCaption(fChild.Caption);
 SendMessage(fChild.Handle, WM_ACAO, wpModo, wModo);  //Informa que o Modo foi Alterado (Inc, Alt, Exc)
end;

procedure TfMain.btPesClick(Sender: TObject);
begin

end;

procedure TfMain.btAtuClick(Sender: TObject);
begin
  Screen.Cursor:= crHourglass;
  btATU.Enabled:= false;
  pnATU.Height:= 350;
  pnATU.Width:= 500;
  pnATU.Left:= (Self.Width - pnAtu.Width) div 2;
  pnATU.Top:= (Self.Height - pnAtu.Height) div 2;
  pnATU.Show;
  LazAutoUpdate1.AutoUpdate;
  pnATU.Hide;
  btATU.Enabled:= true;
  Screen.Cursor:= crDefault;

end;

procedure TfMain.acConfExecute(Sender: TObject);
begin
 if(not Assigned(fChild)) then Exit;

 SendMessage(fChild.Handle, WM_ACAO, wpConfirma, 0); //Informa Ação Confirma
end;

procedure TfMain.btCadastroClick(Sender: TObject);
var
  iTag: integer;
  bChild: boolean;
begin
itag:= TComponent(Sender).Tag;
bChild:= true;
if(Assigned(fChild)) then begin
  bChild:= false;
  pnCap.hide;
  pnAcao.hide;
  if(fChild.Tag <> iTag) then begin
    bChild:= true;
  end;
  fChild.Close;
  fChild.Free;
  fChild:= nil;
end;
if(bChild) then begin
  case itag of
    //3: fChild:= TfLocal.Create(Application);
    4: fChild:= TfPessoal.Create(Application);
    5: fChild:= TfUsuario.Create(Application);
  end;

  //pnHead.Caption
  lCaption:= fChild.Caption;
  pnCap.show;
  pnAcao.Show;
  fChild.Tag:= iTag;
  fChild.manualdock(pnPag);
  fChild.show;
  acInc.Execute;
end;
end;

procedure TfMain.pnPagClick(Sender: TObject);
begin

end;

procedure TfMain.SpeedButton9Click(Sender: TObject);
begin

end;

procedure TfMain.atuCaption(st: String);
begin
  pnCap.Caption:= st;
end;

end.

