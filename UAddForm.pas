unit UAddForm;

interface

uses
  UInfo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TAddForm = class(TForm)
    edNumber: TEdit;
    lbNum: TLabel;
    edMark: TEdit;
    lbMark: TLabel;
    btnSave: TButton;
    btnExit: TButton;
    lbFIO: TLabel;
    edFIO: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    constructor Create(AOwner: TComponent);
    constructor CreateShow(AOwner: TComponent; info: TInfo);
  private

  public
    { Public declarations }
    Correct: boolean;
    Number: string;
    Mark: string;
    FIO: string;

  end;

var
  AddForm: TAddForm;

implementation

{$R *.dfm}

constructor TAddForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  edNumber.ReadOnly:= false;
  edMark.ReadOnly:= false;
  edFIO.ReadOnly:= false;
  AddForm.SetAutoSize(false);
end;

constructor TAddForm.CreateShow(AOwner: TComponent; info: TInfo);
begin
  inherited;
  edNumber.Text:= info.Number;
  edMark.Text:= info.Mark;
  edFIO.Text:= info.FIO;

  btnSave.Visible:= false;
end;

function CorrectNum(str: string): boolean;
begin
  result:= (str[1] in ['a'..'z']) and (str[2] in ['0'..'9']) and (str[3] in ['0'..'9']) and
           (str[4] in ['0'..'9']) and (str[5] in ['a'..'z']) and (str[5] in ['a'..'z'])
end;

procedure TAddForm.btnSaveClick(Sender: TObject);
begin
  if(edNumber.Text = '') or (edMark.Text = '') or (edFIO.Text = '') then
    ShowMessage('Не все обязательные поля заполнены')
  else
    if CorrectNum(edNumber.Text) then
    begin
      Number:= edNumber.Text;
      Mark:= edMark.Text;
      FIO:= edFIO.Text;
      Correct:= true;
      Close;
    end
    else
      ShowMessage('неправильный номер авто');
end;

procedure TAddForm.btnExitClick(Sender: TObject);
begin
  Close;
end;


end.
