unit Api;
interface
uses
  ApiObjects, WinApi.Messages, Winapi.Windows, WinApi.Winrt, DateUtils,
  Winapi.ActiveX, Classes, SysUtils, Dialogs, Math, Data.Bind.Controls, System.SyncObjs;
type
  TDeviceList = class(TObject)
   private
     m_cDevices: UINT32;
     m_ppDevices: PIMFActivate;
   public
    constructor Create(); overload;
    destructor Destroy(); override;
    procedure Clear();
    function EnumerateDevices(): HResult;
    function GetDevice(index: UINT32;
                       out pActivate: IMFActivate): HResult;
    function GetFriendlyName(index: UINT32;
                             out pszFriendlyName: LPWSTR): HResult;
    function GetENDPOINTID(index: UINT32; out ENDPOINTID : PCWSTR): HResult;
    property Count: UINT32 read m_cDevices;
  end;
  EncodingParameters = record
    subtype: TGUID;
    bitrate: UINT32;
  end;
  tCh4 = array [0..3] of AnsiChar;
  TCallBackState = (STATE_END_OF_STREAM,
                  STATE_END_OF_CLIP,
                  STATE_ABORT,
                  STATE_ERROR
                  );
  TState = (State_NotReady = 0,
          State_Ready,
          State_Capturing,
          State_DeviceLost,
          State_SessionEnded
         );
    TMFCritSec = class
    private
    { private fields }
      FCriticalSection: TRTLCriticalSection;
    public
    { public methods }
      constructor Create();
      destructor Destroy(); override;
      procedure Lock();
      procedure Unlock();
   end;


  TMfCaptureEngine = class(TInterfacedObject, IMFSourceReaderCallback)
  protected
    State: TState;
    m_Source: IMFMediaSource;     //Test
    m_critsec: TCriticalSection;
    m_hwndEvent: HWND;
    m_pReader: IMFSourceReader;
    m_pWriter: IMFSinkWriter;
    m_bFirstSample: Boolean;
    m_llBaseTime: LONGLONG;
    m_DeviceFriendlyName: PWideChar;
    m_DeviceSymbolicLink: PWideChar;
    m_SubTypes: array of TGuid;
    procedure NotifyError(hr: HResult);
    function OpenMediaSource(pSource: IMFMediaSource): HResult;
    function ConfigureCapture(const param: EncodingParameters): HResult;
    procedure SetSubtypes();
  private
    constructor Create(hwWindow: HWND); overload;
    function ConfigureSourceReader(pReader: IMFSourceReader): HResult;
    function ConfigureEncoder(const params: EncodingParameters;
                              pType: IMFMediaType;
                              pWriter: IMFSinkWriter;
                              pdwStreamIndex: DWORD): HResult;
    function CopyAttribute(Src: IMFAttributes;
                           Dest: PIMFAttributes;
                           const key: TGUID): Hresult;
    function OnReadSample(hrStatus: HResult;
                          dwStreamIndex: DWORD;
                          dwStreamFlags: DWORD;
                          llTimestamp: LONGLONG;
                          pSample: IMFSample): HResult; stdcall;
    function OnFlush(dwStreamIndex: DWORD): HResult; stdcall;
    function OnEvent(dwStreamIndex: DWORD;
                     pEvent: IMFMediaEvent): HResult; stdcall;
  public
    destructor Destroy(); override;
    class function CreateInstance(hwWindow: HWND;
                                  out cCaptureEngine: TMfCaptureEngine): HRESULT;
    function StartCapture(pActivate: IMFActivate;
                          const pwszFileName: PWideChar;
                          const param: EncodingParameters): HResult;
    function EndCaptureSession(): HResult;
    function IsCapturing(): TState;
    procedure DeviceLost(bDeviceLost: Boolean);
    property DeviceFriendlyName: PWideChar read m_DeviceFriendlyName;
    property DeviceSymbolicLink: PWideChar read m_DeviceSymbolicLink;
    //test
    property Source: IMFMediaSource read m_Source write M_Source;
