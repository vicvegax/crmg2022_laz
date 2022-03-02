unit funcoes;

{$mode ObjFPC}{$H+}

interface

uses SysUtils, Messages, Forms, Controls, Windows;

const
  WM_ACAO = WM_USER + 10;  //Message
  wpModo = 1;           //wParam
  wpConfirma = 2;          //wParam

  kModo: array[1..3] of string = ('Inclusão', 'Alteração', 'Exclusão');
  modoInc = 1;
  modoAlt = 2;
  modoExc = 3;


  kNovoId = '(NOVO)';
  kENTER = #13;

  kMsgInc = 'Confirma Inclusão deste Registro?';
  kMsgAlt = 'Confirma Alteração deste Registro?';
  kMsgExc = 'Confirma Exclusão deste Registro?';
  kMsgCer = 'Tem Certeza?';
  kJaCad = 'Este "%s" já está cadastrado.';
  kNaoLoc = 'Este "%s" não foi localizado.';
  kCadas = 'Este "%s" não existe. Deseja cadastrá-lo?';
  kPreen = 'Você deve preencher o campo "%s" corretamente.';

var
  wUsuario: string;
  wModo: Integer;

function Codifica(const Str1: string): String;
function CodificaH(const St: String; const Tp: Byte): String;

function MsgBox(sMen, sCap: String; iFlag: Integer = 0): Integer;
procedure MsgErro(const sMen: String);
procedure MsgPreen(const sCampo: String);
function MsgPergunta(const sMen, sCap: String): Boolean;
procedure MudaModo(novoModo: Integer);

implementation

procedure MudaModo(novoModo: integer);
begin
  SendMessage(Application.MainForm.Handle, WM_ACAO, wpModo, novoModo);
end;

function Codifica(const Str1: string): String;
{Encripta uma string}
const
  Mascara = '#$%$'#13#12;
var
	Str2: String;
	PonM, PonS: Byte;
begin
Str2:= '';
PonM:= 1;
for PonS:=1 to Length(Str1) do begin
 Str2:= Str2 + Chr(Ord(Str1[PonS]) Xor Ord(Mascara[PonM]));
 Inc(PonM);
 if PonM > Length(Mascara) then PonM:= 1;
 Result:= Str2;
end;{for}
end;

function CodificaH(const St: String; const Tp: Byte): String;
var
	St2, sHx: String;
  i, q: Integer;
begin
Result:= '';
if St = '' then Exit;
if Tp = 0 then begin //Encripta
	St2:= Codifica(St);
  sHx:= '';
  for i:=1 to Length(St2) do
    sHx:= IntToHex(Ord(St2[i]), 2) + sHx;
  St2:= sHx;
end else begin       //Decripta
	q:= Length(St);
	if (q mod 2) > 0 then begin
  	Result:= '***LGT' + IntToStr(q) + '***';
    Exit;
  end;{if}
	St2:= '';
  for i:= 1 to (q div 2) do
  	St2:= Chr(StrToInt('$' + Copy(St, (i * 2 - 1), 2))) + St2;
  St2:= Codifica(St2);
end;{if}
Result:= St2;
end;



///////////////// Mensagens
function MsgBox(sMen, sCap: String; iFlag: Integer = 0): Integer;
begin
	Screen.Cursor:= crDefault;
	Result:= Application.MessageBox(PChar(sMen), PChar(sCap), iFlag);
end;{MsgBox}

procedure MsgErro(const sMen: String);
begin
  MsgBox(sMen, 'Atenção', MB_OK + MB_ICONWARNING);
end;{MsgErro}

procedure msgPreen(const sCampo: String);
begin
  MsgErro(Format(kPREEN, [sCampo]));;
end;{MsgErro}

function msgPergunta(const sMen, sCap: String): Boolean;
begin
  result:= MsgBox(sMen, sCap, MB_YESNO + MB_ICONQUESTION) = IDYES;
end;{MsgErro}
///////////////// Fim Mensagens




end.
