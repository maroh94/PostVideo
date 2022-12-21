unit PreviewApiEx;

interface

uses
  WinApi.ActiveX, Winapi.Windows, System.Types,
  PreviewApi, ApiObjects;

type
  PFLOAT = PSingle;
  FLOAT = Single;
  MFP_MEDIAITEM_CHARACTERISTICS = UINT32;
  MFP_CREATION_OPTIONS = UINT32;

  PMFVideoNormalizedRect = PRectF;
  MFVideoNormalizedRect  = TRectF;


  PIMFPMediaPlayer = ^IMFPMediaPlayer;
  IMFPMediaPlayer = interface;

    PIMFPMediaItem = ^IMFPMediaItem;
  IMFPMediaItem = interface;

  PIMFPMediaPlayerCallback = ^IMFPMediaPlayerCallback;
  IMFPMediaPlayerCallback = interface;

  PMFP_EVENT_TYPE = ^MFP_EVENT_TYPE;
  MFP_EVENT_TYPE = (
    MFP_EVENT_TYPE_PLAY                    = 0,
    MFP_EVENT_TYPE_PAUSE                   = 1,
    MFP_EVENT_TYPE_STOP                    = 2,
    MFP_EVENT_TYPE_POSITION_SET            = 3,
    MFP_EVENT_TYPE_RATE_SET                = 4,
    MFP_EVENT_TYPE_MEDIAITEM_CREATED       = 5,
    MFP_EVENT_TYPE_MEDIAITEM_SET           = 6,
    MFP_EVENT_TYPE_FRAME_STEP              = 7,
    MFP_EVENT_TYPE_MEDIAITEM_CLEARED       = 8,
    MFP_EVENT_TYPE_MF                      = 9,
    MFP_EVENT_TYPE_ERROR                   = 10,
    MFP_EVENT_TYPE_PLAYBACK_ENDED          = 11,
    MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL = 12
  );

  PMFP_MEDIAPLAYER_STATE = ^MFP_MEDIAPLAYER_STATE;
  MFP_MEDIAPLAYER_STATE            = (
    MFP_MEDIAPLAYER_STATE_EMPTY    = 0,
    MFP_MEDIAPLAYER_STATE_STOPPED  = $1,
    MFP_MEDIAPLAYER_STATE_PLAYING  = $2,
    MFP_MEDIAPLAYER_STATE_PAUSED   = $3,
    MFP_MEDIAPLAYER_STATE_SHUTDOWN = $4
  );

  MFP_EVENT_HEADER = record
    eEventType: MFP_EVENT_TYPE;
    hrEvent: HResult;
    pMediaPlayer: IMFPMediaPlayer;
    eState: MFP_MEDIAPLAYER_STATE;
    pPropertyStore: IPropertyStore;
  end;

   PMFP_PAUSE_EVENT = ^MFP_PAUSE_EVENT;
  cwMFP_PAUSE_EVENT = record
    header: MFP_EVENT_HEADER;
    pMediaItem: IMFPMediaItem;
  end;
  {$EXTERNALSYM cwMFP_PAUSE_EVENT}
  MFP_PAUSE_EVENT = cwMFP_PAUSE_EVENT;
  {$EXTERNALSYM MFP_PAUSE_EVENT}

    // Interface IMFPMediaPlayer
  // =========================
  {
   NOTE: Deprecated.
   This API may be removed from future releases of Windows (> Windows 7).
   Applications should use the Media Session for playback.
   Contains methods to play media files.
   The MFPlay player object exposes this interface.
   To get a pointer to this interface, call function MFPCreateMediaPlayer.
  }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFPMediaPlayer);'}
  {$EXTERNALSYM IMFPMediaPlayer}
  IMFPMediaPlayer = interface(IUnknown)
	['{A714590A-58AF-430a-85BF-44F5EC838D85}']

    function Play(): HResult; stdcall;

    function Pause(): HResult; stdcall;

    function Stop(): HResult; stdcall;

    function FrameStep(): HResult; stdcall;

    //
    // Position controls
    //

    function SetPosition(guidPositionType: REFGUID;
                         pvPositionValue: PROPVARIANT): HResult; stdcall;

    function GetPosition(guidPositionType: REFGUID;
                         out pvPositionValue: PROPVARIANT): HResult; stdcall;

    function GetDuration(guidPositionType: REFGUID;
                         out pvDurationValue: PROPVARIANT): HResult; stdcall;

    //
    // Rate Control
    //

    function SetRate(flRate: Single): HResult; stdcall;

    function GetRate(out pflRate: Single): HResult; stdcall;

    function GetSupportedRates(fForwardDirection: Boolean;
                               out pflSlowestRate: Single;
                               out pflFastestRate: Single): HResult; stdcall;

    //
    // State
    //

    function GetState(out peState: MFP_MEDIAPLAYER_STATE): HResult; stdcall;

    //
    // Media Item Management
    //

    function CreateMediaItemFromURL(pwszURL: LPCWSTR;
                                    fSync: BOOL;
                                    dwUserData: DWORD_PTR;
                                    ppMediaItem: PIMFPMediaItem): HResult; stdcall;

    function CreateMediaItemFromObject(pIUnknownObj: IUnknown;
                                       fSync: BOOL;
                                       dwUserData: DWORD_PTR;
                                       ppMediaItem: PIMFPMediaItem): HResult; stdcall;

    function SetMediaItem(pIMFPMediaItem: IMFPMediaItem): HResult; stdcall;

    function ClearMediaItem(): HResult; stdcall; // This method is currently not implemented.

    function GetMediaItem(out ppIMFPMediaItem: IMFPMediaItem): HResult; stdcall;

    //
    // Audio controls
    //

    function GetVolume(out pflVolume: FLOAT): HResult; stdcall;

    function SetVolume(const flVolume: FLOAT): HResult; stdcall;

    function GetBalance(out pflBalance: FLOAT): HResult; stdcall;

    function SetBalance(const flBalance: FLOAT): HResult; stdcall;

    function GetMute(out pfMute: BOOL): HResult; stdcall; //  4 bytes, BOOL;

    function SetMute(fMute: BOOL): HResult; stdcall; // 4 bytes, BOOL;

    //
    // Video controls
    //

    function GetNativeVideoSize(out pszVideo: SIZE;
                                out pszARVideo: SIZE): HResult; stdcall;

    function GetIdealVideoSize(out pszMin: SIZE;
                               out pszMax: SIZE): HResult; stdcall;

    function SetVideoSourceRect(pnrcSource: MFVideoNormalizedRect): HResult; stdcall;

    function GetVideoSourceRect(out pnrcSource: MFVideoNormalizedRect): HResult; stdcall;

    function SetAspectRatioMode(dwAspectRatioMode: DWord): HResult; stdcall;

    function GetAspectRatioMode(out pdwAspectRatioMode: DWord): HResult; stdcall;

    function GetVideoWindow(out phwndVideo: HWND): HResult; stdcall;

    function UpdateVideo(): HResult; stdcall;

    function SetBorderColor(const Clr: COLORREF): HResult; stdcall;

    function GetBorderColor(out pClr: COLORREF): HResult; stdcall;

    //
    // Effect Management
    //

    function InsertEffect(pEffect: IUnknown;
                          fOptional: Boolean): HResult; stdcall;

    function RemoveEffect(pEffect: IUnknown): HResult; stdcall;

    function RemoveAllEffects(): HResult; stdcall;

    //
    // Shutdown
    //

    function Shutdown(): HResult; stdcall;

  end;
  IID_IMFPMediaPlayer = IMFPMediaPlayer;

  PMFP_PLAY_EVENT = ^MFP_PLAY_EVENT;
  MFP_PLAY_EVENT = record
    header: MFP_EVENT_HEADER;
    pMediaItem: IMFPMediaItem;
  end;
  {$EXTERNALSYM MFP_PLAY_EVENT}

   IID_IMFPMediaItem = IMFPMediaItem;
  {$EXTERNALSYM IID_IMFPMediaItem}


    // Interface IMFPMediaItem
  // =======================
  {
   NOTE:  Deprecated.
   This API may be removed from future releases of Windows.
   Applications should use the Media Session for playback.
   Represents a media item. A media item is an abstraction for a source of media data,
   such as a video file.
   Use this interface to get information about the source, or to change certain playback settings,
   such as the start and stop times.
   To get a pointer to this interface, call one of the following methods:
      IMFPMediaPlayer.CreateMediaItemFromObject
      IMFPMediaPlayer.CreateMediaItemFromURL
  }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFPMediaItem);'}
  {$EXTERNALSYM IMFPMediaItem}
  IMFPMediaItem = interface(IUnknown)
	['{90EB3E6B-ECBF-45cc-B1DA-C6FE3EA70D57}']

    function GetMediaPlayer(out ppMediaPlayer: IMFPMediaPlayer): HResult; stdcall;

    function GetURL(out ppwszURL: LPWSTR): HResult; stdcall;

    function GetObject(out ppIUnknown: IUnknown): HResult; stdcall;

    function GetUserData(out pdwUserData: DWORD_PTR): HResult; stdcall;

    function SetUserData(const dwUserData: DWORD_PTR): HResult; stdcall;

    function GetStartStopPosition(out pguidStartPositionType: TGuid;
                                  out pvStartValue: PROPVARIANT;
                                  out pguidStopPositionType: TGuid;
                                  out pvStopValue: PROPVARIANT): HResult; stdcall;

    function SetStartStopPosition(pguidStartPositionType: TGuid;
                                  pvStartValue: PROPVARIANT;
                                  pguidStopPositionType: TGuid;
                                  pvStopValue: PROPVARIANT): HResult; stdcall;

    function HasVideo(out pfHasVideo: BOOL;
                      out pfSelected: BOOL): HResult; stdcall;

    function HasAudio(out pfHasAudio: BOOL;
                      out pfSelected: BOOL): HResult; stdcall;

    function IsProtected(out pfProtected: BOOL): HResult; stdcall;

    function GetDuration(guidPositionType: REFGUID;
                         out pvDurationValue: PROPVARIANT): HResult; stdcall;

    function GetNumberOfStreams(out pdwStreamCount: DWord): HResult; stdcall;

    function GetStreamSelection(dwStreamIndex: DWord;
                                out pfEnabled: BOOL): HResult; stdcall;

    function SetStreamSelection(dwStreamIndex: DWord;
                                fEnabled: BOOL): HResult; stdcall;

    function GetStreamAttribute(const dwStreamIndex: DWord;
                                guidMFAttribute: REFGUID;
                                out pvValue: PROPVARIANT): HResult; stdcall;

    function GetPresentationAttribute(const guidMFAttribute: REFGUID;
                                      out pvValue: PROPVARIANT): HResult; stdcall;

    function GetCharacteristics(out pCharacteristics: MFP_MEDIAITEM_CHARACTERISTICS): HResult; stdcall;

    function SetStreamSink(dwStreamIndex: DWord;
                           pMediaSink: IUnknown): HResult; stdcall;

    function GetMetadata(out ppMetadataStore: IPropertyStore): HResult; stdcall;

  end;
  IID_IMFPMediaItem = IMFPMediaItem;
  {$EXTERNALSYM IID_IMFPMediaItem}

  // Interface IMFPMediaPlayerCallback
  // =================================
  {
   NOTE: Deprecated.
   This API may be removed from future releases of Windows (Windows 7).
   Applications should use the Media Session for playback.
   Callback interface for the IMFPMediaPlayer interface.
   To set the callback, pass an IMFPMediaPlayerCallback pointer to the MFPCreateMediaPlayer function in the pCallback parameter.
   The application implements the IMFPMediaPlayerCallback interface.
  }
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFPMediaPlayerCallback);'}
  {$EXTERNALSYM IMFPMediaPlayerCallback}
  IMFPMediaPlayerCallback = interface(IUnknown)
    ['{766C8FFB-5FDB-4fea-A28D-B912996F51BD}']

      procedure OnMediaPlayerEvent(var pEventHeader: MFP_EVENT_HEADER); stdcall;

  end;
  IID_IMFPMediaPlayerCallback = IMFPMediaPlayerCallback;
  {$EXTERNALSYM IID_IMFPMediaPlayerCallback}


  {
   NOTE: Deprecated.
   This API may be removed from future releases of Windows.
   Applications should use the Media Session for playback.
   Creates a new instance of the MFPlay player object.
  }
  function MFPCreateMediaPlayer(const pwszURL: LPCWSTR;
                                fStartPlayback: BOOL;
                                creationOptions: MFP_CREATION_OPTIONS;
                                pCallback: IMFPMediaPlayerCallback;
                                hWnd: HWND;
                                out ppMediaPlayer: IMFPMediaPlayer): HResult; stdcall; deprecated;
  {$EXTERNALSYM MFPCreateMediaPlayer}


  // CONVERTED MACRO'S
  // NOTE: These will be deprecated: See: https://docs.microsoft.com/en-us/windows/win32/api/mfplay/
  //////////////////////////////////////////////////////////////////////////////
  /// <summary>
  ///     Macros to cast a pointer to a MFP_EVENT_HEADER structure into a pointer to a MFP_*_EVENT.
  ///     If the event is not of the correct type, the macro returns a Nil pointer.
  /// </summary>
  function MFP_GET_PLAY_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAY_EVENT;
  {$EXTERNALSYM MFP_GET_PLAY_EVENT}
  function MFP_GET_PAUSE_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PAUSE_EVENT;
  {$EXTERNALSYM MFP_GET_PAUSE_EVENT}
  function MFP_GET_STOP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_STOP_EVENT;
  {$EXTERNALSYM MFP_GET_STOP_EVENT}
  function MFP_GET_POSITION_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_POSITION_SET_EVENT;
  {$EXTERNALSYM MFP_GET_POSITION_SET_EVENT}
  function MFP_GET_RATE_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_RATE_SET_EVENT;
  {$EXTERNALSYM MFP_GET_RATE_SET_EVENT}
  function MFP_GET_MEDIAITEM_CREATED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CREATED_EVENT;
  {$EXTERNALSYM MFP_GET_MEDIAITEM_CREATED_EVENT}
  function MFP_GET_MEDIAITEM_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_SET_EVENT;
  {$EXTERNALSYM MFP_GET_MEDIAITEM_SET_EVENT}
  function MFP_GET_FRAME_STEP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_FRAME_STEP_EVENT;
  {$EXTERNALSYM MFP_GET_FRAME_STEP_EVENT}
  function MFP_GET_MEDIAITEM_CLEARED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CLEARED_EVENT;
  {$EXTERNALSYM MFP_GET_MEDIAITEM_CLEARED_EVENT}
  function MFP_GET_MF_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MF_EVENT;
  {$EXTERNALSYM MFP_GET_MF_EVENT}
  function MFP_GET_ERROR_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ERROR_EVENT;
  {$EXTERNALSYM MFP_GET_ERROR_EVENT}
  function MFP_GET_PLAYBACK_ENDED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAYBACK_ENDED_EVENT;
  {$EXTERNALSYM MFP_GET_PLAYBACK_ENDED_EVENT}
  function MFP_GET_ACQUIRE_USER_CREDENTIAL_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ACQUIRE_USER_CREDENTIAL_EVENT;
  {$EXTERNALSYM MFP_GET_ACQUIRE_USER_CREDENTIAL_EVENT}

  // Additional Prototypes for ALL interfaces

  // End of Additional Prototypes





implementation


end.