end;

  tCaptureInterface = Class
    private
      FFilename: String;
      FDevicename: PWideChar;
      FCaptureEngine: TMfCaptureEngine;
      FCapture: Boolean;
      g_hdevnotify: HDEVNOTIFY;
      sActiveDeviceFriendlyName: string;
      bDeviceLost: Boolean;
      DeviceList: TDeviceList;
      hDlg: HWND;


      function getDeviceCount: Integer;
    public
      constructor create(aHandle : HWND); reintroduce;
      Function startCaptureVid(var aHandle: HWND): HResult;
      function StopCaptureVid(): HResult;
      function UpdateDeviceList(): HResult;
      function getSelectedDevice(out Activate: IMFActivate):Hresult;


      procedure ChangeDevice(var AMessage: TMessage);


      property DeviceLost: Boolean read bDevicelost write bDeviceLost;
      property CountDevices: Integer read getDeviceCount;
      property Capture: Boolean read FCapture write FCapture;
      Property CaptureEngine: TMfCaptureEngine read FCaptureEngine;
      Property Filename: String read FFilename;
      Property Devicename: PWideChar read FDevicename;
    protected
  End;
  
const
  IDD_CHOOSE_DEVICE =              102;
  IDC_DEVICE_LIST   =              1001;
  TARGET_BIT_RATE: UINT32 = (240 * 1000);

  WM_APP_PREVIEW_ERROR = WM_APP + 1;
  WM_CLIPENGINE_MSG    = WM_APP + 111;
  WM_USER_ABORT        = WM_APP + 112;

  PREFIX= 'DrigusRecord';
  const REFTIMES_PER_MILLISEC = 10000;
  const ONE_HNS_MSEC     = REFTIMES_PER_MILLISEC;

implementation
procedure SafeRelease(var IUnk);
begin
  if Assigned(IUnknown(IUnk)) then
    Pointer(IUnknown(IUnk)) := nil;
end;
function InitMF(): HResult;
var
  hr: HResult;
begin
  // Initialize the COM library.
  hr := CoInitializeEx(Nil,
                       COINIT_APARTMENTTHREADED or COINIT_DISABLE_OLE1DDE);

  if FAILED(hr) then
    begin
      MessageBox(0,
                 LPCWSTR('COM library initialisation failure.'),
                 LPCWSTR('COM Failure!'),
                 MB_ICONSTOP);
      Abort();
    end;

  // Intialize the Media Foundation platform and
  // check if the current MF version match user's version
  hr := MFStartup(MF_VERSION);
  if FAILED(hr) then
    begin
      MessageBox(0,
                 LPCWSTR('Your computer does not support this Media Foundation API version' +
                         IntToStr(MF_VERSION) + '.'),
                 LPCWSTR('MFStartup Failure!'),
                 MB_ICONSTOP);
      Abort();
    end;
  Result := hr;
end;
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
function FCC(ch4: TCh4): DWord; inline;
begin
  Result :=  DWord(Ord(ch4[0])) or
             DWord(Ord(ch4[1])) shl 8 or
             DWord(Ord(ch4[2])) shl 16 or
             DWord(Ord(ch4[3])) shl 24;
end;
function HnsTimeToMsec(hnsTime: MFTIME): MFTIME; inline;
begin
  Result := (hnsTime div ONE_HNS_MSEC);
end;

function MFGetAttributeUINT32(pAttributes: IMFAttributes;
                              guidKey: TGUID;
                              unDefault: UINT32): UINT32;
var
  unRet : UINT32;
begin
  unRet := 0;
  if (FAILED(pAttributes.GetUINT32(guidKey,
                                   unRet))) then
      unRet := unDefault;
  Result := unRet;
end;
function CloseMF(): HResult;
begin
  // Shutdown MF
  Result := MFShutdown();
  // Shutdown COM
  CoUninitialize();
end;
constructor TMFCritSec.Create();
begin
  InitializeCriticalSection(FcriticalSection);
end;
destructor TMFCritSec.Destroy();
begin
  DeleteCriticalSection(FcriticalSection);
end;
procedure TMFCritSec.Lock();
begin
  EnterCriticalSection(FcriticalSection);
end;
procedure TMFCritSec.Unlock();
begin
  LeaveCriticalSection(FcriticalSection);
