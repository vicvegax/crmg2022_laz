unit cadUsuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  funcoes, windows;

type

  { TfUsuario }

  TfUsuario = class(TForm)
    DBGrid1: TDBGrid;
    edDescr: TEdit;
    edID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edDescrChange(Sender: TObject);
  private
    procedure WMACAO(var Msg: TMessage); message WM_ACAO;
    procedure LimpaCampos;
    var
      qtModoInc: integer;
  public

  end;

var
  fUsuario: TfUsuario;

implementation

{$R *.lfm}

{ TfUsuario }

procedure TfUsuario.edDescrChange(Sender: TObject);
begin

end;

procedure TfUsuario.WMACAO(var Msg: TMessage);
begin
  if Msg.wParam = wpModo then begin
    if Msg.LParam <> modoInc then begin
      //if(qyRec.RecordCount > 0) then PreCampos
      //else MudaModo(modoInc);
    end else begin
      edID.Text:= kNovoID;
      inc(qtModoInc);
      if(qtModoInc > 1) then begin
        LimpaCampos;
        qtModoInc:= 0;
      end;
    end;
    edDescr.SetFocus;
  end;
  if Msg.WParam = wpConfirma then begin
    //ExeAcao;
  end;

end;

procedure TfUsuario.LimpaCampos;
begin
  edDescr.Text:= '';
  edID.Text:= kNovoID;
  qtModoInc:= 0;
end;

end.

