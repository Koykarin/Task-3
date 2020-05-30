{ Задан набор записей следующей структуры: номер автомобиля, его марка,
 ФИО владельца. По номеру автомобиля найти остальные сведения}
unit Hash_Main;

interface

uses
  UHashTableGUI, UAddForm, UInfo, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, Grids, StdCtrls, ExtCtrls, ComCtrls, ImgList,
  ToolWin, UHashTable;

type
  TFrmMain = class(TForm)
    StrGrid: TStringGrid;
    MainMenu: TMainMenu;
    mnifile: TMenuItem;
    miNew: TMenuItem;
    miOpen: TMenuItem;
    miSave: TMenuItem;
    miSaveAs: TMenuItem;
    miClose: TMenuItem;
    miEdit: TMenuItem;
    miFind: TMenuItem;
    miDel: TMenuItem;
    miClear: TMenuItem;
    miProcess: TMenuItem;
    miTask: TMenuItem;
    miAdd: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure New(Sender: TObject);
    procedure Add(Sender: TObject);
    procedure Delete(Sender: TObject);
    procedure Clear(Sender: TObject);
    procedure Save(Sender: TObject);
    procedure Open(Sender: TObject);
    procedure SaveAs(Sender: TObject);
    procedure Find(Sender: TObject);
    procedure Close(Sender: TObject);
    procedure Task(Sender: TObject);
  private
    HashTable: THashTableGUI;

    function CanCloseFile: boolean;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir:= GetCurrentDir;
  SaveDialog.InitialDir:= GetCurrentDir;
  HashTable:= nil;
  miEdit.Enabled:= false;
  miProcess.Enabled:= false;
  miSave.Enabled:= false;
  miSaveAs.Enabled:= false;
end;

function TFrmMain.CanCloseFile: boolean;
var
  ans: word;
begin
  result:= true;
  if (HashTable <> nil) and (HashTable.Count <> 0) then
    begin
      ans:= MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      case ans of
        mrYes:
          begin
            result:= not HashTable.Modified;
          end;
        mrNo:;
        mrCancel: Result:= false;
      end;
    end;
  if Result then
    FreeAndNil(HashTable);
end;

procedure TFrmMain.New(Sender: TObject);
begin
  miEdit.Enabled:= true;
  if CanCloseFile then
    HashTable:= THashTableGUI.Create(StrGrid);
end;

procedure TFrmMain.Add(Sender: TObject);
var
  newInfo: TInfo;
  addForm: TAddForm;
begin
  addForm:= TAddForm.Create(FrmMain);
  newInfo:= TInfo.CreateEmpty;
  addForm.ShowModal;
  if addForm.Correct then
    begin
      newInfo.Number:= addForm.Number;
      newInfo.Mark:= addForm.Mark;
      newInfo.FIO:= addForm.FIO;
      HashTable.Add(newInfo);
      miProcess.Enabled:= true;
      miSave.Enabled:= true;
      miSaveAs.Enabled:= true;
    end
  else
    ShowMessage('некорректный ввод');
end;

procedure TFrmMain.Delete(Sender: TObject);
var
  wrd: string;
begin
  InputQuery('Ввод данных', 'Введите номер машины', wrd);
  HashTable.Delete(wrd);

end;

procedure TFrmMain.Clear(Sender: TObject);
begin
  HashTable.Clear;
end;

procedure TFrmMain.Save(Sender: TObject);
begin
  if HashTable.FileName<> '' then
    HashTable.SaveToFile(HashTable.FileName)
  else
    ShowMessage('имя файла пусто!');
end;

procedure TFrmMain.Open(Sender: TObject);
begin
  Hashtable:= THashTableGUI.Create(StrGrid);
  if openDialog.Execute then
    begin
      HashTable.LoadFromFile(openDialog.FileName);
      HashTable.FileName:= openDialog.FileName;
      miEdit.Enabled:= true;
      miProcess.Enabled:= true;
      miSave.Enabled:= true;
      miSaveAs.Enabled:= true;
    end;
end;

procedure TFrmMain.SaveAs(Sender: TObject);
begin
  saveDialog.FileName:= HashTable.FileName;
  if saveDialog.Execute then
    HashTable.SaveToFile(saveDialog.FileName);
end;

procedure TFrmMain.Find(Sender: TObject);
var
  key: TKey;
begin
  InputQuery('Ввод данных', 'Введите номер машины', key);
  if HashTable.Find(key) then
    ShowMessage('Элемент найден')
  else
    ShowMessage('Элемент ненайден')
end;

procedure TFrmMain.Close(Sender: TObject);
begin
  CanCloseFile;
end;

procedure TFrmMain.Task(Sender: TObject);
var
  key: TKey;
  a, prev: TIndex;
  form: TAddForm;
begin
  InputQuery('Ввод данных', 'Введите номер машины', key);
  if (HashTable.IndexOf(key, a, prev)) then
    begin
      form:= AddForm.CreateShow(FrmMain, HashTable.Table[a].info);
      form.ShowModal;
    end
  else
    ShowMessage('Информация о владельце машины не найдена');
end;

end.