end;
constructor TDeviceList.Create();
begin
  inherited Create();
  m_ppDevices := Nil;
  m_cDevices := 0;
end;
destructor TDeviceList.Destroy();
begin
  Clear();
  SafeRelease(m_ppDevices);
  inherited Destroy();
end;
procedure TDeviceList.Clear();
var
i: Integer;
begin
  if Assigned(m_ppDevices) then
    begin
      for i := 0 to m_cDevices -1 do
//        m_ppDevices[i] := Nil;

      CoTaskMemFree(m_ppDevices);
      m_ppDevices := Nil;
      m_cDevices := 0;
    end;
end;
function TDeviceList.EnumerateDevices(): HResult;
var
  hr: HResult;
  pAttributes: IMFAttributes;
begin
  Clear();                                 //VideoDevices
  hr := MFCreateAttributes(pAttributes, 2);
  if SUCCEEDED(hr) then
    hr := pAttributes.SetGUID(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE,
                              MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_GUID);
  if SUCCEEDED(hr) then
    hr := MFEnumDeviceSources(pAttributes,
                              m_ppDevices,
                              Integer(m_cDevices));
  Result := hr;
end;
function TDeviceList.GetDevice(index: UINT32; out pActivate: IMFActivate): HResult;
begin
  if index >= Count then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;
//pActivate := m_ppDevices[index];
pActivate := m_ppDevices^;
if Assigned(pActivate) then
  Result := S_OK
else
  Result := E_POINTER;
end;
function TDeviceList.GetFriendlyName(index: UINT32; out pszFriendlyName: LPWSTR): HResult;
var
  hr: HResult;
  chLength: UINT32;
begin
  if index >= Count then
    begin
      Result := E_INVALIDARG;
      Exit;
    end;
  hr := m_ppDevices.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_FRIENDLY_NAME,
                                              pszFriendlyName,
                                              chLength);
  Result := hr;
end;

function TDeviceList.GetENDPOINTID(index: UINT32; out ENDPOINTID : PCWSTR): HResult;
var
  hr: HResult;
  chLength: UINT32;
begin
  if index >= Count then
    begin
      Result := E_INVALIDARG;
      Exit;
    end;
  hr := m_ppDevices.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_AUDCAP_ENDPOINT_ID,
                                              ENDPOINTID,
                                              chLength);
  Result := hr;
end;



constructor TMfCaptureEngine.Create(hwWindow: HWND);
begin
  inherited Create();
  m_hwndEvent := hwWindow;
  m_bFirstSample := False;
  m_llBaseTime := 0;
  SetSubTypes();
  m_critsec := TCriticalSection.Create();
end;

destructor TMfCaptureEngine.Destroy();
begin
  if Assigned(m_pReader) then
    SafeRelease(m_pReader);
  if Assigned(m_pWriter) then
    SafeRelease(m_pWriter);
  m_critsec.Destroy();
  inherited Destroy();
end;

procedure TMfCaptureEngine.NotifyError(hr: HResult);
begin
  PostMessage(m_hwndEvent,
              WM_APP_PREVIEW_ERROR,
              WPARAM(hr),
              0);
end;

function TMfCaptureEngine.OpenMediaSource(pSource: IMFMediaSource): HResult;
var
  hr: HResult;
  pAttributes: IMFAttributes;
begin
  hr := MFCreateAttributes(pAttributes, 1);

  if SUCCEEDED(hr) then
    hr := pAttributes.SetUnknown(MF_SOURCE_READER_ASYNC_CALLBACK, Self);
  if SUCCEEDED(hr) then
    hr := MFCreateSourceReaderFromMediaSource(pSource, pAttributes, m_pReader);
  Result := hr;
end;

function TMfCaptureEngine.ConfigureCapture(const param: EncodingParameters): HResult;
var
  hr: HResult;
  sink_stream: DWORD;
  pType: IMFMediaType;

