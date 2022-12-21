unit ApiObjects;

interface


type

  _MF_ATTRIBUTE_TYPE = (
    MF_ATTRIBUTE_UINT32   = VT_UI4,
    MF_ATTRIBUTE_UINT64   = VT_UI8,
    MF_ATTRIBUTE_DOUBLE   = VT_R8,
    MF_ATTRIBUTE_GUID     = VT_CLSID,
    MF_ATTRIBUTE_STRING   = VT_LPWSTR,
    MF_ATTRIBUTE_BLOB     = (VT_VECTOR or VT_UI1),
    MF_ATTRIBUTE_IUNKNOWN = VT_UNKNOWN
  );
  MF_ATTRIBUTE_TYPE = _MF_ATTRIBUTE_TYPE;


  PMF_ATTRIBUTES_MATCH_TYPE = ^_MF_ATTRIBUTES_MATCH_TYPE;
  _MF_ATTRIBUTES_MATCH_TYPE = (
    MF_ATTRIBUTES_MATCH_OUR_ITEMS    = 0,    // do all of our items exist in their store and have identical data?
    MF_ATTRIBUTES_MATCH_THEIR_ITEMS  = 1,    // do all of their items exist in our store and have identical data?
    MF_ATTRIBUTES_MATCH_ALL_ITEMS    = 2,    // do both stores have the same set of identical items?
    MF_ATTRIBUTES_MATCH_INTERSECTION = 3,    // do the attributes that intersect match?
    MF_ATTRIBUTES_MATCH_SMALLER      = 4     // do all the attributes in the type that has fewer attributes match?
    );

  MF_ATTRIBUTES_MATCH_TYPE = _MF_ATTRIBUTES_MATCH_TYPE;



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
  IID_IMFAttributes = IMFAttributes;




  PIMFActivate = ^IMFActivate;
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMFActivate);'}
  {$EXTERNALSYM IMFActivate}
  IMFActivate = interface(IMFAttributes)


    function ActivateObject(const riid: REFIID;
                            out ppv: LPVOID): HResult; stdcall;
    function ShutdownObject(): HResult; stdcall;
    function DetachObject(): HResult; stdcall;

   end;

  IID_IMFActivate = IMFActivate;




implementation

end.
