unit Preview;
interface
uses
  {WinApi}
  WinApi.Windows,
  WinApi.Messages,
  {System}
  System.Classes,
  System.SysUtils,
  System.SyncObjs,
  {MediaFoundationApi}
  {Project}
  Api, ApiObjects, //PreviewApi, PreviewApiEx,
  WinApi.MediaFoundationApi.MfPlay,
  WinApi.WinApiTypes;
//  Device,
//  VideoBufferLock;
  {$MINENUMSIZE 4}
  {$IFDEF WIN32}
    {$ALIGN 1}
  {$ELSE}
    {$ALIGN 8} // Win64
  {$ENDIF}
const
  WM_APP_PREVIEW_ERROR = WM_APP + 1;    // wparam = HRESULT
  WM_APP_DRAWDEV_RESTORE = WM_APP + 2;
type
  //
  // ChooseDeviceParam structure
  //
  // Holds an array of IMFActivate pointers that represent video
  // capture devices.
  //
  ChooseDeviceParam = record
    ppDevices: PIMFActivate; // Pointer to array of IMFActivate pointers.
    count: UINT32;           // Number of elements in the array.
    selection: UINT32;       // Selected device, by array index.
    sSelection: LPWSTR;      // Selected device name
  end;
  // request commands for a-syncrone handling
  TRequest = (reqNone, reqResize, reqSample);

  PPreview = ^tPreview;
  tPreview = Class(TInterfacedObject, IMFPMediaPlayerCallback)
    m_nRefCount:  Long;
    m_pPlayer:    IMFPMediaPlayer;
    m_pSource:    IMFMediaSource;
    m_hwnd:       HWND;
    m_bHasVideo: Boolean;
    m_pwszSymbolicLink: char;
    m_cchSymbolicLink: UINT32;
    m_WindowWidth:Integer;
    m_WindowHigh:Integer;


    private

    public

    function SetDevice(pActivate: IMFActivate): HRESULT;
    function CloseDevice: HResult;
    function UpdateVideo: HResult;

    procedure setSize(aWidth: Integer; aHigh: Integer);

    procedure OnMediaPlayerEvent(var pEventHeader: MFP_EVENT_HEADER); stdcall;
    constructor create(aHandle: HWND); reintroduce;

    property hasVideo: Boolean read m_bhasVideo;
    property Handle: HWND read m_hwnd write m_hwnd;
    property Source: IMFMediaSource read m_pSource;
    protected
    procedure OnMediaItemCreated(pEvent: MFP_MEDIAITEM_CREATED_EVENT);
    procedure OnMediaItemSet(pEvent: MFP_MEDIAITEM_SET_EVENT);
  End;


implementation

uses
  ActiveX;

{tPreview}


constructor tPreview.create(aHandle: HWND);
begin
    inherited create;
    m_hwnd := aHandle;

end;

function tPreview.SetDevice(pActivate: IMFActivate ): HRESULT;
var
  HR: HResult;
  pSource: IMFMediaSource;
  tempLink: LPWSTR;
begin
    hr := S_OK;

    pSource := NIL;

    // Release the current instance of the player (if any).
    CloseDevice();

    // Create a new instance of the player.
    hr := MFPCreateMediaPlayer(
        NIL,   // URL
        FALSE,
        0,      // Options
        self,   // Callback
        m_hwnd,
        &m_pPlayer
        );

    // Create the media source for the device.
    if (SUCCEEDED(hr)) then
        hr := pActivate.ActivateObject(IID_IMFMediaSource, Pointer(pSource));       //??

    // Get the symbolic link. This is needed to handle device-
    // loss notifications. (See CheckDeviceLost.)


    tempLink := LPWSTR(m_pwszSymbolicLink);

    if (SUCCEEDED(hr)) then
        hr := pActivate.GetAllocatedString(
            MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_SYMBOLIC_LINK,
            TempLink,
            m_cchSymbolicLink
            );

    m_pwszSymbolicLink := char(TempLink);

    // Create a new media item for this media source.
    if (SUCCEEDED(hr))then
        hr := m_pPlayer.CreateMediaItemFromObject(
            pSource,
            FALSE,  // FALSE = asynchronous call
            0,
            NIL
            );

    // When the method completes, MFPlay will call OnMediaPlayerEvent
    // with the MFP_EVENT_TYPE_MEDIAITEM_CREATED event.

    if(SUCCEEDED(hr))then
      m_pSource := pSource;

    if (FAILED(hr)) then
      CloseDevice;

    if Assigned(pSource) then
        pSource:= Nil;
    result:= hr;