begin
  sink_stream := 0;
  hr := ConfigureSourceReader(m_pReader);
  if SUCCEEDED(hr) then
    hr := m_pReader.GetCurrentMediaType(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                                        pType);
  if SUCCEEDED(hr) then
    hr := ConfigureEncoder(param,
                           pType,
                           m_pWriter,
                           sink_stream);
  if SUCCEEDED(hr) then
    // Register the color converter DSP for this process, in the video
    // processor category. This will enable the sink writer to enumerate
    // the color converter when the sink writer attempts to match the
    // media types.
    hr := MFTRegisterLocalByCLSID(CLSID_CColorConvertDMO,
                                  MFT_CATEGORY_VIDEO_PROCESSOR,
                                  LPCWSTR(''),
                                  MFT_ENUM_FLAG_SYNCMFT,
                                  0,
                                  Nil,
                                  0,
                                  Nil);
  if SUCCEEDED(hr) then
    hr := m_pWriter.SetInputMediaType(sink_stream,
                                      pType,
                                      Nil);
  if SUCCEEDED(hr) then
    hr := m_pWriter.BeginWriting();
  Result := hr;
end;

procedure TMfCaptureEngine.SetSubTypes();
begin
  SetLength(m_SubTypes, 5);
  m_SubTypes[0] := MFVideoFormat_NV12;
  m_SubTypes[1] := MFVideoFormat_YUY2;
  m_SubTypes[2] := MFVideoFormat_UYVY;
  m_SubTypes[3] := MFVideoFormat_RGB32;
  m_SubTypes[4] := MFVideoFormat_RGB24;
end;

function TMfCaptureEngine.ConfigureSourceReader(pReader: IMFSourceReader): HResult;
var
  hr: HResult;
  bUseNativeType: Boolean;
  pType: IMFMediaType;
  subtype: TGUID;
  i: Integer;
label
  done;
begin
  bUseNativeType := False;
  // If the source's native format matches any of the formats in
  // the list, prefer the native format.
  // Note: The camera might support multiple output formats,
  // including a range of frame dimensions. The application could
  // provide a list to the user and have the user select the
  // camera's output format. That is outside the scope of this
  // sample, however.
  hr := pReader.GetNativeMediaType(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                                   0,  // Type index
                                   pType);
  if FAILED(hr) then
    goto done;
  hr := pType.GetGUID(MF_MT_SUBTYPE,
                      subtype);
  if FAILED(hr) then
    goto done;
  for i := 0 to length(m_SubTypes) do
    begin
      if (subtype = m_SubTypes[i]) then
        begin
          hr := pReader.SetCurrentMediaType(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                                            0,
                                            pType);
          bUseNativeType := True;
          break;
        end;
    end;
  if not bUseNativeType then
    begin
      // None of the native types worked. The camera might offer
      // output a compressed type such as MJPEG or DV.
      // Try adding a decoder.
      for i := 0 to Length(m_SubTypes) -1 do
        begin
          hr := pType.SetGUID(MF_MT_SUBTYPE,
                              m_SubTypes[i]);
          if FAILED(hr) then
            goto done;
          hr := pReader.SetCurrentMediaType(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                                            0,
                                            pType);
{$IF DEBUG}
    if hr = $C00D5212 then
      OutputDebugString(PChar('No suitable transform was found to encode or decode the content.'));
{$ENDIF}
          if SUCCEEDED(hr) then
            break;
        end;
    end;
done:
  Result := hr;
end;

function TMfCaptureEngine.ConfigureEncoder(const params: EncodingParameters;
                                           pType: IMFMediaType;
                                           pWriter: IMFSinkWriter;
                                           pdwStreamIndex: DWORD): HResult;
var
  hr: HResult;
  pType2: IMFMediaType;
begin
  hr := MFCreateMediaType(pType2);
  if SUCCEEDED(hr) then
    hr := pType2.SetGUID(MF_MT_MAJOR_TYPE,
                         MFMediaType_Video );
  if SUCCEEDED(hr) then
    hr := pType2.SetGUID(MF_MT_SUBTYPE,
                         params.subtype);
  if SUCCEEDED(hr) then
    hr := pType2.SetUINT32(MF_MT_AVG_BITRATE,
                           params.bitrate);
  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        @pType2,
                        MF_MT_FRAME_SIZE);
  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        @pType2,
                        MF_MT_FRAME_RATE);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        @pType2,
                        MF_MT_PIXEL_ASPECT_RATIO);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        @pType2,
                        MF_MT_INTERLACE_MODE);
  if SUCCEEDED(hr) then
    hr := pWriter.AddStream(pType2,
                            pdwStreamIndex);
  // SafeRelease(pType2); will be done by compiler
  Result := hr;
