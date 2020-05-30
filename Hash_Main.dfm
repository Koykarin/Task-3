object FrmMain: TFrmMain
  Left = 648
  Top = 249
  Align = alCustom
  BorderStyle = bsSingle
  Caption = 'Hash'
  ClientHeight = 314
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StrGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 359
    Height = 314
    Align = alClient
    ColCount = 3
    DefaultColWidth = 110
    DefaultRowHeight = 25
    FixedCols = 0
    ScrollBars = ssNone
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Top = 280
    object mnifile: TMenuItem
      Caption = 'file'
      object miNew: TMenuItem
        Caption = 'new'
        ImageIndex = 0
        OnClick = New
      end
      object miOpen: TMenuItem
        Caption = 'open'
        ImageIndex = 1
        OnClick = Open
      end
      object miSave: TMenuItem
        Caption = 'save'
        ImageIndex = 2
        OnClick = Save
      end
      object miSaveAs: TMenuItem
        Caption = 'saveAs'
        OnClick = SaveAs
      end
      object miClose: TMenuItem
        Caption = 'close'
        OnClick = Close
      end
    end
    object miEdit: TMenuItem
      Caption = 'edit'
      object miAdd: TMenuItem
        Caption = 'add'
        ImageIndex = 6
        OnClick = Add
      end
      object miFind: TMenuItem
        Caption = 'find'
        OnClick = Find
      end
      object miDel: TMenuItem
        Caption = 'delete'
        ImageIndex = 5
        OnClick = Delete
      end
      object miClear: TMenuItem
        Caption = 'clear'
        ImageIndex = 3
        OnClick = Clear
      end
    end
    object miProcess: TMenuItem
      Caption = 'process'
      object miTask: TMenuItem
        Caption = 'task'
        ImageIndex = 7
        OnClick = Task
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Text files (*.txt)|*.txt|All files (*.txt)|*.*'
    Left = 32
    Top = 280
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.txt|All files (*.txt)|*.*'
    Left = 64
    Top = 280
  end
end
