unit Unit1;
interface
uses
  api, ApiObjects, Preview,
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, hyiedefs,
  hyieutils, iexBitmaps, iesettings, iexLayers, iexRulers, iexToolbars,
  iexUserInteractions;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    CapInterface: tCaptureInterface;
    hDlg: HWND;
    g_hdevnotify: HDEVNOTIFY;
    g_pPreview: tPreview;
    sActiveDeviceFriendlyName: string;
//    bDeviceLost: Boolean;
//    DeviceList: TDeviceList;
    //Preview
    procedure OnDeviceChange(var AMessage: TMessage); message WM_DEVICECHANGE;
    procedure ChooseDevice;
    procedure UpdateCtrls;

  protected
  public
    { Public-Deklarationen }
  end;
var
  Form1: TForm1;
var
  InputIdx: Integer = 0;
implementation
{$R *.dfm}
function __HRESULT_FROM_WIN32(x: DWORD): HResult; inline;
begin
  if HRESULT(x) <= 0 then
    Result := HRESULT(x)
  else
    Result := HRESULT((x and $0000FFFF) OR
                      (FACILITY_WIN32 shl 16) OR
                       $80000000);
end;

function HRESULT_FROM_WIN32(x: DWORD): HRESULT; inline;
begin
  Result := __HRESULT_FROM_WIN32(x);
end;



procedure tForm1.OnDeviceChange(var AMessage: TMessage);
begin
  CapInterface.ChangeDevice(aMessage);
end;


procedure TForm1.Panel1Resize(Sender: TObject);
begin
    if Assigned(g_pPreview) then
      g_pPreview.UpdateVideo;
end;





procedure TForm1.FormCreate(Sender: TObject);
var
Handle: HWND;
begin
  Handle := AllocateHwnd(OnDeviceChange);
  CapInterface := tCaptureInterface.create(Handle);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ChooseDevice;
end;

procedure tForm1.UpdateCtrls;
begin
//
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
var
  hr: HResult;
begin
 if (CapInterface.CountDevices = 0) then
    begin
      Button1.Caption := 'Aufnahme starten';
        Exit;
    end;
  if not CapInterface.Capture then
    begin
      CapInterface.StartCaptureVid(hDlg);
      Button1.Caption := 'Aufnahme stoppen';
      CapInterface.Capture := True;
      Exit;
    end;
  if CapInterface.Capture then
    begin
        begin
          CapInterface.StopCaptureVid();
          Button1.Caption := 'Aufnahme starten';
          CapInterface.Capture := False;
          Exit;
        end
    end;
  if CapInterface.DeviceLost then
    begin
      if MessageDlg('Capture device ' + sActiveDeviceFriendlyName + ' is removed or lost.'  + #13 +
                    'There are IntToStr(DeviceList.Count) available capturedevices on this system' + #13 + #13 +
                    'Close the application?',
                    mtWarning,
                    mbYesNo,
                    0) = mrNo then
        begin
          Button1.Caption := 'Start Capture';
          CapInterface.DeviceLost := False;
        end
      else
        Close();
    end;
end;
end;



procedure tForm1.ChooseDevice;
var
  hr: HRESULT;
  param: ChooseDeviceParam;
  pAttributes: IMFAttributes;
  iDevice: UINT;
  i,r : Integer;

begin
    hr := S_OK;

    pAttributes := NIL;

    if Assigned(g_pPreview) then
      g_pPreview.CloseDevice();

    g_pPreview := tPreview.Create(Panel1.Handle);
    g_pPreview.setSize(Panel1.Width, Panel1.Height-20);

    if (SUCCEEDED(hr)) then
       hr := MFCreateAttributes(&pAttributes, 1);

    if (SUCCEEDED(hr)) then
        hr := pAttributes.SetGUID(
            MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE,
            MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_GUID
            );

    if (SUCCEEDED(hr)) then
      hr := MFEnumDeviceSources(pAttributes, param.ppDevices, Integer(param.count));

    CapInterface.GetSelectedDevice(param.ppDevices^);
    hr := g_pPreview.SetDevice(param.ppDevices^);

    pAttributes := NIL;
end;




end.
