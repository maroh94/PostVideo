object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 388
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    718
    388)
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 361
    Width = 63
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Ger'#228'tename:'
    ExplicitTop = 308
  end
  object Button1: TButton
    Left = 603
    Top = 356
    Width = 103
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Aufnahme starten'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 5
    Top = 5
    Width = 708
    Height = 342
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clGreen
    ParentBackground = False
    TabOrder = 1
    OnResize = Panel1Resize
  end
end