end;

function TMfCaptureEngine.CopyAttribute(Src: IMFAttributes;
                                        Dest: PIMFAttributes;
                                        const key: TGUID): Hresult;
var
  hr: HResult;
  propvar: PROPVARIANT;
begin
  PropVariantInit(propvar);
  hr := Src.GetItem(key,
                    propvar);
  if SUCCEEDED(hr) then
    hr := Dest.SetItem(key,
                       propvar);
  PropVariantClear(propvar);
  Result := hr;
end;

class function TMfCaptureEngine.CreateInstance(hwWindow: HWND; {Handle to the window to receive events}
                                               out cCaptureEngine: TMfCaptureEngine {Receives a pointer to the CCapture object.}): HRESULT;
var
  pCaptureEngine: TMfCaptureEngine;
begin
  pCaptureEngine := TMfCaptureEngine.Create(hwWindow);
  if not Assigned(PCaptureEngine) then
    begin
      Result := E_OUTOFMEMORY;
      Exit;
    end;
  cCaptureEngine := pCaptureEngine;
  Result := S_OK;
end;

function TMfCaptureEngine.StartCapture(pActivate: IMFActivate;
                                       const pwszFileName: PWideChar;
                                       const param: EncodingParameters): HResult;
var
  hr: HResult;
  pSource: IMFMediaSource;
  chLength: UINT32;
begin
  m_critsec.Enter;
  // Create the media source for the device.
  hr := pActivate.ActivateObject(IID_IMFMediaSource,
                                 Pointer(pSource));
  // Get the friendly name and symbolic link. This is needed to handle device-
  // loss notifications. (See CheckDeviceLost.)
  if SUCCEEDED(hr) then
    hr := pActivate.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_FRIENDLY_NAME,
                                       m_DeviceFriendlyName,
                                       chLength);
  if SUCCEEDED(hr) then
    hr := pActivate.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_SYMBOLIC_LINK,
                                       m_DeviceSymbolicLink,
                                       chLength);
  if SUCCEEDED(hr) then
    hr := OpenMediaSource(pSource);
//    hr := OpenMediaSource(Source);
//    pSource := M_Source;
  // Create the sink writer
  if SUCCEEDED(hr) then
    hr := MFCreateSinkWriterFromURL(pwszFileName,
                                    Nil,
                                    Nil,
                                    m_pWriter);
  // Set up the encoding parameters.
  if SUCCEEDED(hr) then
    hr := ConfigureCapture(param);
  if SUCCEEDED(hr) then
    begin
      m_bFirstSample := TRUE;
      m_llBaseTime := 0;
      // Request the first video frame.
      hr := m_pReader.ReadSample(MF_SOURCE_READER_FIRST_VIDEO_STREAM, 0);
    end;
  if SUCCEEDED(hr) then
    State := State_Capturing
  else
    State := State_NotReady;
  m_critsec.Leave;
  Result := hr;
end;

function TMfCaptureEngine.EndCaptureSession(): HResult;
var
  hr: HResult;
begin
  m_critsec.Enter;
  hr := S_OK;
  if Assigned(m_pWriter) then
    hr := m_pWriter.Finalize();
  SafeRelease(m_pWriter);
  SafeRelease(m_pReader);
  CoTaskMemFree(m_DeviceFriendlyName);
  m_DeviceFriendlyName := Nil;
  CoTaskMemFree(m_DeviceSymbolicLink);
  m_DeviceSymbolicLink := Nil;
  State := State_NotReady;
  m_critsec.Leave;
  Result := hr;
end;

function TMfCaptureEngine.IsCapturing(): TState;
var
  bIsCapturing: Boolean;
