unit UKey;

interface


{type

TKey = class
private
  FKey: integer;
public
  {�������� ������� ����������}
//  constructor Create(aKey: integer = 0);
  {��������� �������� ������}
//  function IsEqual(aKey:TKey):Boolean;
//  {��������� ���-�������}
//  function BadHashFunction():Integer;
//
//  function GoodHashFunction():Integer;
{
  property Value:integer
    read FKey
    write FKey;
end;

implementation

{�������� ������� ����������}
{
constructor TKey.Create(aKey: integer = 0);
begin
  FKey:=aKey;
end;

{��������� �������� ������}
{
function TKey.IsEqual(aKey:TKey):Boolean;
begin
  Result:= FKey = aKey.FKey;
end;

function TKey.BadHashFunction():Integer;
begin
  result:= FKey mod N mod 3;
end;

function TKey.GoodHashFunction():Integer;
begin
  result:= FKey mod N;
end;
}
//end.











