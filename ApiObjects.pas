unit ApiObjects;
interface
uses
  IdGlobal, IdCTypes, SysUtils,
  Win.ComConst, Winapi.ActiveX, WinApi.DirectDraw, WinApi.Windows;
  const
   MF_API_VERSION                      = $0070;  // This value is unused in the Win7 release and left at its Vista release value
   MFSTARTUP_FULL                      = 0; // Default value
type
  EOleError = class(Exception);

  EOleSysError = class(EOleError)
  private
    FErrorCode: HRESULT;
  public
    constructor Create(const Message: UnicodeString; ErrorCode: HRESULT;
      HelpContext: Integer);
    property ErrorCode: HRESULT read FErrorCode write FErrorCode;
  end;

  REFPROPVARIANT = ^tagPROPVARIANT;
  _MFT_ENUM_FLAG = UINT32;
  MFT_ENUM_FLAG = _MFT_ENUM_FLAG;
  IID = TGUID;
  REFIID = IID;
  MediaEventType = DWord;
  PLONGLONG = ^LONGLONG;
  REFCLSID = IID;
  RefGuid = TGuid;
  MFTIME = System.UInt64;
  MF_SOURCE_READER_FLAG = DWord;
  FOURCC = DWORD;
  _HRESULT_TYPEDEF_                     = LongInt;
  TOPOID = System.Uint64;
  PTOPOID = ^TOPOID;
  PMFSESSION_SETTOPOLOGY_FLAGS = ^MFSESSION_SETTOPOLOGY_FLAGS;
  MFSESSION_SETTOPOLOGY_FLAGS = DWord;
  __MIDL___MIDL_itf_mfidl_0000_0001_0001 = DWord;
  MF_RESOLUTION = __MIDL___MIDL_itf_mfidl_0000_0001_0001;

  IMFTopology = interface;
  IMFTopologyNode = interface;
  IMFStreamSink = interface;
    _MFCLOCK_STATE          = (
    MFCLOCK_STATE_INVALID = 0,
    MFCLOCK_STATE_RUNNING = (MFCLOCK_STATE_INVALID + 1),
    MFCLOCK_STATE_STOPPED = (MFCLOCK_STATE_RUNNING + 1),
    MFCLOCK_STATE_PAUSED  = (MFCLOCK_STATE_STOPPED + 1)
  );
  MFCLOCK_STATE = _MFCLOCK_STATE;
    TMediaTypes = (mtDefault,                   // Default stream.
                 mtAudio,                     // Audio stream.
                 mtVideo,                     // Video stream.
                 mtProtectedMedia,            // Protected media.
                 mtSAMI,                      // Synchronized Accessible Media Interchange (SAMI) captions (subtitling).
                 mtScript,                    // Script stream.
                 mtStillImage,                // Still image stream.
                 mtHTML,                      // HTML stream.
                 mtBinary,                    // Binary stream.
                 mtFileTransfer,              // A stream that contains data files.
                 mtStream,                    // Multiplexed stream or elementary stream.
                 mtMultiplexedFrames,         // Multiplexed frames stream.
                 mtSubTitle,                  // Subtitle stream.
                 mtPerception,                // Streams from a camera sensor or processing unit that reasons and understands raw video data and provides understanding of the environment or humans in it.
                 mtUnknown                    // Unknown stream type.
                );

  PDEV_BROADCAST_DEVICEINTERFACE_W = ^_DEV_BROADCAST_DEVICEINTERFACE_W;
  _DEV_BROADCAST_DEVICEINTERFACE_W = record
    dbcc_size       : DWORD;  // size of dbcc_name including terminating #0
    dbcc_devicetype : DWORD;  // = DBT_DEVTYP_DEVICEINTERFACE
    dbcc_reserved   : DWORD;
    dbcc_classguid  : TGUID;
    dbcc_name       : array [0..0] of WideChar;
  end;
  DEV_BROADCAST_DEVICEINTERFACE_W = _DEV_BROADCAST_DEVICEINTERFACE_W;
  DEV_BROADCAST_DEVICEINTERFACE = DEV_BROADCAST_DEVICEINTERFACE_W;
    PMF_TOPOLOGY_TYPE = ^MF_TOPOLOGY_TYPE;
  MF_TOPOLOGY_TYPE                = (
    MF_TOPOLOGY_OUTPUT_NODE       = 0,   // Output node. Represents a media sink in the topology.
    MF_TOPOLOGY_SOURCESTREAM_NODE = (MF_TOPOLOGY_OUTPUT_NODE + 1), // Source node. Represents a media stream in the topology.
    MF_TOPOLOGY_TRANSFORM_NODE    = (MF_TOPOLOGY_SOURCESTREAM_NODE + 1), // Transform node. Represents a Media Foundation Transform (MFT) in the topology.
    MF_TOPOLOGY_TEE_NODE          = (MF_TOPOLOGY_TRANSFORM_NODE + 1), // Tee node.
                                                                      // A tee node does not hold a pointer to an object.
                                                                      // Instead, it represents a fork in the stream.
                                                                      // A tee node has one input and multiple outputs,
                                                                      // and samples from the upstream node are delivered to
                                                                      // all of the downstream nodes.
    MF_TOPOLOGY_MAX               = MAXDWORD // $ffffffff   Reserved.
  );

  PMF_ATTRIBUTE_TYPE = ^_MF_ATTRIBUTE_TYPE;
  _MF_ATTRIBUTE_TYPE = (
    MF_ATTRIBUTE_UINT32   = VT_UI4,
    MF_ATTRIBUTE_UINT64   = VT_UI8,
    MF_ATTRIBUTE_DOUBLE   = VT_R8,
    MF_ATTRIBUTE_GUID     = VT_CLSID,
    MF_ATTRIBUTE_STRING   = VT_LPWSTR,
    MF_ATTRIBUTE_BLOB     = (VT_VECTOR or VT_UI1),
    MF_ATTRIBUTE_IUNKNOWN = VT_UNKNOWN
  );
  {$EXTERNALSYM _MF_ATTRIBUTE_TYPE}
  MF_ATTRIBUTE_TYPE = _MF_ATTRIBUTE_TYPE;
  _MFTOPONODE_ATTRIBUTE_UPDATE = record
    NodeId:           TOPOID;   // The identifier of the topology node to update. To get the identifier of a topology node, call IMFTopologyNode.GetTopoNodeID.
    guidAttributeKey: TGUID;    // GUID that specifies the attribute to update.
    attrType:         MF_ATTRIBUTE_TYPE;  // Attribute type, specified as a member of the MF_ATTRIBUTE_TYPE enumeration.
    case Integer of
      Ord(MF_ATTRIBUTE_UINT32): (u32: UINT32); // Attribute value (unsigned 32-bit integer). This member is used when attrType equals MF_ATTRIBUTE_UINT32.
      Ord(MF_ATTRIBUTE_UINT64): (u64: UINT64); // Attribute value (unsigned 32-bit integer). This member is used when attrType equals MF_ATTRIBUTE_UINT64. See Remarks.
      Ord(MF_ATTRIBUTE_DOUBLE): (d: Double);   // Attribute value (floating point). This member is used when attrType equals MF_ATTRIBUTE_DOUBLE.
    end;
  MFTOPONODE_ATTRIBUTE_UPDATE = _MFTOPONODE_ATTRIBUTE_UPDATE;
  PDEV_BROADCAST_HDR = ^DEV_BROADCAST_HDR;
  _DEV_BROADCAST_HDR = record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
  end;
  DEV_BROADCAST_HDR = _DEV_BROADCAST_HDR;
   PWAVEFORMATEX = ^WAVEFORMATEX;
  tWAVEFORMATEX = record
    wFormatTag: WORD;                { format type }
    nChannels: WORD;                 { number of channels (i.e. mono, stereo...) }
    nSamplesPerSec: DWORD;           { sample rate }
    nAvgBytesPerSec: DWORD;          { for buffer estimation }
    nBlockAlign: WORD;               { block size of data }
    wBitsPerSample: WORD;            { Number of bits per sample of mono data }
    cbSize: WORD;                    { The count in bytes of the size of
                                       extra information (after cbSize) }
  end;
  WAVEFORMATEX = tWAVEFORMATEX;
  PDEV_BROADCAST_DEVICEINTERFACE = PDEV_BROADCAST_DEVICEINTERFACE_W;

  PMFBYTESTREAM_SEEK_ORIGIN = ^MFBYTESTREAM_SEEK_ORIGIN;
  _MFBYTESTREAM_SEEK_ORIGIN = (
    msoBegin                  = 0,
    msoCurrent                = (msoBegin  + 1));
  MFBYTESTREAM_SEEK_ORIGIN = _MFBYTESTREAM_SEEK_ORIGIN;
  PMFT_REGISTER_TYPE_INFO = ^MFT_REGISTER_TYPE_INFO;
    cwMFT_REGISTER_TYPE_INFO = record
    guidMajorType: TGUID;
    guidSubtype: TGUID;
  end;
  MFT_REGISTER_TYPE_INFO = cwMFT_REGISTER_TYPE_INFO;

  PMF_SINK_WRITER_STATISTICS = ^MF_SINK_WRITER_STATISTICS;
  _MF_SINK_WRITER_STATISTICS = record
    cb: DWORD;
    llLastTimestampReceived: LONGLONG;
    llLastTimestampEncoded: LONGLONG;
    llLastTimestampProcessed: LONGLONG;
    llLastStreamTickReceived: LONGLONG;
    llLastSinkSampleRequest: LONGLONG;
    qwNumSamplesReceived: QWORD;
    qwNumSamplesEncoded: QWORD;
    qwNumSamplesProcessed: QWORD;
    qwNumStreamTicksReceived: QWORD;
    dwByteCountQueued: DWORD;
    qwByteCountProcessed: QWORD;
    dwNumOutstandingSinkSampleRequests: DWORD;
    dwAverageSampleRateReceived: DWORD;
    dwAverageSampleRateEncoded: DWORD;
    dwAverageSampleRateProcessed: DWORD;
  end;
  MF_SINK_WRITER_STATISTICS = _MF_SINK_WRITER_STATISTICS;

  PMF_ATTRIBUTES_MATCH_TYPE = ^_MF_ATTRIBUTES_MATCH_TYPE;
  _MF_ATTRIBUTES_MATCH_TYPE = (
    MF_ATTRIBUTES_MATCH_OUR_ITEMS    = 0,    // do all of our items exist in their store and have identical data?
    MF_ATTRIBUTES_MATCH_THEIR_ITEMS  = 1,    // do all of their items exist in our store and have identical data?
    MF_ATTRIBUTES_MATCH_ALL_ITEMS    = 2,    // do both stores have the same set of identical items?
    MF_ATTRIBUTES_MATCH_INTERSECTION = 3,    // do the attributes that intersect match?
    MF_ATTRIBUTES_MATCH_SMALLER      = 4     // do all the attributes in the type that has fewer attributes match?
    );
  MF_ATTRIBUTES_MATCH_TYPE = _MF_ATTRIBUTES_MATCH_TYPE;
    PMfObjectType = ^MF_OBJECT_TYPE;
  PMF_OBJECT_TYPE = ^MF_OBJECT_TYPE;
  MF_OBJECT_TYPE          = (
    MF_OBJECT_MEDIASOURCE = 0,
    MF_OBJECT_BYTESTREAM  = (MF_OBJECT_MEDIASOURCE + 1),
    MF_OBJECT_INVALID     = (MF_OBJECT_BYTESTREAM + 1)
  );

  PIMFAttributes = ^IMFAttributes;
  IMFAttributes = interface(IUnknown)
    function GetItem(const guidKey: REFGUID;
                     var pValue: PROPVARIANT): HResult; stdcall;
    function GetItemType(const guidKey: REFGUID;
                         out pType: MF_ATTRIBUTE_TYPE): HResult; stdcall;
    function CompareItem(const guidKey: REFGUID;
                         const Value: REFPROPVARIANT;
                         out pbResult: boolean): HResult; stdcall;
    function Compare(const pTheirs: IMFAttributes;
                     const MatchType: MF_ATTRIBUTES_MATCH_TYPE;
                     out pbResult: boolean): HResult; stdcall;
    function GetUINT32(const guidKey: TGUID;
                       out punValue: UINT32): HResult; stdcall;
    function GetUINT64(const guidKey: TGUID;
                       out punValue: UINT64): HResult; stdcall;
    function GetDouble(const guidKey: TGUID;
                       out pfValue: Double): HResult; stdcall;
    function GetGUID(const guidKey: REFGUID;
                     out pguidValue: TGuid): HResult; stdcall;
    function GetStringLength(const guidKey: TGUID;
                             pcchLength: UINT32): HResult; stdcall;
    function GetString(const guidKey: REFGUID;
                       out pwszValue: LPWSTR;
                       out cchBufSize: UINT32;
                       pcchLength: UINT32): HResult; stdcall;
    function GetAllocatedString(const guidKey: REFGUID;
                                out ppwszValue: LPWSTR;
                                out pcchLength: UINT32 {This parameter must not be 0}): HResult; stdcall;
    function GetBlobSize(const guidKey: TGUID;
                         out pcbBlobSize: UINT32): HResult; stdcall;
    function GetBlob(const guidKey: TGUID;
                     {out} pBuf: PUINT8;
                     {in} cbBufSize: UINT32;
                     {out} pcbBlobSize: PUINT32 = nil): HResult; stdcall;
    function GetAllocatedBlob(const guidKey: TGUID;
                              out ppBuf: PUINT8;
                              pcbSize: UINT32): HResult; stdcall;
    function GetUnknown(const guidKey: TGUID;
                        const riid: REFIID;
                        out ppv: LPVOID): HResult; stdcall;
    function SetItem(const guidKey: TGUID;
                     const Value: PROPVARIANT): HResult; stdcall;
    function DeleteItem(const guidKey: TGUID): HResult; stdcall;
    function DeleteAllItems(): HResult; stdcall;
    function SetUINT32(const guidKey: TGUID;
                       const unValue: UINT32): HResult; stdcall;
    function SetUINT64(const guidKey: TGUID;
                       const unValue: UINT64): HResult; stdcall;
    function SetDouble(const guidKey: TGUID;
                       const fValue: Double): HResult; stdcall;
    function SetGUID(const guidKey: TGUID;
                     const guidValue: REFGUID): HResult; stdcall;
    function SetString(const guidKey: TGUID;
                       const wszValue: LPCWSTR): HResult; stdcall;
    function SetBlob(const guidKey: TGUID;
                     pBuf: UINT8;
                     cbBufSize: UINT32): HResult; stdcall;
    function SetUnknown(const constguidKey: TGUID;
                        pUnk: IUnknown): HResult; stdcall;
    function LockStore(): HResult; stdcall;
    function UnlockStore(): HResult; stdcall;
    function GetCount(out pcItems: UINT32): HResult; stdcall;
    function GetItemByIndex(const unIndex: UINT32;
                            const guidKey: TGUID;
                            var pValue: PROPVARIANT): HResult; stdcall;
    function CopyAllItems(pDest: IMFAttributes): HResult; stdcall;
  end;

  PIMFActivate = ^IMFActivate;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFActivate);'}
  {$EXTERNALSYM IMFActivate}
  IMFActivate = interface(IMFAttributes)
  ['{7FEE9E9A-4A89-47a6-899C-B6A53A70FB67}']
    function ActivateObject(const riid: REFIID;
                            out ppv: LPVOID): HResult; stdcall;
    function ShutdownObject(): HResult; stdcall;
    function DetachObject(): HResult; stdcall;
   end;
  IID_IMFActivate = IMFActivate;
  {$EXTERNALSYM IID_IMFActivate}
  PIMFMediaEvent = ^IMFMediaEvent;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFMediaEvent);'}
  {$EXTERNALSYM IMFMediaEvent}
  IMFMediaEvent = interface(IMFAttributes)
  ['{DF598932-F10C-4E39-BBA2-C308F101DAA3}']
    function GetType(out pmet: MediaEventType): HResult; stdcall;
    function GetExtendedType(out pguidExtendedType: TGuid): HResult; stdcall;
    function GetStatus(out phrStatus: HRESULT): HResult; stdcall;
    function GetValue(out pvValue: PROPVARIANT): HResult; stdcall;
  end;
  IID_IMFMediaEvent = IMFMediaEvent;
  {$EXTERNALSYM IID_IMFMediaEvent}
  PIMFMediaBuffer = ^IMFMediaBuffer;
  IMFMediaBuffer = interface(IUnknown)
  ['{045FA593-8799-42b8-BC8D-8968C6453507}']
    function Lock(out ppbBuffer: PByte;     // Receives a pointer to the start of the buffer.
                  pcbMaxLength: PDWord;     // Receives the maximum amount of data that can be written to the buffer. This parameter can be Nil.
                  pcbCurrentLength: PDWord  // Receives the length of the valid data in the buffer, in bytes. This parameter can be Nil.
                  ): HResult; stdcall;
    function Unlock(): HResult; stdcall;
    function GetCurrentLength(out pcbCurrentLength: DWord): HResult; stdcall;
    function SetCurrentLength(const cbCurrentLength: DWord): HResult; stdcall;
    function GetMaxLength(out pcbMaxLength: DWord): HResult; stdcall;
  end;
  IID_IMFMediaBuffer = IMFMediaBuffer;


  PIMFMediaType = ^IMFMediaType;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFMediaType);'}
  {$EXTERNALSYM IMFMediaType}
  IMFMediaType = interface(IMFAttributes)
  ['{44ae0fa8-ea31-4109-8d2e-4cae4997c555}']
    function GetMajorType(out pguidMajorType: TGuid): HResult; stdcall;
    function IsCompressedFormat(out pfCompressed: BOOL): HResult; stdcall;
    function IsEqual(pIMediaType: IMFMediaType;
                     out pdwFlags: DWord): HResult; stdcall;
    function GetRepresentation(const guidRepresentation: TGuid;
                               out ppvRepresentation: LPVOID): HResult; stdcall;
    function FreeRepresentation(const guidRepresentation: TGuid;
                                pvRepresentation: LPVOID): HResult; stdcall;
  end;
  IID_IMFMediaType = IMFMediaType;
  {$EXTERNALSYM IID_IMFMediaType}

      PIMFCollection = ^IMFCollection;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFCollection);'}
  {$EXTERNALSYM IMFCollection}
  IMFCollection = interface(IUnknown)
  ['{5BC8A76B-869A-46a3-9B03-FA218A66AEBE}']
    function GetElementCount(out pcElements: DWord): HResult; stdcall;
    function GetElement(dwElementIndex: DWord;
                        out ppUnkElement: IUnknown): HResult; stdcall;
    function AddElement(pUnkElement: IUnknown): HResult; stdcall;
    function RemoveElement(dwElementIndex: DWord;
                           out ppUnkElement: IUnknown): HResult; stdcall;
    function InsertElementAt(dwIndex: DWord;
                             pUnfknown_: IUnknown): HResult; stdcall;
    function RemoveAllElements(): HResult; stdcall;
  end;
  IID_IMFCollection = IMFCollection;
  {$EXTERNALSYM IID_IMFCollection}

   PStreamContents = ^TStreamContents;
  _StreamContents = record
    dwStreamIndex: DWORD;                 // The stream index (zero based !)
    dwStreamID: DWORD;                    // The stream identifier (see: https://msdn.microsoft.com/en-us/library/windows/desktop/ms703852)
    bSelected: BOOL;                      // The currently selected stream.
    idStreamMediaType: TMediaTypes;       // The mediatype (associated with the Major Type Guid
    idStreamMajorTypeGuid: TGuid;         // The majortype of the stream
    idStreamSubTypeGuid: TGuid;           // The subtype of the stream
    bCompressed: BOOL;                    // Compressed format.
    // Video
    video_FrameRateNumerator: UINT32;     // The upper 32 bits of the MF_MT_FRAME_RATE attribute value
    video_FrameRateDenominator: UINT32;   // The lower 32 bits of the MF_MT_FRAME_RATE attribute value
    // NOTE:
    //  To calculate the framerate in FPS use this formula: Double(video_FrameRateNominator / video_FrameRateDenominator)
    video_PixelAspectRatioNumerator: UINT32;   // The upper 32 bits of the MF_MT_PIXEL_ASPECT_RATIO attribute value
    video_PixelAspectRatioDenominator: UINT32; // The lower 32 bits of the MF_MT_PIXEL_ASPECT_RATIO attribute value
    // NOTE:
    //  To calculate the pixel aspect ratio use this formula: Double(video_PixelAspectRatioNumerator / video_PixelAspectRatioDenominator)
    video_FrameSizeHeigth: UINT32;        // Output frame heigth
    video_FrameSizeWidth: UINT32;         // Output frame width
    // Audio
    audio_lpStreamName: LPWSTR;           // The name of the stream (if stored in the sourcestream)
    audio_lpLangShortName: LPWSTR;        // Short language name (like 'en' for English, 'de' for German, 'fr' for French etc. stored in the stream
    audio_lpLangFullName: LPWSTR;         // Friendly language name (optional, caller needs to set these)
    audio_wsAudioDescr: WideString;       // Audio codec description.
    audio_iAudioChannels: UINT32;         // Number of audio channels.
    audio_iSamplesPerSec: UINT32;         // Audio Samples per second.
    audio_iBitsPerSample: UINT32;         // Audio bits per sample.
    audio_iblockAlignment: UINT32;        // Block alignment, in bytes, for an audio media type.
                                          // Note: For PCM audio formats, the block alignment is equal to the number of audio channels
                                          // multiplied by the number of bytes per audio sample.
    audio_dwFormatTag: DWORD;             // FormatTag is the replacement of FOURCC
    public
      procedure Reset();
  end;
  TStreamContents = _StreamContents;
  TStreamContentsArray = array of TStreamContents;

  PIPropertyStore = ^IPropertyStore;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPropertyStore);'}
  {$EXTERNALSYM IPropertyStore}
   IPropertyStore = interface(IUnknown)
   ['{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}']
     function GetCount(out cProps: DWORD): HResult; stdcall;

     function GetAt(iProp: DWORD;
                    out pkey: PPROPERTYKEY): HResult; stdcall;

     function GetValue(const key: PROPERTYKEY;
                       out pv: PROPVARIANT): HResult; stdcall;

     function SetValue(const key: PROPERTYKEY;
                       const propvar: PROPVARIANT): HResult; stdcall;

     function Commit: HResult; stdcall;

   end;
  IID_IPropertyStore = IPropertyStore;

    {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFTopology);'}
  {$EXTERNALSYM IMFTopology}
  IMFTopology = interface(IMFAttributes)
    ['{83CF873A-F6DA-4bc8-823F-BACFD55DC433}']
    function GetTopologyID(out pID: TOPOID): HResult; stdcall;
    function AddNode(pNode: IMFTopologyNode): HResult; stdcall;
    function RemoveNode(pNode: IMFTopologyNode): HResult; stdcall;
    function GetNodeCount(out pwNodes: Word): HResult; stdcall;
    function GetNode(wIndex: Word;
                     out ppNode: IMFTopologyNode): HResult; stdcall;
    function Clear(): HResult; stdcall;
    function CloneFrom(pTopology: IMFTopology): HResult; stdcall;
    function GetNodeByID(qwTopoNodeID: TOPOID;
                         out ppNode: IMFTopologyNode): HResult; stdcall;
    function GetSourceNodeCollection(out ppCollection: IMFCollection): HResult; stdcall;
    function GetOutputNodeCollection(out ppCollection: IMFCollection): HResult; stdcall;
  end;
  IID_IMFTopology = IMFTopology;
  // Interface IMFTopologyNode
  // =========================
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFTopologyNode);'}
  {$EXTERNALSYM IMFTopologyNode}
  IMFTopologyNode = interface(IMFAttributes)
    ['{83CF873A-F6DA-4bc8-823F-BACFD55DC430}']
    function SetObject(pObject: IUnknown): HResult; stdcall;
    //Sets the object associated with this node.
    //Parameters
    // pObject [in]
    //   A pointer to the object's IUnknown interface.
    //   Use the value Nil to clear an object that was previous set.
    function GetObject(out ppObject: IUnknown): HResult; stdcall;
    function GetNodeType(out pType: MF_TOPOLOGY_TYPE): HResult; stdcall;
    function GetTopoNodeID(out pID: TOPOID): HResult; stdcall;
    function SetTopoNodeID(ullTopoID: TOPOID): HResult; stdcall;
    function GetInputCount(out pcInputs: DWord): HResult; stdcall;
    function GetOutputCount(out pcOutputs: DWord): HResult; stdcall;
    function ConnectOutput(dwOutputIndex: DWord;
                           pDownstreamNode: IMFTopologyNode;
                           const dwInputIndexOnDownstreamNode: DWord): HResult; stdcall;
    function DisconnectOutput(const dwOutputIndex: DWord): HResult; stdcall;
    function GetInput(dwInputIndex: DWord;
                      out ppUpstreamNode: IMFTopologyNode;
                      out pdwOutputIndexOnUpstreamNode: DWord): HResult; stdcall;
    function GetOutput(dwOutputIndex : DWord;
                       out ppDownstreamNode: IMFTopologyNode;
                       out pdwInputIndexOnDownstreamNode: DWord): HResult; stdcall;
    function SetOutputPrefType(dwOutputIndex: DWord;
                               pType: IMFMediaType): HResult; stdcall;
    function GetOutputPrefType(dwOutputIndex: DWord;
                               out ppType: IMFMediaType): HResult; stdcall;
    function SetInputPrefType(dwInputIndex: DWord;
                              pType: IMFMediaType): HResult; stdcall;
    function GetInputPrefType(dwInputIndex: DWord;
                              out ppType: IMFMediaType): HResult; stdcall;
    function CloneFrom(pNode: IMFTopologyNode): HResult; stdcall;
  end;
  IID_IMFTopologyNode = IMFTopologyNode;
  {$EXTERNALSYM IID_IMFTopologyNode}


  PIMFSample = ^IMFSample;
  IMFSample = interface(IMFAttributes)
    function GetSampleFlags(out pdwSampleFlags: DWord): HResult; stdcall;
    function SetSampleFlags(dwSampleFlags: DWord): HResult; stdcall;
    function GetSampleTime(out phnsSampleTime: LONGLONG): HResult; stdcall;
    function SetSampleTime(hnsSampleTime: LONGLONG): HResult; stdcall;
    function GetSampleDuration(out phnsSampleDuration: LONGLONG): HResult; stdcall;
    function SetSampleDuration(hnsSampleDuration: LONGLONG): HResult; stdcall;
    function GetBufferCount(out pdwBufferCount: DWord): HResult; stdcall;
    function GetBufferByIndex(dwIndex: DWord;
                              out ppBuffer: IMFMediaBuffer): HResult; stdcall;
    function ConvertToContiguousBuffer(out ppBuffer: IMFMediaBuffer): HResult; stdcall;
    function AddBuffer(pBuffer: IMFMediaBuffer): HResult; stdcall; // If sample does not support adding buffers, it returns MF_E_SAMPLE_UNSUPPORTED_OP.
    function RemoveBufferByIndex(dwIndex: DWord): HResult; stdcall;
    function RemoveAllBuffers(): HResult; stdcall;
    function GetTotalLength(out pcbTotalLength: DWord): HResult; stdcall;
    function CopyToBuffer(pBuffer: IMFMediaBuffer): HResult; stdcall;
  end;
  IID_IMFSample = IMFSample;
  IMFMediaTypeHandler = interface(IUnknown)
  ['{e93dcf6c-4b07-4e1e-8123-aa16ed6eadf5}']
    function IsMediaTypeSupported(pMediaType: IMFMediaType;
                                  {out} ppMediaType: IMFMediaType): HResult; stdcall;
    function GetMediaTypeCount(out pdwTypeCount: DWord): HResult; stdcall;
    function GetMediaTypeByIndex(dwIndex: DWord;
                                 out ppType: IMFMediaType): HResult; stdcall;
    function SetCurrentMediaType(pMediaType: IMFMediaType): HResult; stdcall;
    function GetCurrentMediaType(out ppMediaType: IMFMediaType): HResult; stdcall;
    function GetMajorType(out pguidMajorType: TGuid): HResult; stdcall;
  end;
  IID_IMFMediaTypeHandler = IMFMediaTypeHandler;
  IMFStreamDescriptor = interface(IMFAttributes)
  ['{56c03d9c-9dbb-45f5-ab4b-d80f47c05938}']
    function GetStreamIdentifier(out pdwStreamIdentifier: DWord): HResult; stdcall;
    function GetMediaTypeHandler(out ppMediaTypeHandler: IMFMediaTypeHandler): HResult; stdcall;
  end;
  IID_IMFStreamDescriptor = IMFStreamDescriptor;
  PIMFAsyncResult = ^IMFAsyncResult;
  IMFAsyncResult = interface(IUnknown)
    function GetState(out ppunkState: IUnknown): HResult; stdcall;
    function GetStatus(): HResult; stdcall;
    function SetStatus(hrStatus: HRESULT): HResult; stdcall;
    function GetObject(out ppObject: IUnknown): HResult; stdcall;
    function GetStateNoAddRef(): IUnknown; stdcall;
  end;
  IID_IMFAsyncResult = IMFAsyncResult;

  PIMFAsyncCallback = ^IMFAsyncCallback;
  IMFAsyncCallback = interface(IUnknown)
  ['{a27003cf-2354-4f2a-8d6a-ab7cff15437e}']
    function GetParameters(out pdwFlags: DWord;
                           out pdwQueue: DWord): HResult; stdcall;
    function Invoke(pAsyncResult: IMFAsyncResult): HResult; stdcall;
  end;
  IID_IMFAsyncCallback = IMFAsyncCallback;
  IMFPresentationDescriptor = interface(IMFAttributes)
  ['{03cb2711-24d7-4db6-a17f-f3a7a479a536}']
    function GetStreamDescriptorCount(out pdwDescriptorCount: DWord): HResult; stdcall;
    function GetStreamDescriptorByIndex(const dwIndex: DWord;
                                        out pfSelected: BOOL;
                                        out ppDescriptor: IMFStreamDescriptor): HResult; stdcall;
    function SelectStream(dwDescriptorIndex: Int32): HResult; stdcall;
    function DeselectStream(dwDescriptorIndex: Int32): HResult; stdcall;
    function Clone(out ppPresentationDescriptor: IMFPresentationDescriptor): HResult; stdcall;
  end;
  IID_IMFPresentationDescriptor = IMFPresentationDescriptor;

  PIMFMediaEventGenerator = ^IMFMediaEventGenerator;
  IMFMediaEventGenerator = interface(IUnknown)
    function GetEvent(dwFlags: DWord;
                      out ppEvent: IMFMediaEvent): HResult; stdcall;
    function BeginGetEvent(pCallback: IMFAsyncCallback;
                           punkState: IUnknown): HResult; stdcall;
    function EndGetEvent(pResult: IMFAsyncResult;
                         out ppEvent: IMFMediaEvent): HResult; stdcall;
    function QueueEvent(met: MediaEventType;
                        guidExtendedType: REFGUID;
                        hrStatus: HRESULT;
                        pvValue: PROPVARIANT): HResult; stdcall;
  end;
  IID_IMFMediaEventGenerator = IMFMediaEventGenerator;
  PMFCLOCK_PROPERTIES = ^MFCLOCK_PROPERTIES;
  _MFCLOCK_PROPERTIES = record
    qwCorrelationRate: UInt64;
    guidClockId: TGuid;
    dwClockFlags: DWORD;
    qwClockFrequency: UInt64;
    dwClockTolerance: DWORD;
    dwClockJitter: DWORD;
    public
      procedure Copy(out destProps: _MFCLOCK_PROPERTIES);
  end;
  MFCLOCK_PROPERTIES = _MFCLOCK_PROPERTIES;
   {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFClock);'}
  {$EXTERNALSYM IMFClock}
  IMFClock = interface(IUnknown)
    ['{2eb1e945-18b8-4139-9b1a-d5d584818530}']
    function GetClockCharacteristics(out pdwCharacteristics: PDWord): HResult; stdcall;
    function GetCorrelatedTime(dwReserved: DWord;
                               out pllClockTime: LongLong;
                               out phnsSystemTime: MFTIME): HResult; stdcall;
    function GetContinuityKey(out pdwContinuityKey: Dword): HResult; stdcall;
    function GetState(dwReserved: DWord;
                      out peClockState: MFCLOCK_STATE): HResult; stdcall;
    function GetProperties(out pClockProperties: MFCLOCK_PROPERTIES): HResult; stdcall;
  end;
  IID_IMFClock = IMFClock;
  {$EXTERNALSYM IID_IMFClock}
    IMFPresentationTimeSource = interface(IUnknown)
  ['{7FF12CCE-F76F-41c2-863B-1666C8E5E139}']
    function GetUnderlyingClock(out ppClock: IMFClock): HResult; stdcall;
  end;
  IID_IMFPresentationTimeSource = IMFPresentationTimeSource;
    IMFClockStateSink = interface(IUnknown)
  ['{F6696E82-74F7-4f3d-A178-8A5E09C3659F}']
    function OnClockStart(hnsSystemTime: MFTIME;
                          llClockStartOffset: LongLong): HResult; stdcall;
    function OnClockStop(hnsSystemTime: MFTIME): HResult; stdcall;
    function OnClockPause(hnsSystemTime: MFTIME): HResult; stdcall;
    function OnClockRestart(hnsSystemTime: MFTIME): HResult; stdcall;
    function OnClockSetRate(hnsSystemTime: MFTIME;
                            flRate: Single): HResult; stdcall;
  end;
  IID_IMFClockStateSink = IMFClockStateSink;
    {$EXTERNALSYM IMFPresentationClock}
  IMFPresentationClock = interface(IMFClock)
  ['{868CE85C-8EA9-4f55-AB82-B009A910A805}']
    function SetTimeSource(pTimeSource: IMFPresentationTimeSource): HResult; stdcall;
    function GetTimeSource(out ppTimeSource: IMFPresentationTimeSource): HResult; stdcall;
    function GetTime(out phnsClockTime: MFTIME): HResult; stdcall;
    function AddClockStateSink(pStateSink: IMFClockStateSink): HResult; stdcall;
    function RemoveClockStateSink(pStateSink: IMFClockStateSink): HResult; stdcall;
    // Don't use the control functions directly, when starting a Session.
    // The session will handle those automaticly.
    function Start(llClockStartOffset: LongLong): HResult; stdcall;
    function Stop(): HResult; stdcall;
    function Pause(): HResult; stdcall;
  end;
  IID_IMFPresentationClock = IMFPresentationClock;
  {$EXTERNALSYM IID_IMFPresentationClock}
  IMFMediaSink = interface(IUnknown)
  ['{6ef2a660-47c0-4666-b13d-cbb717f2fa2c}']
    function GetCharacteristics(out pdwCharacteristics: PDWord): HResult; stdcall;
    function AddStreamSink(dwStreamSinkIdentifier: DWord;
                           pMediaType: IMFMediaType;
                           out ppStreamSink: IMFStreamSink): HResult; stdcall;
    function RemoveStreamSink(dwStreamSinkIdentifier: DWord): HResult; stdcall;
    function GetStreamSinkCount(out pcStreamSinkCount: DWord): HResult; stdcall;
    function GetStreamSinkByIndex(dwIndex: DWord;
                                  out ppStreamSink: IMFStreamSink): HResult; stdcall;
    function GetStreamSinkById(dwStreamSinkIdentifier: DWord;
                               out ppStreamSink: IMFStreamSink): HResult; stdcall;
    function SetPresentationClock(pPresentationClock: IMFPresentationClock): HResult; stdcall;
    function GetPresentationClock(out ppPresentationClock: IMFPresentationClock): HResult; stdcall;
    function Shutdown(): HResult; stdcall;
  end;
  IID_IMFMediaSink = IMFMediaSink;
  PMFSTREAMSINK_MARKER_TYPE = ^MFSTREAMSINK_MARKER_TYPE;
  _MFSTREAMSINK_MARKER_TYPE          = (
    MFSTREAMSINK_MARKER_DEFAULT      = 0,
    MFSTREAMSINK_MARKER_ENDOFSEGMENT = (MFSTREAMSINK_MARKER_DEFAULT  + 1),
    MFSTREAMSINK_MARKER_TICK         = (MFSTREAMSINK_MARKER_ENDOFSEGMENT  + 1),
    MFSTREAMSINK_MARKER_EVENT        = (MFSTREAMSINK_MARKER_TICK  + 1)
  );
  {$EXTERNALSYM _MFSTREAMSINK_MARKER_TYPE}
  MFSTREAMSINK_MARKER_TYPE = _MFSTREAMSINK_MARKER_TYPE;
  IMFStreamSink = interface(IMFMediaEventGenerator)
  ['{0A97B3CF-8E7C-4a3d-8F8C-0C843DC247FB}']
    function GetMediaSink(out ppMediaSink: IMFMediaSink): HResult; stdcall;
    function GetIdentifier(out pdwIdentifier: DWord): HResult; stdcall;
    function GetMediaTypeHandler(out ppHandler: IMFMediaTypeHandler): HResult; stdcall;
    function ProcessSample(pSample: IMFSample): HResult; stdcall;
    function PlaceMarker(const eMarkerType: MFSTREAMSINK_MARKER_TYPE;
                         const pvarMarkerValue: PROPVARIANT;
                         const pvarContextValue: PROPVARIANT): HResult; stdcall;
    function Flush(): HResult; stdcall;
  end;
  IID_IMFStreamSink = IMFStreamSink;
  {$EXTERNALSYM IMFTopologyNodeAttributeEditor}
  IMFTopologyNodeAttributeEditor = interface(IUnknown)
  ['{676aa6dd-238a-410d-bb99-65668d01605a}']
    function UpdateNodeAttributes(TopoId: TOPOID;
                                  cUpdates: DWORD;
                                  pUpdates: MFTOPONODE_ATTRIBUTE_UPDATE): HResult; stdcall;
  end;
  IID_IMFTopologyNodeAttributeEditor = IMFTopologyNodeAttributeEditor;
  {$EXTERNALSYM IID_IMFTopologyNodeAttributeEditor}

  IMFMediaSession = interface(IMFMediaEventGenerator)
  ['{90377834-21D0-4dee-8214-BA2E3E6C1127}']
    function SetTopology(const dwSetTopologyFlags: MFSESSION_SETTOPOLOGY_FLAGS;
                         Topology: IMFTopology): HResult; stdcall;
    // When the topologies are deleted, the assiociated callback (referencecount will be
    // set to 0) and will be released.
    // So, if the sessionmanager's topology contains a callbackinterface,
    // don't forget to call this function to prevent pointer errors.
    //
    // A normal session-end where all resources, references and queued presentations are cleared,
    // would go like this to make sure no memory leaks will be created.
    //
    //  1 MySession.Stop()      This method is asynchronous. When the operation completes, the Media Session sends an MESessionStopped event.
    //  2 MySession.ClearTopologies()  See comments on ClearTopologies.
    //  3 MySession.Shutdown()  See comments on ShutDown.
    //  4 MySession := Nil or SafeRelease(MySession)  Calls IUnknown._Release.
    //
    function ClearTopologies(): HResult; stdcall; // Clears all of the presentations that are queued for playback in the Media Session.
    function Start(const pguidTimeFormat: TGUID;
                   const pvarStartPosition: PROPVARIANT): HResult; stdcall;
    function Pause(): HResult; stdcall;
    function Stop(): HResult; stdcall;
    function Close(): HResult; stdcall;  // Closes the Media Session and releases all of the resources it is using.
    function Shutdown(): HResult; stdcall;  // Shuts down the Media Session and releases all the resources used by the Media Session.
                                            // Call this method when you are done using the Media Session, before the final call to IUnknown._Release.
                                            // Otherwise, your application will leak memory.
    function GetClock(out ppClock: IMFClock): HResult; stdcall;
    function GetSessionCapabilities(out pdwCaps: DWord): HResult; stdcall;
    function GetFullTopology(const dwGetFullTopologyFlags: DWord;
                             const TopId: TOPOID;
                             out ppFullTopology: IMFTopology): HResult; stdcall;
  end;
  IID_IMFMediaSession = IMFMediaSession;
  {$EXTERNALSYM IID_IMFMediaSession}
    // Interface IMFTranscodeProfile
  // =============================
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFTranscodeProfile);'}
  {$EXTERNALSYM IMFTranscodeProfile}
  IMFTranscodeProfile = interface(IUnknown)
  ['{4ADFDBA3-7AB0-4953-A62B-461E7FF3DA1E}']
    function SetAudioAttributes(pAttrs: IMFAttributes): HResult; stdcall;
    function GetAudioAttributes(out ppAttrs: IMFAttributes): HResult; stdcall;
    function SetVideoAttributes(pAttrs: IMFAttributes): HResult; stdcall;
    function GetVideoAttributes(out ppAttrs: IMFAttributes): HResult; stdcall;
    function SetContainerAttributes(pAttrs: IMFAttributes): HResult; stdcall;
    function GetContainerAttributes(out ppAttrs: IMFAttributes): HResult; stdcall;
  end;
  IID_IMFTranscodeProfile = IMFTranscodeProfile;
  {$EXTERNALSYM IID_IMFTranscodeProfile}

  IMFMediaSource = interface(IMFMediaEventGenerator)
    ['{279A808D-AEC7-40C8-9C6B-A6B492C78A66}']
    function GetCharacteristics(out pdwCharacteristics: PDWord): HResult; stdcall;
    function CreatePresentationDescriptor(out ppPresentationDescriptor: IMFPresentationDescriptor): HResult; stdcall;
    function Start(pPresentationDescriptor: IMFPresentationDescriptor;
                   const pguidTimeFormat: TGuid;
                   const pvarStartPosition: PROPVARIANT): HResult; stdcall;
    function Stop(): HResult; stdcall;
    function Pause(): HResult; stdcall;
    function Shutdown(): HResult; stdcall;
  end;
  IID_IMFMediaSource = IMFMediaSource;

 PIMFSinkWriter = ^IMFSinkWriter;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFSinkWriter);'}
  {$EXTERNALSYM IMFSinkWriter}
  IMFSinkWriter = interface(IUnknown)
  ['{3137f1cd-fe5e-4805-a5d8-fb477448cb3d}']
    function AddStream(pTargetMediaType: IMFMediaType;
                       out pdwStreamIndex: DWord): HResult; stdcall;
    function SetInputMediaType(dwStreamIndex: DWord;
                               pInputMediaType: IMFMediaType;
                               pEncodingParameters: IMFAttributes): HResult; stdcall;
    function BeginWriting(): HResult; stdcall;
    function WriteSample(dwStreamIndex: DWord;
                         pSample: IMFSample): HResult; stdcall;
    function SendStreamTick(dwStreamIndex: DWord;
                            llTimestamp: LONGLONG): HResult; stdcall;
    function PlaceMarker(dwStreamIndex: DWord;
                         pvContex: Pointer): HResult; stdcall;
    function NotifyEndOfSegment(dwStreamIndex: DWord): HResult; stdcall;
    function Flush(dwStreamIndex: DWord): HResult; stdcall;
    function Finalize(): HResult; stdcall;
    function GetServiceForStream(dwStreamIndex: DWord;
                                 const guidService: REFGUID;
                                 const riid: REFIID;
                                 out ppvObject: Pointer {LPVOID}): HResult; stdcall;
    function GetStatistics(dwStreamIndex: DWord;
                           out pStats: MF_SINK_WRITER_STATISTICS): HResult; stdcall;
  end;
  IID_IMFSinkWriter = IMFSinkWriter;
  {$EXTERNALSYM IID_IMFSinkWriter}

  PIMFSourceReader = ^IMFSourceReader;
  IMFSourceReader = interface(IUnknown)
    function GetStreamSelection(dwStreamIndex: DWORD;
                                out pfSelected: Boolean): HResult; stdcall;
    function SetStreamSelection(dwStreamIndex: DWORD;
                                const fSelected: Boolean): HResult; stdcall;
    // Gets a format that is supported natively by the media source.
    // Note: To check if a format is supported by Media Foundation see: https://docs.microsoft.com/en-us/windows/win32/medfound/supported-media-formats-in-media-foundation
    function GetNativeMediaType(dwStreamIndex: DWORD;
                                dwMediaTypeIndex: DWORD;
                                out ppMediaType: IMFMediaType): HResult; stdcall;
    function GetCurrentMediaType(dwStreamIndex: DWORD;
                                 out ppMediaType: IMFMediaType): HResult; stdcall;
    function SetCurrentMediaType(dwStreamIndex: DWORD;
                      {Reserved} pdwReserved: DWORD;
                                 pMediaType: IMFMediaType): HResult; stdcall;
    function SetCurrentPosition(const guidTimeFormat: TGUID;
                                const varPosition: PROPVARIANT): HResult; stdcall;
    function ReadSample(dwStreamIndex: DWORD;   // The stream to pull data from.
                        dwControlFlags: DWORD;  // A bitwise OR of zero or more flags from the MF_SOURCE_READER_CONTROL_FLAG enumeration.
         {out optional} pdwActualStreamIndex: PDWORD = Nil;  // Receives the zero-based index of the stream.
         {out optional} pdwStreamFlags: PDWORD = Nil;        // Receives a bitwise OR of zero or more flags from the MF_SOURCE_READER_FLAG enumeration.
         {out optional} pllTimestamp: PLONGLONG = Nil;       // Receives the time stamp of the sample, or the time of the stream event indicated in pdwStreamFlags. The time is given in 100-nanosecond units.
         {out optional} ppSample: PIMFSample = Nil): HResult; stdcall;
    function Flush(dwStreamIndex: DWord): HResult; stdcall;
    function GetServiceForStream(dwStreamIndex: DWORD;
                                 const guidService: REFGUID;
                                 const riid: REFIID;
                                 out ppvObject: Pointer {LPVOID}): HResult; stdcall;
    function GetPresentationAttribute(const dwStreamIndex: DWORD;
                                      const guidAttribute: REFGUID;
                                      var pvarAttribute: PROPVARIANT): HResult; stdcall;
  end;
  IID_IMFSourceReader = IMFSourceReader;
  PIMFSourceReaderCallback = ^IMFSourceReaderCallback;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFSourceReaderCallback);'}
  {$EXTERNALSYM IMFSourceReaderCallback}
  IMFSourceReaderCallback = interface(IUnknown)
  ['{deec8d99-fa1d-4d82-84c2-2c8969944867}']
    function OnReadSample(hrStatus: HRESULT;     // Specifies the error code if an error occurred while processing the sample request.
                          dwStreamIndex: DWORD;  // Specifies the stream index for the sample.
                          dwStreamFlags: DWORD;  // Specifies the accumulated flags for the stream.
                          llTimestamp: LONGLONG; // Contains the presentation time of the sample.
                                                 // If MF_SOURCE_READERF_STREAM_TICK is set for the stream flags,
                                                 // then this contains the timestamp for the stream tick.
                          pSample: IMFSample): HResult; stdcall; // Contains the next sample for the stream. It is possible for
                                                                 // this parameter to be Nil, so the application should
                                                                 // explicitly check for Nil before dereferencing the sample.
    function OnFlush(dwStreamIndex: DWORD): HResult; stdcall;
    function OnEvent(dwStreamIndex: DWORD;
                     pEvent: IMFMediaEvent): HResult; stdcall;
  end;
  IID_IMFSourceReaderCallback = IMFSourceReaderCallback;
  {$EXTERNALSYM IID_IMFSourceReaderCallback}
   PIMFByteStream = ^IMFByteStream;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFByteStream);'}
  {$EXTERNALSYM IMFByteStream}
  IMFByteStream = interface(IUnknown)
  ['{ad4c1b00-4bf7-422f-9175-756693d9130d}']
    function GetCapabilities(out pdwCapabilities: DWord): HResult; stdcall;
    function GetLength(out pqwLength: QWORD): HResult; stdcall;
    function SetLength(qwLength: QWORD): HResult; stdcall;
    function GetCurrentPosition(out pqwPosition: QWORD): HResult; stdcall;
    function SetCurrentPosition(const qwPosition: QWORD): HResult; stdcall;
    function IsEndOfStream(out pfEndOfStream: BOOL): HResult; stdcall;
    function Read(pb: PByte;
                  cb: ULONG;
                  out pcbRead: PByte): HResult; stdcall;
    function BeginRead(pb: PByte;
                       cb: ULONG;
                       pCallback: IMFAsyncCallback;
                       punkState: IUnknown): HResult; stdcall;
    function EndRead(pResult: IMFAsyncResult;
                     out pcbRead: ULONG): HResult; stdcall;
    function Write(pb: PByte;
                   cb: ULONG;
                   out pcbWritten: ULONG): HResult; stdcall;
    function BeginWrite(pb: PByte;
                        cb: ULONG;
                        pCallback: IMFAsyncCallback;
                        punkState: IUnknown): HResult; stdcall;
    function EndWrite(pResult: IMFAsyncResult;
                      out pcbWritten: ULONG): HResult; stdcall;
    function Seek(SeekOrigin: MFBYTESTREAM_SEEK_ORIGIN;
                  llSeekOffset: LONGLONG;
                  dwSeekFlags: DWord;
                  out pqwCurrentPosition: QWORD): HResult; stdcall;
    function Flush(): HResult; stdcall;
    function Close(): HResult; stdcall;
  end;
  IID_IMFByteStream = IMFByteStream;


    // interface IMFSourceResolver
  // ===========================
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFSourceResolver);'}
  {$EXTERNALSYM IMFSourceResolver}
  IMFSourceResolver = interface(IUnknown)
    ['{FBE5A32D-A497-4b61-BB85-97B1A848A6E3}']
      function CreateObjectFromURL(const pwszURL: LPCWSTR;
                                   dwFlags: DWord;
                                   pProps: IPropertyStore; // can be nil
                                   var pObjectType: MF_OBJECT_TYPE;
                                   out ppObject: IUnknown): HResult; stdcall;
      function CreateObjectFromByteStream(pByteStream: IMFByteStream;
                                          const pwszURL: LPCWSTR; // can be nil
                                          dwFlags: DWord;
                                          pProps: IPropertyStore; // can be nil
                                          var pObjectType: MF_OBJECT_TYPE;
                                          out ppObject: IUnknown): HResult; stdcall;
      function BeginCreateObjectFromURL(const pwszURL: LPCWSTR;
                                        dwFlags: DWord;
                                        pProps: IPropertyStore; // can be nil
                                        var ppIUnknownCancelCookie: IUnknown;
                                        pCallback: IMFAsyncCallback;
                                        punkState: IUnknown): HResult; stdcall;
      function EndCreateObjectFromURL(pResult: IMFAsyncResult;
                                      out pObjectType: MF_OBJECT_TYPE;
                                      out ppObject: IUnknown): HResult; stdcall;
      function BeginCreateObjectFromByteStream(pByteStream: IMFByteStream;
                                               const pwszURL: LPCWSTR;
                                               dwFlags: DWord;
                                               pProps: IPropertyStore; // can be nil
                                               out ppIUnknownCancelCookie: IUnknown;
                                               pCallback: IMFAsyncCallback;
                                               punkState: IUnknown): HResult; stdcall;
      function EndCreateObjectFromByteStream(pResult: IMFAsyncResult;
                                             out pObjectType: MF_OBJECT_TYPE;
                                             out ppObject: IUnknown): HResult; stdcall;
      function CancelObjectCreation(pIUnknownCancelCookie: IUnknown): HResult; stdcall;
  end;
  IID_IMFSourceResolver = IMFSourceResolver;
  {$EXTERNALSYM IID_IMFSourceResolver}
  {$NODEFINE PIMFActivateArray}
  PIMFActivateArray = ^TIMFActivateArray;
  {$NODEFINE TIMFActivateArray}
  TIMFActivateArray = array[0..65535] of IMFActivate;
  function GetPresentationDescriptorFromTopology(pTopology: IMFTopology;
                                                 out ppPD: IMFPresentationDescriptor): HRESULT;
  function MFStartup(const Version: ULONG = MF_API_VERSION;
                     const dwFlags: DWORD = MFSTARTUP_FULL): HRESULT; stdcall;
  function MFCreateMediaType(out ppMFType: IMFMediaType): HResult; stdcall;
  function MFCreateAttributes([ref] const ppMFAttributes: IMFAttributes; cInitialSize: UINT32): HResult; stdcall;
  function MFCreateSourceReaderFromMediaSource(pMediaSource: IMFMediaSource; pAttributes: IMFAttributes; out ppSourceReader: IMFSourceReader): HResult; stdcall;
  function MFTRegisterLocalByCLSID(const clisdMFT: REFCLSID;    // The class identifier (CLSID) of the MFT.
                                   const guidCategory: REFGUID; // A GUID that specifies the category of the MFT. For a list of MFT categories, see MFT_CATEGORY.
                                   pszName: LPCWSTR;      // A wide-character null-terminated string that contains the friendly name of the MFT.
                                   Flags: UINT32;         // A bitwise OR of zero or more flags from the MFT_ENUM_FLAG enumeration.
                                   cInputTypes: UINT32;         // The number of elements in the pInputTypes array.
                                   pInputTypes: PMFT_REGISTER_TYPE_INFO; // A pointer to an array of MFT_REGISTER_TYPE_INFO structures.
                                   cOutputTypes: UINT32;        // The number of elements in the pOutputTypes array.
                                   pOutputTypes: PMFT_REGISTER_TYPE_INFO // A pointer to an array of MFT_REGISTER_TYPE_INFO structures.
                                   ): HResult; stdcall;
  function MFCreateSinkWriterFromURL(const pwszOutputURL: WideString;
                                     pByteStream: IMFByteStream;
                                     pAttributes: IMFAttributes;
                                     out ppSinkWriter: IMFSinkWriter): HResult; stdcall;
  function CoInitializeEx(pvReserved: Pointer;
                          dwCoInit: LongInt): HResult; stdcall;
  function MFEnumDeviceSources(pAttributes: IMFAttributes;
                               [ref] const pppSourceActivate: PIMFActivate; // Pointer to array of IMFActivate
                               out pcSourceActivate: Integer): HResult; stdcall;
   function MFCreateSourceReaderFromURL(const pwszURL: LPCWSTR;
                                       pAttributes: IMFAttributes;
                                       out ppSourceReader: IMFSourceReader): HResult; stdcall;
  function MFCreateWaveFormatExFromMFMediaType(pMFType: IMFMediaType; // Pointer to the IMFMediaType interface of the media type.
                                             var ppWF: PWAVEFORMATEX; // Receives a pointer to the WAVEFORMATEX structure. The caller must release the memory allocated for the structure by calling CoTaskMemFree.
                                             out pcbSize: UINT32; // Receives the size of the WAVEFORMATEX structure.
                                             Flags: UINT32 = 0): HResult; stdcall; // Contains a flag from theMFWaveFormatExConvertFlags enumeration.
  function MFTranscodeGetAudioOutputAvailableTypes(const guidSubType: REFGUID;
                                                 dwMFTFlags: DWord;
                                                 pCodecConfig: IMFAttributes;
                                                 out ppAvailableTypes: IMFCollection): HResult; stdcall;

  function MFCreateDeviceSource(pAttributes: IMFAttributes;
                                out ppSource: IMFMediaSource): HResult; stdcall;
  function MFCreateTranscodeTopology(pSrc: IMFMediaSource;
                                     pwszOutputFilePath: LPCWSTR;
                                     pProfile: IMFTranscodeProfile;
                                     out ppTranscodeTopo: IMFTopology): HResult; stdcall;
  {$EXTERNALSYM MFCreateTranscodeTopology}

  function MFCreateSourceResolver(out ppISourceResolver: IMFSourceResolver): HResult; stdcall;
  function MFCreateMediaSession(pConfiguration: IMFAttributes;
                              out ppMediaSession: IMFMediaSession): HResult; stdcall;
  function MFCreateTopology(out ppTopo: IMFTopology): HResult; stdcall;
  function MFCreateTranscodeProfile(out ppTranscodeProfile: IMFTranscodeProfile): HResult; stdcall;
  function GetStreamContents(pspd: IMFPresentationDescriptor;
                           mSource: IMFMediaSource;
                           var alsCont: TStreamContentsArray): HRESULT;
  function GetMediaType(pStreamDesc: IMFStreamDescriptor;
                        out tgMajorGuid: TGuid;
                        out bIsCompressedFormat: BOOL): HRESULT;
  function GetFrameSize(pAttributes: IMFAttributes;
                      out uiWidth: UINT32;
                      out uiHeigth: UINT32): HResult; inline;

  function GetMediaDescription(pMajorGuid: TGuid;
                               out mtMediaType: TMediaTypes): HRESULT;
  function GetAudioSubType(mSource: IMFMediaSource;
                         out pSubType: TGUID;
                         out pFormatTag: DWord;
                         out pDescr: Widestring;
                         out pChannels: UINT32;
                         out pSamplesPerSec: UINT32;
                         out pBitsPerSample: UINT32;
                         out pBlockAlignment: UINT32): HRESULT;
  function GetFrameRate(pType: IMFMediaType;
                      out uiNumerator: UINT32;
                      out uiDenominator: UINT32): HResult; inline;
  function GetPixelAspectRatio(pAttributes: IMFAttributes;
                             out uiNumerator: UINT32;
                             out uiDenominator: UINT32): HResult; inline;
 function MFGetAttributeRatio(pAttributes: IMFAttributes;
                               guidKey: TGUID;
                               out punNumerator: UINT32;
                               out punDenominator: UINT32): HResult; inline;
  function MFGetAttribute2UINT32asUINT64(pAttributes: IMFAttributes;
                                       guidKey: TGUID;
                                       out punHigh32: UINT32;
                                       out punLow32: UINT32): HResult; inline;
  function MFGetAttributeSize(pAttributes: IMFAttributes;
                            guidKey: TGUID;
                            out punWidth: UINT32;
                            out punHeight: UINT32): HResult; inline;
   function MFGetAttributeUINT32(pAttributes: IMFAttributes;
                                guidKey: TGUID;
                                unDefault: UINT32): UINT32; inline;
    procedure Unpack2UINT32AsUINT64(unPacked: UINT64;
                                  out punHigh: UINT32;
                                  out punLow: UINT32); inline;
    function HI32(unPacked: UINT64): UINT32; inline;
    function LO32(unPacked: UINT64): UINT32; inline;
    function MFShutdown(): HRESULT; stdcall;

  const
    MF_RESOLUTION_MEDIASOURCE           = MF_RESOLUTION($1);
    MF_SDK_VERSION                      = $0002;
    MF_EVENT_FLAG_NO_WAIT               = $00000001;
    MF_E_NO_EVENTS_AVAILABLE            = _HRESULT_TYPEDEF_($C00D3E80);
    MF_E_SHUTDOWN                       = _HRESULT_TYPEDEF_($C00D3E85);
    MF_E_NOT_FOUND                      = _HRESULT_TYPEDEF_($C00D36D5);
    MF_E_INVALIDMEDIATYPE               = _HRESULT_TYPEDEF_($C00D36B4);
    MF_E_INVALIDTYPE                    = _HRESULT_TYPEDEF_($C00D36BD);
    CLSID_CColorConvertDMO        :  TGUID = '{98230571-0087-4204-b020-3282538e57d3}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_SYMBOLIC_LINK   : TGUID = '{58f0aad8-22bf-4f8a-bb3d-d2c4978c6e2f}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_AUDCAP_SYMBOLIC_LINK   : TGUID = '{98d24b5e-5930-4614-b5a1-f600f9355a78}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_AUDCAP_ENDPOINT_ID     : TGUID = '{30da9258-feb9-47a7-a453-763a7a8e1c5f}';
    MF_DEVSOURCE_ATTRIBUTE_FRIENDLY_NAME                      : TGUID = '{60d0e559-52f8-4fa2-bbce-acdb34a8ec01}';
    MF_MT_AUDIO_BLOCK_ALIGNMENT                               : TGuid = '{322de230-9eeb-43bd-ab7a-ff412251541d}';
    MF_MT_AUDIO_AVG_BYTES_PER_SECOND                          : TGuid = '{1aab75c8-cfef-451c-ab95-ac034b8e1731}';
    MF_SD_LANGUAGE                                            : TGUID = '{00af2180-bdc2-423c-abca-f503593bc121}';
    MF_SD_STREAM_NAME                                         : TGUID = '{4f1b099d-d314-41e5-a781-7fefaa4c501f}';
    MF_MT_AUDIO_NUM_CHANNELS                                  : TGuid = '{37e48bf5-645e-4c5b-89de-ada9e29b696a}';
    MF_MT_AUDIO_SAMPLES_PER_SECOND                            : TGuid = '{5faeeae7-0290-4c31-9e8a-c534f68d9dba}';
    MF_MT_AUDIO_BITS_PER_SAMPLE                               : TGuid = '{f2deb57f-40fa-4764-aa33-ed4f2d1ff669}';
    MF_TOPONODE_PRESENTATION_DESCRIPTOR                       : TGUID = '{835c58ed-e075-4bc7-bcba-4de000df9ae6}';
    MF_SOURCE_READER_ASYNC_CALLBACK                           : TGUID = '{1e3dbeac-bb43-4c35-b507-cd644464c965}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE                        : TGUID = '{c60ac5fe-252a-478f-a0ef-bc8fa5f7cad3}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_AUDCAP_GUID            : TGUID = '{14dd9a1c-7cff-41be-b1b9-ba1ac6ecb571}';
    MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_GUID            : TGUID = '{8ac3587a-4ae7-42d8-99e0-0a6013eef90f}';
    MF_MT_SUBTYPE                                             : TGuid = '{f7e34c9a-42e8-4714-b74b-cb29d72c35e5}';
    MF_MT_MAJOR_TYPE                                          : TGuid = '{48eba18e-f8c9-4687-bf11-0a74c9f96a8f}';
    MF_MT_AVG_BITRATE                                         : TGuid = '{20332624-fb0d-4d9e-bd0d-cbf6786c102e}';
    MF_MT_FRAME_SIZE                                          : TGuid = '{1652c33d-d6b2-4012-b834-72030849a37d}';
    MF_MT_FRAME_RATE                                          : TGuid = '{c459a2e8-3d2c-4e44-b132-fee5156c7bb0}';
    MF_MT_PIXEL_ASPECT_RATIO                                  : TGuid = '{c6376a1e-8d0a-4027-be45-6d9a0ad39bb6}';
    MF_MT_INTERLACE_MODE                                      : TGuid = '{e2724bb8-e676-4806-b4b2-a8d6efb44ccd}';
    MF_READWRITE_ENABLE_HARDWARE_TRANSFORMS                   : TGUID = '{a634a91c-822b-41b9-a494-4de4643612b0}';
    MF_PD_DURATION                                            : TGUID = '{6c990d33-bb8e-477a-8598-0d5d96fcd88a}';
    MF_TRANSCODE_CONTAINERTYPE                                : TGUID = '{150ff23f-4abc-478b-ac4f-e1916fba1cca}';
    MFTranscodeContainerType_ASF                              : TGUID = '{430f6f6e-b6bf-4fc1-a0bd-9ee46eee2afb}';
    MF_TRANSCODE_ADJUST_PROFILE                               : TGUID = '{9c37c21b-060f-487c-a690-80d7f50d1c72}';
    MFMediaType_Default                                       : TGUID = '{81A412E6-8103-4B06-857F-1862781024AC}';
    MFMediaType_Audio                                         : TGUID = '{73647561-0000-0010-8000-00AA00389B71}';
    MFMediaType_Video                                         : TGUID = '{73646976-0000-0010-8000-00AA00389B71}';
    MFMediaType_Protected                                     : TGUID = '{7b4b6fe6-9d04-4494-be14-7e0bd076c8e4}';
    MFMediaType_SAMI                                          : TGUID = '{e69669a0-3dcd-40cb-9e2e-3708387c0616}';
    MFMediaType_Script                                        : TGUID = '{72178C22-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Image                                         : TGUID = '{72178C23-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_HTML                                          : TGUID = '{72178C24-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Binary                                        : TGUID = '{72178C25-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_FileTransfer                                  : TGUID = '{72178C26-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Stream                                        : TGUID = '{e436eb83-524f-11ce-9f53-0020af0ba770}';
    MFMediaType_MultiplexedFrames                             : TGUID = '{6ea542b0-281f-4231-a464-fe2f5022501c}';
    MFMediaType_Subtitle                                      : TGUID = '{a6d13581-ed50-4e65-ae08-26065576aacc}';
    MFMediaType_Perception                                    : TGUID = '{597ff6f9-6ea2-4670-85b4-ea84073fe940}';
    MF_VERSION                                                = (MF_SDK_VERSION shl 16 or MF_API_VERSION);
    WAVE_FORMAT_MPEGLAYER3            = $0055;  // ISO/MPEG Layer3 Format Tag //
    WAVE_FORMAT_PCM                   = $0001;  // updt 100812
    WAVE_FORMAT_WMAUDIO3              = $0162;  /// Microsoft Corporation /// updt 100812
    MF_SOURCE_READER_FIRST_VIDEO_STREAM    = DWord($fffffffc);
    MF_SOURCE_READER_FIRST_AUDIO_STREAM    = DWord($fffffffd);
    MF_SOURCE_READER_ANY_STREAM            = DWord($fffffffe);
    MF_SOURCE_READER_ALL_STREAMS           = DWord($fffffffe);
    MF_SOURCE_READER_MEDIASOURCE           = MAXDWORD; // $ffffffff;
    MFSESSION_SETTOPOLOGY_IMMEDIATE     = MFSESSION_SETTOPOLOGY_FLAGS($1);
    MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED = MF_SOURCE_READER_FLAG($00000020);
    MF_SOURCE_READERF_ENDOFSTREAM             = MF_SOURCE_READER_FLAG($00000002);
    COINIT_APARTMENTTHREADED = $2;   // Apartment model
    COINIT_DISABLE_OLE1DDE   = $4;   // Don't use DDE for Ole1 support.
    DBT_DEVTYP_DEVICEINTERFACE          = $00000005;  // device interface class
    DBT_DEVICEREMOVECOMPLETE            = $8004;  // device is gone

    KSCATEGORY_VIDEO_CAMERA            : TGUID = '{E5323777-F976-4f5b-9B55-B94699C46E44}';
    MEUnknown                               = MediaEventType(0);
    MEError                                 = MediaEventType(1);
    MEExtendedType                          = MediaEventType(2);
    MENonFatalError                         = MediaEventType(3);
    MESessionTopologySet                    = MediaEventType(101);
    MESessionStarted                        = MediaEventType(103);
    MESessionEnded                          = MediaEventType(107);
    MESessionClosed                         = MediaEventType(106);
    MESourceCharacteristicsChanged          = MediaEventType(219);
    MESourceMetadataChanged                 = MediaEventType(221);
    MEBufferingStarted                      = MediaEventType(122);
    MEBufferingStopped                      = MediaEventType(123);
    MEConnectStart                          = MediaEventType(124);
    MEConnectEnd                            = MediaEventType(125);
    MEGenericV1Anchor                       = MENonFatalError;

    MFWaveFormatExConvertFlag_Normal          = UINT32(0);

    MFT_ENUM_FLAG_SYNCMFT                         = MFT_ENUM_FLAG($00000001);   // Enumerates V1 MFTs. This is default.
    MFT_ENUM_FLAG_ALL                             = MFT_ENUM_FLAG($0000003F);
    MFT_CATEGORY_VIDEO_PROCESSOR        : TGuid = '{302ea3fc-aa5f-47f9-9f7a-c2188bb16302}'; //updt 090812 correct GUID
    ERROR_INVALID_HANDLE_STATE          = 1609;
    ERROR_SYSTEM_DEVICE_NOT_FOUND       = 15299;

    MFVideoFormat_NV12: TGUID = (D1: Ord('N') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24);
                                 D2: $0000;
                                 D3: $0010;
                                 D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YUY2: TGUID = (D1: Ord('Y') or (Ord('U') shl 8) or (Ord('Y') shl 16) or (Ord('2') shl 24);
                                 D2: $0000;
                                 D3: $0010;
                                 D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_UYVY: TGUID = (D1: Ord('U') or (Ord('Y') shl 8) or (Ord('V') shl 16) or (Ord('Y') shl 24);
                                 D2: $0000;
                                 D3: $0010;
                                 D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB32   : TGUID = (D1: $00000016 {D3DFMT_X8R8G8B8};
                                     D2: $0000;
                                     D3: $0010;
                                     D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB24   : TGUID = (D1: $00000014 {D3DFMT_R8G8B8};
                                     D2: $0000;
                                     D3: $0010;
                                     D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
      MFVideoFormat_WMV3: TGUID = (D1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('3') shl 24);
                               D2: $0000;
                               D3: $0010;
                               D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_PCM             : TGUID = (D1: WAVE_FORMAT_PCM;
                                         D2: $0000;
                                         D3: $0010;
                                         D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFAudioFormat_MP3             : TGUID = (D1: WAVE_FORMAT_MPEGLAYER3;
                                         D2: $0000;
                                         D3: $0010;
                                         D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudioV9       : TGUID = (D1: WAVE_FORMAT_WMAUDIO3;
                                           D2: $0000;
                                           D3: $0010;
                                           D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MfApiLibA   = 'Mfplat.dll';
    MfApiLibB   = '';
    MfReadWriteLib = 'mfreadwrite.dll';
    ole32Lib = 'ole32.dll';
    MfIdlLib1 = 'Mf.dll';

  function CreateObjectFromUrl(const sURL: WideString;
                             out pSource: IMFMediaSource;
                             pStore: IPropertyStore = nil;
                             const dwFlags: DWord = MF_RESOLUTION_MEDIASOURCE): HRESULT;

  function MFCreateAttributes;                      external MfApiLibA name 'MFCreateAttributes' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateSourceReaderFromMediaSource;     external MfReadWriteLib name 'MFCreateSourceReaderFromMediaSource' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFTRegisterLocalByCLSID;                 external MfApiLibA name 'MFTRegisterLocalByCLSID' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateMediaType;                       external MfApiLibA name 'MFCreateMediaType' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateSinkWriterFromURL;               external MfReadWriteLib name 'MFCreateSinkWriterFromURL' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function CoInitializeEx;                          external Ole32Lib name 'CoInitializeEx' {delayed};
  function MFStartup;                               external MfApiLibA name 'MFStartup' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFEnumDeviceSources;                     external MfIdlLib1 name 'MFEnumDeviceSources' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateSourceReaderFromURL;             external MfReadWriteLib name 'MFCreateSourceReaderFromURL' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateWaveFormatExFromMFMediaType;     external MfApiLibA name 'MFCreateWaveFormatExFromMFMediaType' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFShutdown;                              external MfApiLibA name 'MFShutdown' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateDeviceSource;                    external MfIdlLib1 name 'MFCreateDeviceSource' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateTranscodeTopology;               external MfIdlLib1 name 'MFCreateTranscodeTopology' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFTranscodeGetAudioOutputAvailableTypes; external MfIdlLib1 name 'MFTranscodeGetAudioOutputAvailableTypes' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateSourceResolver;                  external MfIdlLib1 name 'MFCreateSourceResolver' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateMediaSession;                    external MfIdlLib1 name 'MFCreateMediaSession' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateTopology;                        external MfIdlLib1 name 'MFCreateTopology' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCreateTranscodeProfile;                external MfIdlLib1 name 'MFCreateTranscodeProfile' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
implementation
procedure MFCLOCK_PROPERTIES.Copy(out destProps: MFCLOCK_PROPERTIES);
  begin
    destProps.qwCorrelationRate := qwCorrelationRate;
    destProps.guidClockId := guidClockId;
    destProps.dwClockFlags := dwClockFlags;
    destProps.qwClockFrequency := qwClockFrequency;
    destProps.dwClockTolerance := dwClockTolerance;
    destProps.dwClockJitter := dwClockJitter;
  end;
constructor EOleSysError.Create(const Message: UnicodeString;
  ErrorCode: HRESULT; HelpContext: Integer);
var
  S: string;
begin
  S := Message;
  if S = '' then
  begin
    S := SysErrorMessage(Cardinal(ErrorCode));
    if S = '' then
      FmtStr(S, SOleError, [ErrorCode]);
  end;
  inherited CreateHelp(S, HelpContext);
  FErrorCode := ErrorCode;
end;
procedure OleError(ErrorCode: HResult);
begin
  raise EOleSysError.Create('', ErrorCode, 0);
end;
procedure OleCheck(Result: HResult);
begin
  if not Succeeded(Result) then OleError(Result);
end;
function GetPresentationDescriptorFromTopology(pTopology: IMFTopology;
                                               out ppPD: IMFPresentationDescriptor): HRESULT;
var
  hr: HRESULT;
  pCollection: IMFCollection;
  pUnk: IUnknown;
  pNode: IMFTopologyNode;
  dwElementcount: DWord;
  dwIndex: DWORD;
label
  done;
begin
  dwIndex := 0;
  // Get the collection of source nodes from the topology.
  hr := pTopology.GetSourceNodeCollection(pCollection);
  if FAILED(hr) then
    goto done;
  // Any of the source nodes should have the PD, so take the first
  // object in the collection.
  hr := pCollection.GetElementCount(dwElementcount);
  if FAILED(hr) then
    begin
      OleCheck(hr);
      goto done;
    end;
  if (dwElementcount > 0) then
    begin
      hr := pCollection.GetElement(dwIndex,
                                   pUnk);
      if FAILED(hr) then
        begin
          OleCheck(hr);
          goto done;
        end;
    end
  else
    begin
      hr := MF_E_NOT_FOUND;
      goto done;
    end;
  hr := pUnk.QueryInterface(IID_IMFTopologyNode,
                            pNode);
    if FAILED(hr) then
      goto done;
  // Get the PD, which is stored as an attribute.
  hr := pNode.GetUnknown(MF_TOPONODE_PRESENTATION_DESCRIPTOR,
                         IID_IMFPresentationDescriptor,
                         Pointer(ppPD));
done:
  Result := hr;
end;
function CreateObjectFromUrl(const sURL: WideString;
                             out pSource: IMFMediaSource;
                             pStore: IPropertyStore = nil;
                             const dwFlags: DWord = MF_RESOLUTION_MEDIASOURCE): HRESULT;
var
  ObjectType: MF_OBJECT_TYPE;
  pSourceResolver: IMFSourceResolver;
  unkSource: IUnknown;
  hr: HRESULT;

label
  Done;

begin

  ObjectType := MF_OBJECT_INVALID;

  // Create the source resolver.
  hr := MFCreateSourceResolver(pSourceResolver);
  if (FAILED(hr)) then
    goto done;

  // Use the source resolver to create the media source.
  // Note: For simplicity this function uses the synchronous method on
  // IMFSourceResolver to create the media source. However, creating a media
  // source can take a noticeable amount of time, especially for a network source.
  // For a more responsive UI, use the asynchronous BeginCreateObjectFromURL method.

  hr := pSourceResolver.CreateObjectFromURL(LPCWSTR(sURL), // URL of the source.
                                            dwFlags,       // Create a source object.
                                            pStore,        // Optional property store.
                                            ObjectType,    // Receives the created object type.
                                            unkSource);    // Receives a pointer to the media source (IUnknown).
  if (FAILED(hr)) then
    goto done;



  // Get the IMFMediaSource interface from the media source.
  hr := unkSource.QueryInterface(IUnknown,
                                 pSource);

  // This will work as well: pSource := IMFMediaSource(unkSource);

Done:
  // unlike C/CPP Delphi cleans up all interfaces when going out of scope.
  Result := hr;
end;
// Shows how to get the media type handler, enumerate the preferred media types, and set the media type.
function GetMediaType(pStreamDesc: IMFStreamDescriptor;
                      out tgMajorGuid: TGuid;
                      out bIsCompressedFormat: BOOL): HRESULT;
var
  hr: HRESULT;
  cTypes: DWORD;
  pHandler: IMFMediaTypeHandler;
  pMediaType: IMFMediaType;
  iType: DWORD;
begin
  cTypes := 0;
  tgMajorGuid := GUID_NULL;
  hr := pStreamDesc.GetMediaTypeHandler(pHandler);
  if SUCCEEDED(hr) then
    hr := pHandler.GetMediaTypeCount(cTypes);
  if SUCCEEDED(hr) then
    begin
      for iType := 0 to cTypes -1 do
        begin
          hr := pHandler.GetMediaTypeByIndex(iType,
                                             pMediaType);
          if FAILED(hr) then
            break;
          // Examine the media type.
          // here you have to examine the GetMajorType method
          // for major types that will give you information about video, audio etc.
          hr := pMediaType.GetMajorType(tgMajorGuid);
          // Check if it's a compressed format.
          if SUCCEEDED(hr) then
            hr := pMediaType.IsCompressedFormat(bIsCompressedFormat);
          // SafeRelease(pMediaType);
        end;
   end;
 Result := hr;
end;
function GetMediaDescription(pMajorGuid: TGuid;
                             out mtMediaType: TMediaTypes): HRESULT;
var
  hr: HRESULT;
begin
  hr := S_OK;
  if isEqualGuid(pMajorGuid, MFMediaType_Default) then
    mtMediaType := mtDefault
  else if isEqualGuid(pMajorGuid, MFMediaType_Audio) then
    mtMediaType := mtAudio
  else if isEqualGuid(pMajorGuid, MFMediaType_Video) then
    mtMediaType := mtVideo
  else if isEqualGuid(pMajorGuid, MFMediaType_Protected) then
    mtMediaType := mtProtectedMedia
  else if isEqualGuid(pMajorGuid, MFMediaType_SAMI) then
    mtMediaType := mtSAMI
  else if isEqualGuid(pMajorGuid, MFMediaType_Script) then
    mtMediaType := mtScript
  else if isEqualGuid(pMajorGuid, MFMediaType_Image) then
    mtMediaType := mtStillImage
  else if isEqualGuid(pMajorGuid, MFMediaType_HTML) then
    mtMediaType := mtHTML
  else if isEqualGuid(pMajorGuid, MFMediaType_Binary) then
    mtMediaType := mtBinary
  else if isEqualGuid(pMajorGuid, MFMediaType_FileTransfer) then
    mtMediaType := mtFileTransfer
  else if isEqualGuid(pMajorGuid, MFMediaType_Stream) then
    mtMediaType := mtStream
  else if isEqualGuid(pMajorGuid, MFMediaType_MultiplexedFrames) then
    mtMediaType := mtMultiplexedFrames
  else if isEqualGuid(pMajorGuid, MFMediaType_Subtitle) then
    mtMediaType := mtSubTitle
  else if isEqualGuid(pMajorGuid, MFMediaType_Perception) then
    mtMediaType := mtPerception
  else
    begin
      mtMediaType := mtUnknown;
      hr := MF_E_INVALIDMEDIATYPE;
    end;
  Result := hr;
end;
function GetStreamContents(pspd: IMFPresentationDescriptor;
                           mSource: IMFMediaSource;
                           var alsCont: TStreamContentsArray): HRESULT;
var
  hr: HRESULT;
  i: Integer;
  pSourceSD: IMFStreamDescriptor;
  pMediaTypeHandler: IMFMediaTypeHandler;
  pMediaType: IMFMediaType;
  pwszValue: LPWSTR;
  pcchLength,
  uiNumerator,
  uiDenominator,
  uiHeigth,
  uiWidth: UINT32;
  sdCount: DWORD;
begin
  SetLength(alsCont, 0);
  sdCount := 0;
  pcchLength := 0;
  hr := S_OK;
try
try
  // Check if IMFPresentationDescriptor is initialized
  if assigned(pspd) then
    begin
      // Count streams
      hr := pspd.GetStreamDescriptorCount(sdCount);
      SetLength(alsCont,
                sdCount);
      for i := 0 to sdCount - 1 do
        begin
           // Initialize the record
           alsCont[i].Reset();
           // Store the stream index
           alsCont[i].dwStreamIndex := i;
          // Get stream descriptor interface
          hr := pspd.GetStreamDescriptorByIndex(i,                    // Zero-based index of the stream.
                                                alsCont[i].bSelected, // TRUE if the stream is currently selected, FALSE if the stream is currently deselected.
                                                pSourceSD);           // Receives a pointer to the stream descriptor's IMFStreamDescriptor interface. The caller must release the interface.
          // Store the streamID
          if SUCCEEDED(hr) then
            pSourceSD.GetStreamIdentifier(alsCont[i].dwStreamId);
          // Get the media major type
          if SUCCEEDED(hr) then
            hr := GetMediaType(pSourceSD,
                               alsCont[i].idStreamMajorTypeGuid,
                               alsCont[i].bCompressed);

          // Figure out what media type we are dealing with
          if SUCCEEDED(hr) then
            hr := GetMediaDescription(alsCont[i].idStreamMajorTypeGuid,
                                      alsCont[i].idStreamMediaType);

          // If audio stream then try to get the language of this stream
          if SUCCEEDED(hr) and (alsCont[i].idStreamMediaType = mtAudio) then
            begin
              // Get the audio format type and qualities
              hr := GetAudioSubType(mSource,
                                    alsCont[i].idStreamSubTypeGuid,
                                    alsCont[i].audio_dwFormatTag,
                                    alsCont[i].audio_wsAudioDescr,
                                    alsCont[i].audio_iAudioChannels,
                                    alsCont[i].audio_iSamplesPerSec,
                                    alsCont[i].audio_iBitsPerSample,
                                    alsCont[i].audio_iblockAlignment);

              // Retrieves a wide-character string associated with a key (MF_SD_LANGUAGE).
              // This method allocates the memory for the string.
              // A returnvalue of -1072875802 / $C00D36E6
              // (The requested attribute was not found.) is returned when no language information was found.
              hr := pSourceSD.GetAllocatedString(MF_SD_LANGUAGE,
                                                 pwszValue,
                                                 pcchLength);

              if SUCCEEDED(hr) then
                alsCont[i].audio_lpLangShortName := pwszValue
              else
                begin
                  alsCont[i].audio_lpLangShortName := 'Not available';
                  hr := S_OK;
                end;
            end;
          pwszValue := nil;
          pcchLength := 0;
          // Retrieves a wide-character string associated with a key (MF_SD_STREAM_NAME)
          // If a stream is not provided with a name the Hresult will be MF_E_ATTRIBUTENOTFOUND.
          hr := pSourceSD.GetAllocatedString(MF_SD_STREAM_NAME,
                                             pwszValue,
                                             pcchLength);
          if SUCCEEDED(hr) then
            alsCont[i].audio_lpStreamName := pwszValue
          else
            begin
              alsCont[i].audio_lpStreamName := 'Not available';
              hr := S_OK;
            end;
          // Note:
          // Set your initial preffered language somewhere in the caller.
          // hr := pspd.DeselectStream(dwDescriptorIndex);
          //
          // hr := pspd.SelectStream(iMySelectedLanguage);
          // finally set the new topology.
          // If video stream then try to get the properties of this stream
          if SUCCEEDED(hr) and (alsCont[i].idStreamMediaType = mtVideo) then
            begin
              hr := pSourceSD.GetMediaTypeHandler(pMediaTypeHandler);
              hr := pMediaTypeHandler.GetCurrentMediaType(pMediaType);
              // Get the video frame rate
              // To calculate the framerate in FPS : uiNumerator / uiDenominator
              hr := GetFrameRate(pMediaType,
                                 uiNumerator,
                                 uiDenominator);
              alsCont[i].video_FrameRateNumerator := uiNumerator;
              alsCont[i].video_FrameRateDenominator := uiDenominator;
              // Get the pixel aspect ratio
              // To calculate the pixel aspect ratio: uiNumerator / uiDenominator
              hr := GetPixelAspectRatio(pMediaType,
                                        uiNumerator,
                                        uiDenominator);
              alsCont[i].video_PixelAspectRatioNumerator := uiNumerator;
              alsCont[i].video_PixelAspectRatioDenominator := uiDenominator;
              // Get the video frame size
              hr := GetFrameSize(pMediaType,
                                 uiWidth,
                                 uiHeigth);
              alsCont[i].video_FrameSizeWidth := uiWidth;
              alsCont[i].video_FrameSizeHeigth := uiHeigth;
            end;
        end;
    end;
except
  hr := E_POINTER;
end;
finally
  CoTaskMemFree(pwszValue);
  Result := hr;
end;
end;
function GetAudioSubType(mSource: IMFMediaSource;
                         out pSubType: TGUID;
                         out pFormatTag: DWord;
                         out pDescr: Widestring;
                         out pChannels: UINT32;
                         out psamplesPerSec: UINT32;
                         out pbitsPerSample: UINT32;
                         out pBlockAlignment: UINT32): HRESULT;
var
  hr: HResult;
  majortype: TGUID;
  subtype: TGUID;
  pPD: IMFPresentationDescriptor;
  pSD: IMFStreamDescriptor;
  pHandler: IMFMediaTypeHandler;
  mfType: IMFMediaType;
  cTypes: DWORD;
  i, j: DWORD;
  bSelected: BOOL;
  sGuid: string;
  sDescr: Widestring;
label done;
begin
  majortype := GUID_NULL;
  subtype := GUID_NULL;
  pSubType := subtype;
  pChannels := 0;
  pSamplesPerSec := 0;
  pBitsPerSample := 0;
  pBlockAlignment := 0;
  cTypes := 0;
  i := 0;
  //
  repeat
  sGuid := '';
  sDescr := '';
  hr := mSource.CreatePresentationDescriptor(pPD);
  if FAILED(hr) then
    goto done;
  hr := pPD.GetStreamDescriptorByIndex(i,
                                       bSelected,
                                       pSD);
  if FAILED(hr) then
    goto done;
  hr := pSD.GetMediaTypeHandler(pHandler);
  if FAILED(hr) then
    goto done;
  hr := pHandler.GetMediaTypeCount(cTypes);
  if FAILED(hr) then
    goto done;
  // find the proper subtype
  for j := 0 to cTypes-1 do
    begin
      hr := pHandler.GetMediaTypeByIndex(j,
                                         mfType);
      if FAILED(hr) then
        goto done;
      hr := mfType.GetMajorType(majortype);
        if (FAILED(hr)) then
          goto done;
      if IsEqualGuid(majortype,
                     MFMediaType_Audio) then
        begin
          // Get the audio subtype. If not, skip.
          hr := mfType.GetGUID(MF_MT_SUBTYPE,
                               subtype);
          if (FAILED(hr)) then
            goto done;
          // readable audiosubtype guid
          sGuid := GuidToString(subtype);
          // Get description by guid   (this is just a short list of most common audioformats)

          pSubType := subtype;
          sGuid := ' ( GUID: ' + sGuid + ' )';
          pDescr := sDescr + sGuid;

          // Get a brief information from the audio format.
          pChannels := MFGetAttributeUINT32(mfType,
                                            MF_MT_AUDIO_NUM_CHANNELS,
                                            0);
          pSamplesPerSec := MFGetAttributeUINT32(mfType,
                                                MF_MT_AUDIO_SAMPLES_PER_SECOND,
                                                0);
          pBitsPerSample := MFGetAttributeUINT32(mfType,
                                                 MF_MT_AUDIO_BITS_PER_SAMPLE,
                                                 16);
          // Note: Some encoded audio formats do not cosntain a value for bits/sample.
          // In that case, use a default value of 16. Most codecs will accept this value.
          if (pChannels = 0) or (pSamplesPerSec = 0) then
            begin
              hr := MF_E_INVALIDTYPE;
              goto done;
            end;
        end; //if mediatype = audio
     end; //end if
      pPD := nil;
      pSD := nil;
      pHandler := nil;
      mfType := nil;
      inc(i);
   until (i > cTypes);  // end repeat
done:
  Result := hr;
end;
function GetFrameRate(pType: IMFMediaType;
                      out uiNumerator: UINT32;
                      out uiDenominator: UINT32): HResult; inline;
begin
  Result := MFGetAttributeRatio(pType,
                                MF_MT_FRAME_RATE,
                                uiNumerator,
                                uiDenominator);
end;
function GetPixelAspectRatio(pAttributes: IMFAttributes;
                             out uiNumerator: UINT32;
                             out uiDenominator: UINT32): HResult; inline;
begin
  Result := MFGetAttributeRatio(pAttributes,
                                MF_MT_PIXEL_ASPECT_RATIO,
                                uiNumerator,
                                uiDenominator);
end;
function MFGetAttributeRatio(pAttributes: IMFAttributes;
                             guidKey: TGUID;
                             out punNumerator: UINT32;
                             out punDenominator: UINT32): HResult;
begin
  Result := MFGetAttribute2UINT32asUINT64(pAttributes,
                                          guidKey,
                                          punNumerator,
                                          punDenominator);
end;
function GetFrameSize(pAttributes: IMFAttributes;
                      out uiWidth: UINT32;
                      out uiHeigth: UINT32): HResult; inline;
begin
  Result := MFGetAttributeSize(pAttributes,
                               MF_MT_FRAME_SIZE,
                               uiWidth,
                               uiHeigth);
end;
function MFGetAttributeSize(pAttributes: IMFAttributes;
                            guidKey: TGUID;
                            out punWidth: UINT32;
                            out punHeight: UINT32): HResult;
begin
  Result := MFGetAttribute2UINT32asUINT64(pAttributes,
                                          guidKey,
                                          punWidth,
                                          punHeight);
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

function MFGetAttribute2UINT32asUINT64(pAttributes: IMFAttributes;
                                       guidKey: TGUID;
                                       out punHigh32: UINT32;
                                       out punLow32: UINT32): HResult;
var
  unPacked: UInt64;
  hr: HRESULT;
begin
  hr := pAttributes.GetUINT64(guidKey,
                              unPacked);
  if (FAILED(hr)) then
    begin
      Result := hr;
      Exit;
    end;
  Unpack2UINT32AsUINT64(unPacked,
                        punHigh32,
                        punLow32);
  Result := hr;
end;
procedure Unpack2UINT32AsUINT64(unPacked: UINT64;
                                out punHigh: UINT32;
                                out punLow: UINT32);
begin
  punHigh := HI32(unPacked);
  punLow := LO32(unPacked);
end;
function HI32(unPacked: UINT64): UINT32;
begin
  Result := unPacked shr 32;
end;
function LO32(unPacked: UINT64): UINT32;
begin
  Result := unPacked and $0ffffffff;
end;
procedure TStreamContents.Reset();
begin
  dwStreamIndex := 0;
  dwStreamID := 0;
  idStreamMediaType := mtUnknown;
  idStreamMajorTypeGuid := Guid_Null;
  idStreamSubTypeGuid := Guid_Null;
  bSelected := False;
  bCompressed := False;
  video_FrameRateNumerator := 0;
  video_FrameRateDenominator := 0;
  video_PixelAspectRatioNumerator := 0;
  video_PixelAspectRatioDenominator := 0;
  video_FrameSizeHeigth := 0;
  video_FrameSizeWidth := 0;
  audio_lpLangShortName := nil;
  audio_lpLangFullName := nil;
  audio_wsAudioDescr := '';
  audio_iAudioChannels := 0;
  audio_iSamplesPerSec := 0;
  audio_iBitsPerSample := 0;
  audio_dwFormatTag := 0;
end;
end.