begin
  m_critsec.Enter;
  bIsCapturing := (m_pWriter <> Nil);
  if bIsCapturing then
    State := State_Capturing
  else
    State := State_NotReady;
  m_critsec.Leave;
  Result := State;
end;

procedure TMfCaptureEngine.DeviceLost(bDeviceLost: Boolean);
begin
  if bDeviceLost then
    State := State_DeviceLost;
end;

//Events

function TMfCaptureEngine.OnReadSample(hrStatus: HResult;
                                       dwStreamIndex: DWORD;
                                       dwStreamFlags: DWORD;
                                       llTimeStamp: LONGLONG;
                                       pSample: IMFSample): HResult; stdcall;
var
  hr: HResult;
label
  done;
begin
  m_critsec.Enter;
  if (IsCapturing() <> State_Capturing) then
    begin
      m_critsec.Leave;
      Result := S_OK;
      Exit;
    end;
  if FAILED(hrStatus) then
    begin
      hr := hrStatus;
      goto done;
    end;
  if Assigned(pSample) then
    begin
      if m_bFirstSample then
        begin
          m_llBaseTime := llTimeStamp;
          m_bFirstSample := False;
        end;
      // rebase the time stamp
      dec(llTimeStamp,
          m_llBaseTime);
      hr := pSample.SetSampleTime(llTimeStamp);
      if FAILED(hr) then
        goto done;
      hr := m_pWriter.WriteSample(0,
                                  pSample);
      if FAILED(hr) then
        goto done;
    end;
  // Read another sample.
  hr := m_pReader.ReadSample(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                             0);
done:
  if FAILED(hr) then
    NotifyError(hr);
  m_critsec.Leave;
  Result := hr;
end;

function TMfCaptureEngine.OnFlush(dwStreamIndex: DWORD): HResult; stdcall;
begin
  Result := S_OK;
end;
function TMfCaptureEngine.OnEvent(dwStreamIndex: DWORD;
                                  pEvent: IMFMediaEvent): HResult; stdcall;
begin
  Result := S_OK;
end;


constructor tCaptureInterface.create(aHandle : HWND);
var
  hr: HResult;
  devbroadcastdevice: DEV_BROADCAST_DEVICEINTERFACE;
  iSize: Integer;
begin
  iSize := SizeOf(DEV_BROADCAST_DEVICEINTERFACE);
  ZeroMemory(@devbroadcastdevice, iSize);
  sActiveDeviceFriendlyName := 'Unknown';
  hDlg := aHandle;
  DeviceList := TDeviceList.Create;

  hr := CoInitializeEx(Nil,
                       COINIT_APARTMENTTHREADED or
                       COINIT_DISABLE_OLE1DDE);

  if SUCCEEDED(hr) then
    hr := MFStartup();

  if SUCCEEDED(hr) then
    begin
      devbroadcastdevice.dbcc_size := iSize;
      devbroadcastdevice.dbcc_devicetype := DBT_DEVTYP_DEVICEINTERFACE;
      devbroadcastdevice.dbcc_reserved := 0;
      devbroadcastdevice.dbcc_classguid := KSCATEGORY_VIDEO_CAMERA;
      devbroadcastdevice.dbcc_name := #0;
      g_hdevnotify := RegisterDeviceNotification(hDlg,
                                                 @devbroadcastdevice,
                                                 DEVICE_NOTIFY_WINDOW_HANDLE);
      if not Assigned(g_hdevnotify) then
        hr := HRESULT_FROM_WIN32(GetLastError());
    end;

  if SUCCEEDED(hr) then
    hr := UpdateDeviceList();

  if Failed(hr) then
    begin
      MessageBox(hDlg,
                 LPCWSTR('Could not find a video capture device.'),
                 LPCWSTR('No device found'),
                 MB_OK);
    //  Close();
    end;

end;

function tCaptureInterface.StartCaptureVid(var aHandle: HWND): HResult;
var
  params: EncodingParameters;
  hr: HResult;
  pActivate: IMFActivate;
  szFile: String;
