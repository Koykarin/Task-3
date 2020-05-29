unit UInfo;

interface

uses
  SysUtils, Classes, Contnrs, ComCtrls, Grids;

const N = 37;

type

TKey = string;

TInfo = class
private
  FNumber: TKey;
  FMark: string;
  FFIO: String;

public
  constructor CreateEmpty;

  constructor Create(ANumber: TKey; AMark: string; AFIO: String);

  destructor Destroy; override;

  procedure SaveToFile(var f: TextFile);

  function LoadFromFile(var f: TextFile): boolean;

  procedure ShowInfo(SL: TStrings);

  class procedure ShowTitle(SG: TStringGrid);

  function Copy: TInfo;

  function IsEqual(AInfo: TInfo): boolean;

  class function HashFunction(key: TKey):Integer;

  property Number: TKey read FNumber write FNumber;

  property Mark: string read FMark write FMark;

  property FIO: string read FFIO write FFIO;

end;

implementation

class function TInfo.HashFunction(key: TKey):Integer;
begin
  result:=  ord(key[1]) div Length(key) mod N    
end;

constructor TInfo.CreateEmpty;
var
  i: integer;
begin
  FNumber:= '';
  FMark:= '';
  FFIO:= '';
end;

constructor TInfo.Create(ANumber: TKey; AMark: string; AFIO: String);
begin
  FNumber:= ANumber;
  FMark:= AMark;
  FFIO:= AFIO;
end;

destructor TInfo.Destroy;
begin
  inherited;
end;

//�������� �� ��������� ���� ��������
function TInfo.IsEqual(AInfo: TInfo): boolean;
var
  i: integer;
begin
  result:= (FNumber = AInfo.Number) and
           (FMark = AInfo.Mark) and
           (FFIO = AInfo.FIO);

end;


function TInfo.Copy: TInfo;
var
  i: integer;
begin
  result.Number:= FNumber;
  result.Mark:= FMark;
  result.FIO:= FFIO;
end;


procedure TInfo.SaveToFile(var f: TextFile);
var
  i: integer;
begin
  writeln(f, 'auto num: ', FNumber);
  writeln(f, 'brand: ', FMark);
  writeln(f, 'FIO: ', FFIO);
end;


function getSecondPart(var buf: string): boolean;
var
  p: integer;
begin
  p:= pos(':', buf);
  result:= p <> 0;
  delete(buf, 1, p + 1);
end;

function TInfo.LoadFromFile(var f: TextFile): boolean;
var
  buf: string;
  i: integer;
begin
  readln(f, buf);
  result:= buf <> '';
  if result then
  begin
    result:= getSecondPart(buf);
    FNumber:= buf;
    readln(f, buf);
    result:= getSecondPart(buf);
    FMark:= buf;
    readln(f, buf);
    result:= getSecondPart(buf);
    FFIO:= buf;
  end;
end;


class procedure TInfo.ShowTitle(SG: TStringGrid);
begin
  with SG do
  begin
    ColCount:= 3;
    RowCount:= 1;

    cells[0,0]:= 'auto num';
    cells[1,0]:= 'brand';
    cells[2,0]:= 'FIO';

    Rows[1].Clear;
  end;
end;

procedure TInfo.ShowInfo(SL:TStrings);
begin
  SL[0]:= FNumber;
  SL[1]:= FMark;
  SL[1]:= FFIO;
end;

end.
