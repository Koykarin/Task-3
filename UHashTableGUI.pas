unit UHashTableGUI;

interface

uses UInfo, Grids, UAddForm, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, StdCtrls, ExtCtrls, ComCtrls, UHashTable;

type

THashTableGUI = class(THashTable)
private
  TableView:TStringGrid;
  FModified: boolean;
  FFileName: string;

public
//  �������� ����������� ������������� �������
  constructor Create(var Grid: TStringGrid);
//  ���������� �������� � �������
  function Add(info: TInfo): TAddRes; override;
//  ��������� �������� �� �������
  function Delete(aKey: TKey): boolean; override;
//  �������� ���-������� �� �����
  procedure LoadFromFile(aFilename: string);
//  ��������� � ����
  procedure SaveToFile(aFileName: string);
//  ���������� ����������� ������������� �������
  procedure Print;
//  ������� ���-�������
  procedure Clear; override;

  property Table[Index: integer]: TCell read getCell;
  property FileName: string read FFileName write FFileName;
  property Modified: boolean read FModified write FModified;
  
end;

implementation

//�������� ����������� ������������� �������
constructor THashTableGUI.Create(var Grid: TStringGrid);
begin
  inherited Create;
  TableView:= Grid;
  TInfo.ShowTitle(Grid);
  FModified:= false;
end;

//���������� �������� � �������
function THashTableGUI.Add(info: TInfo): TAddRes;
begin
  result:= inherited AddHelp(info);
  Print;
end;

//�������� �������� �� �������
function THashTableGUI.Delete(aKey: TKey): boolean;
begin
  result:= inherited DeleteHelp(aKey);
  if result then
  begin
    FModified:= true;
    Print;
  end;
end;

//�������� ���-������� �� �����
procedure THashTableGUI.LoadFromFile(aFilename: string);
begin
  inherited LoadFromFile(aFileName);
  Print;
  FModified:= false;
end;

//���������� �������� � ����
procedure THashTableGUI.SaveToFile(aFileName: string);
begin
  inherited SaveToFile(aFileName);
  FFileName:= aFileName;
  FModified:= false;
end;

//���������� ����������� ������������� �������
procedure THashTableGUI.Print;
var
  i:Integer;
begin
  TableView.RowCount:= 1;
  for i:=0 to N do
    if(Table[i].state = csFull) then
      begin
        with TableView do
          begin
            RowCount:= RowCount + 1;
            Cells[0,RowCount-1]:= Table[i].info.Number;
            Cells[1,RowCount-1]:= Table[i].info.Mark;
            Cells[2,RowCount-1]:= Table[i].info.FIO;
          end;
      end;
end;

//������� ���-�������
procedure THashTableGUI.Clear;
begin
  inherited ClearHelp;
  Print;
  FModified:= true;
end;

end.