begin
  params.subtype := MFVideoFormat_WMV3;     //Video
  params.bitrate := TARGET_BIT_RATE;
  szFile := PREFIX + IntToStr(DateTimeToFileDate(now));
  if not Promptforfilename(szFile,'*.wmv|*.wmv','wmv','','',true)then
    exit;
  if Length(szFile) > 0 then
    hr := S_OK
  else
    begin
      hr := ERROR_INVALID_NAME;
      Exit;
    end;

  if SUCCEEDED(hr) then
    hr := GetSelectedDevice(pActivate);

  if SUCCEEDED(hr) then
    hr := TMfCaptureEngine.CreateInstance(aHandle, FCaptureEngine);
  if SUCCEEDED(hr) then
    hr := CaptureEngine.StartCapture(pActivate, PWideChar(szFile), params);
  if SUCCEEDED(hr) then
    sActiveDeviceFriendlyName := WideCharToString(CaptureEngine.DeviceFriendlyName);
   Result := hr;
end;

procedure tCaptureInterface.ChangeDevice(var AMessage: TMessage);
var
  PDevBroadcastHeader: PDEV_BROADCAST_HDR;
  pDevBroadCastIntf: PDEV_BROADCAST_DEVICEINTERFACE;
  pwDevSymbolicLink: PWideChar;
  hr: HResult;
begin
  if AMessage.WParam = DBT_DEVICEREMOVECOMPLETE then
    begin

      UpdateDeviceList();

      if PDEV_BROADCAST_HDR(AMessage.LParam).dbch_devicetype <> DBT_DEVTYP_DEVICEINTERFACE then
        Exit;

      PDevBroadcastHeader := PDEV_BROADCAST_HDR(AMessage.LParam);
      pDevBroadCastIntf := PDEV_BROADCAST_DEVICEINTERFACE(PDevBroadcastHeader);

      pwDevSymbolicLink := PChar(@pDevBroadCastIntf^.dbcc_name);
      hr := S_OK;
      bDeviceLost := False;
      if Assigned(CaptureEngine) then
        if CaptureEngine.IsCapturing() = State_Capturing then
          begin
            if StrIComp(PWideChar(CaptureEngine.DeviceSymbolicLink),
                        PWideChar(pwDevSymbolicLink)) = 0 then
              bDeviceLost := True;
            if FAILED(hr) or bDeviceLost then
              StopCaptureVid();
          end;
    end;
end;

function tCaptureInterface.StopCaptureVid(): HResult;
var
  hr: HResult;
begin
  hr := CaptureEngine.EndCaptureSession();

  UpdateDeviceList();
  Result := hr
end;

function TCaptureInterface.UpdateDeviceList(): HResult;
var
  hr: HResult;
  szFiendlyName: PWideChar;
  iDevice: UINT32;
begin
  if not Assigned(DeviceList) then
    begin
      hr := E_POINTER;
      exit;
    end;

  hr := DeviceList.EnumerateDevices();
  if FAILED(hr) then
    exit;
  for iDevice := 0 to DeviceList.Count-1 do
    begin
      // Get the fiendly name of the device.
      hr := DeviceList.GetFriendlyName(iDevice,
                                       szFiendlyName);
      if FAILED(hr) then
        exit;

      szFiendlyName := Nil;
    if (DeviceList.Count > 0) then
      begin
        // Select the first item.
//        cbDeviceList.ItemIndex := 0;
      end
    else
      hr := ERROR_SYSTEM_DEVICE_NOT_FOUND;
    end;
  Result := hr;
end;

function tCaptureInterface.GetSelectedDevice(out Activate: IMFActivate): HResult;
var
  iListIndex: Integer;
  hr : HResult;
begin
  iListIndex := 0; //cbDeviceList.ItemIndex;
  DeviceList.GetFriendlyName(0,FDevicename);

  if (iListIndex = CB_ERR) then
    begin
      hr := HRESULT_FROM_WIN32(GetLastError());
      Result := HR;
      exit;
    end;

  hr := DeviceList.GetDevice(iListIndex, Activate);
  Result := hr;
end;

function tCaptureInterface.getDeviceCount: Integer;
begin
  if Assigned(DeviceList) then
    result := DeviceList.Count
  else
    Result := -1;
end;


end.