end;


function tPreview.CloseDevice: HRESULT;
var
  HR : HResult;
begin
    hr := S_OK;

    if Assigned(m_pPlayer)then
    begin
        m_pPlayer.Shutdown();
//        m_pPlayer.Free;
        m_pPlayer := NIL;
    end;

    if Assigned(m_pSource)then
    begin
        m_pSource.Shutdown();
//        m_pSource.Release();
        m_pSource := NIL;
    end;

    m_bHasVideo := FALSE;

    CoTaskMemFree(Pointer(m_pwszSymbolicLink));
//    m_pwszSymbolicLink := Nil;

    m_cchSymbolicLink := 0;

    result := hr;
end;

function tPreview.UpdateVideo: HRESULT;
var
  hr: Hresult;
begin
    hr := S_OK;

    if Assigned(m_pPlayer) then
        hr := m_pPlayer.UpdateVideo();

    result := hr;
end;


procedure tPreview.setSize(aWidth: Integer; aHigh: Integer);
begin
  m_WindowWidth:= aWidth;
  m_WindowHigh := aHigh;
end;


procedure tPreview.OnMediaPlayerEvent(var pEventHeader: MFP_EVENT_HEADER);
begin
  if Failed(pEventHeader.hrEvent) then
    exit;

  if pEventHeader.eEventType = MFP_EVENT_TYPE_MEDIAITEM_CREATED then
    OnMediaItemCreated(MFP_GET_MEDIAITEM_CREATED_EVENT(@pEventHeader)^)
  else if pEventHeader.eEventType = MFP_EVENT_TYPE_MEDIAITEM_SET then
    OnMediaItemSet(MFP_GET_MEDIAITEM_SET_EVENT(@pEventHeader)^);
end;


procedure tPreview.OnMediaItemCreated(pEvent: MFP_MEDIAITEM_CREATED_EVENT);
var
Hr: HResult;
bHasVideo: Bool;
bIsSelected: Bool;
begin
   hr := S_OK;

    if Assigned(m_pPlayer) then
      begin
        bHasVideo := FALSE;
        bIsSelected := FALSE;

        hr := pEvent.pMediaItem.HasVideo(bhasVideo,bisSelected);

        if (SUCCEEDED(hr)) then
        begin
            m_bHasVideo := bHasVideo and bIsSelected;

            // Set this media item on the player.
            Hr := m_pPlayer.SetMediaItem(pEvent.pMediaItem);
        end;
      end;

//    if (FAILED(hr))
//        ShowErrorMessage(NULL, L"Preview error.", hr);

end;


procedure tPreview.OnMediaItemSet(pEvent: MFP_MEDIAITEM_SET_EVENT);
var
  hr: HResult;
  rc: tRect;
begin
    hr := S_OK;

    if (SUCCEEDED(hr)) then
     begin
        SetRect(&rc, 0, 0, m_WindowWidth,m_WindowHigh);

        AdjustWindowRect(
            &rc,
            GetWindowLong(m_hwnd, GWL_STYLE),
            TRUE
            );

        SetWindowPos(m_hwnd, 0, 0, 0, rc.right - rc.left, rc.bottom - rc.top,
            SWP_NOZORDER or SWP_NOMOVE or SWP_NOOWNERZORDER);

        hr := m_pPlayer.Play();
    end;

//    if (FAILED(hr))
//        ShowErrorMessage(NULL, L"Preview error.", hr);
end;

end.
