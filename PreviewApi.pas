unit PreviewApi;

interface

uses
  apiobjects,
  Winapi.Windows;

const
 MAX_DEVICE_IDENTIFIER_STRING        = 512;


type
 PIDirect3DDevice9 = ^IDirect3DDevice9;
 IDirect3DDevice9 = interface;

 PIDirect3DSurface9 = ^IDirect3DSurface9;
 IDirect3DSurface9 = interface;

 PIDirect3DSwapChain9 = ^IDirect3DSwapChain9;
 IDirect3DSwapChain9 = interface;

 PIDirect3DBaseTexture9 = ^IDirect3DBaseTexture9;
 IDirect3DBaseTexture9 = interface;

 PD3DPRIMITIVETYPE = ^D3DPRIMITIVETYPE;
_D3DPRIMITIVETYPE = DWord;
 D3DPRIMITIVETYPE = _D3DPRIMITIVETYPE;

 PD3DRENDERSTATETYPE = ^D3DRENDERSTATETYPE;
 _D3DRENDERSTATETYPE = DWord;
 D3DRENDERSTATETYPE = _D3DRENDERSTATETYPE;

 PIDirect3DVertexDeclaration9 = ^IDirect3DVertexDeclaration9;
 IDirect3DVertexDeclaration9 = interface;

 PIDirect3DVertexBuffer9 = ^IDirect3DVertexBuffer9;
 IDirect3DVertexBuffer9 = interface;

 PIDirect3DTexture9 = ^IDirect3DTexture9;
 IDirect3DTexture9 = interface;

 PIDirect3DVolumeTexture9 = ^IDirect3DVolumeTexture9;
 IDirect3DVolumeTexture9 = interface;

 PIDirect3DCubeTexture9 = ^IDirect3DCubeTexture9;
 IDirect3DCubeTexture9 = interface;

 PIDirect3DIndexBuffer9 = ^IDirect3DIndexBuffer9;
 IDirect3DIndexBuffer9 = interface;

 PIDirect3DStateBlock9 = ^IDirect3DStateBlock9;
 IDirect3DStateBlock9 = interface;

 PIDirect3DPixelShader9 = ^IDirect3DPixelShader9;
 IDirect3DPixelShader9 = interface;

 PIDirect3DQuery9 = ^IDirect3DQuery9;
 IDirect3DQuery9 = interface;

 PIDirect3DResource9 = ^IDirect3DResource9;
 IDirect3DResource9 = interface;

 PIDirect3DVolume9 = ^IDirect3DVolume9;
 IDirect3DVolume9 = interface;

 PD3DFORMAT = ^_D3DFORMAT;
  _D3DFORMAT = DWord;
 D3DFORMAT = _D3DFORMAT;

 PD3DQUERYTYPE = ^_D3DQUERYTYPE;
 _D3DQUERYTYPE = DWord;
 D3DQUERYTYPE = _D3DQUERYTYPE;
 D3DCOLOR = DWORD;
 PINT = ^INT;
 INT = Integer;

 PD3DTEXTUREFILTERTYPE = ^_D3DTEXTUREFILTERTYPE;
 _D3DTEXTUREFILTERTYPE = DWord;
 D3DTEXTUREFILTERTYPE = _D3DTEXTUREFILTERTYPE;

 PD3DTEXTURESTAGESTATETYPE = ^_D3DTEXTURESTAGESTATETYPE;
 _D3DTEXTURESTAGESTATETYPE = DWord;
 D3DTEXTURESTAGESTATETYPE = _D3DTEXTURESTAGESTATETYPE;

 PD3DTRANSFORMSTATETYPE = ^D3DTRANSFORMSTATETYPE;
 _D3DTRANSFORMSTATETYPE = DWord;
 D3DTRANSFORMSTATETYPE = _D3DTRANSFORMSTATETYPE;
 PD3DSAMPLERSTATETYPE = ^_D3DSAMPLERSTATETYPE;
 _D3DSAMPLERSTATETYPE = DWord;
 D3DSAMPLERSTATETYPE = _D3DSAMPLERSTATETYPE;

  PMFVideoInterlaceMode = ^MFVideoInterlaceMode;
  _MFVideoInterlaceMode = UINT32;
  MFVideoInterlaceMode = _MFVideoInterlaceMode;

  PD3DLOCKED_RECT = ^_D3DLOCKED_RECT;
  _D3DLOCKED_RECT = record
    Pitch: Integer;
    pBits: Pointer;
  end;
  D3DLOCKED_RECT = _D3DLOCKED_RECT;

    PD3DVSHADERCAPS2_0 = ^D3DVSHADERCAPS2_0;
  _D3DVSHADERCAPS2_0 = record
    Caps: DWORD;
    DynamicFlowControlDepth: Integer;
    NumTemps: Integer;
    StaticFlowControlDepth: Integer;
  end;
  {$EXTERNALSYM _D3DVSHADERCAPS2_0}
  D3DVSHADERCAPS2_0 = _D3DVSHADERCAPS2_0;
  {$EXTERNALSYM D3DVSHADERCAPS2_0}

  PD3DPSHADERCAPS2_0 = ^D3DPSHADERCAPS2_0;
  _D3DPSHADERCAPS2_0 = record
    Caps: DWORD;
    DynamicFlowControlDepth: Integer;
    NumTemps: Integer;
    StaticFlowControlDepth: Integer;
    NumInstructionSlots: Integer;
  end;
  {$EXTERNALSYM _D3DPSHADERCAPS2_0}
  D3DPSHADERCAPS2_0 = _D3DPSHADERCAPS2_0;
  {$EXTERNALSYM D3DPSHADERCAPS2_0}

  PD3DMULTISAMPLE_TYPE = ^D3DMULTISAMPLE_TYPE;
  _D3DMULTISAMPLE_TYPE         = (
    D3DMULTISAMPLE_NONE        = 0,
    D3DMULTISAMPLE_NONMASKABLE = 1,
    D3DMULTISAMPLE_2_SAMPLES   = 2,
    D3DMULTISAMPLE_3_SAMPLES   = 3,
    D3DMULTISAMPLE_4_SAMPLES   = 4,
    D3DMULTISAMPLE_5_SAMPLES   = 5,
    D3DMULTISAMPLE_6_SAMPLES   = 6,
    D3DMULTISAMPLE_7_SAMPLES   = 7,
    D3DMULTISAMPLE_8_SAMPLES   = 8,
    D3DMULTISAMPLE_9_SAMPLES   = 9,
    D3DMULTISAMPLE_10_SAMPLES  = 10,
    D3DMULTISAMPLE_11_SAMPLES  = 11,
    D3DMULTISAMPLE_12_SAMPLES  = 12,
    D3DMULTISAMPLE_13_SAMPLES  = 13,
    D3DMULTISAMPLE_14_SAMPLES  = 14,
    D3DMULTISAMPLE_15_SAMPLES  = 15,
    D3DMULTISAMPLE_16_SAMPLES  = 16,
    D3DMULTISAMPLE_FORCE_DWORD = $7FFFFFFF
  );
  {$EXTERNALSYM _D3DMULTISAMPLE_TYPE}
  D3DMULTISAMPLE_TYPE = _D3DMULTISAMPLE_TYPE;
  {$EXTERNALSYM D3DMULTISAMPLE_TYPE}

   PD3DDEVTYPE = ^D3DDEVTYPE;
  _D3DDEVTYPE              = (
    D3DDEVTYPE_HAL         = 1,
    D3DDEVTYPE_REF         = 2,
    D3DDEVTYPE_SW          = 3,
    D3DDEVTYPE_NULLREF     = 4,
    D3DDEVTYPE_FORCE_DWORD = $7FFFFFFF
  );
  {$EXTERNALSYM _D3DDEVTYPE}
  D3DDEVTYPE = _D3DDEVTYPE;
  {$EXTERNALSYM D3DDEVTYPE}

  // back buffer types */
  PD3DBACKBUFFER_TYPE = ^_D3DBACKBUFFER_TYPE;
  {$EXTERNALSYM _D3DBACKBUFFER_TYPE}
  {$EXTERNALSYM _D3DBACKBUFFER_TYPE}
  _D3DBACKBUFFER_TYPE              = (
    D3DBACKBUFFER_TYPE_MONO        = 0,
    D3DBACKBUFFER_TYPE_LEFT        = 1,
    D3DBACKBUFFER_TYPE_RIGHT       = 2,
    D3DBACKBUFFER_TYPE_FORCE_DWORD = $7FFFFFFF
  );
  D3DBACKBUFFER_TYPE = _D3DBACKBUFFER_TYPE;
  {$EXTERNALSYM D3DBACKBUFFER_TYPE}

  PD3DDEVICE_CREATION_PARAMETERS = ^_D3DDEVICE_CREATION_PARAMETERS;
  _D3DDEVICE_CREATION_PARAMETERS = record
    AdapterOrdinal: UINT;
    DeviceType: D3DDEVTYPE;
    hFocusWindow: HWND;
    BehaviorFlags: DWORD;
  end;
  {$EXTERNALSYM _D3DDEVICE_CREATION_PARAMETERS}
  D3DDEVICE_CREATION_PARAMETERS = _D3DDEVICE_CREATION_PARAMETERS;
  {$EXTERNALSYM D3DDEVICE_CREATION_PARAMETERS}

  PD3DSTATEBLOCKTYPE = ^_D3DSTATEBLOCKTYPE;
  _D3DSTATEBLOCKTYPE   = (
    D3DSBT_ALL         = 1,                 // capture all state
    D3DSBT_PIXELSTATE  = 2,                 // capture pixel state
    D3DSBT_VERTEXSTATE = 3,                 // capture vertex state
    D3DSBT_FORCE_DWORD = $7FFFFFFF
  );
  D3DSTATEBLOCKTYPE = _D3DSTATEBLOCKTYPE;

  PD3DRESOURCETYPE = ^_D3DRESOURCETYPE;
  _D3DRESOURCETYPE         = (
    D3DRTYPE_SURFACE       = 1,
    D3DRTYPE_VOLUME        = 2,
    D3DRTYPE_TEXTURE       = 3,
    D3DRTYPE_VOLUMETEXTURE = 4,
    D3DRTYPE_CUBETEXTURE   = 5,
    D3DRTYPE_VERTEXBUFFER  = 6,
    D3DRTYPE_INDEXBUFFER   = 7,   // if this changes, change _D3DDEVINFO_RESOURCEMANAGER definition
    D3DRTYPE_FORCE_DWORD   = $7FFFFFFF
  );
  D3DRESOURCETYPE = _D3DRESOURCETYPE;


  PD3DVIEWPORT9 = ^D3DVIEWPORT9;
  _D3DVIEWPORT9 = record
    X: DWORD;
    Y: DWORD;                        { Viewport Top left }
    Width: DWORD;
    Height: DWORD;                   { Viewport Dimensions }
    MinZ: Single;                     { Min/max of clip Volume }
    MaxZ: Single;
  end;
  D3DVIEWPORT9 = _D3DVIEWPORT9;

  PD3DPOOL = ^_D3DPOOL;
  _D3DPOOL              = (
    D3DPOOL_DEFAULT     = 0,
    D3DPOOL_MANAGED     = 1,
    D3DPOOL_SYSTEMMEM   = 2,
    D3DPOOL_SCRATCH     = 3,
    D3DPOOL_FORCE_DWORD = $7FFFFFFF
  );
  D3DPOOL = _D3DPOOL;
  PD3DVERTEXBUFFER_DESC = ^_D3DVERTEXBUFFER_DESC;
  _D3DVERTEXBUFFER_DESC = record
    Format: D3DFORMAT;
    _Type: D3DRESOURCETYPE;
    Usage: DWORD;
    Pool: D3DPOOL;
    Size: UINT;
    FVF: DWORD;
  end;
  D3DVERTEXBUFFER_DESC = _D3DVERTEXBUFFER_DESC;
  PD3DBASISTYPE = ^_D3DBASISTYPE;
  _D3DBASISTYPE         = (
   D3DBASIS_BEZIER      = 0,
   D3DBASIS_BSPLINE     = 1,
   D3DBASIS_CATMULL_ROM = 2,   { In D3D8 this used to be D3DBASIS_INTERPOLATE }
   D3DBASIS_FORCE_DWORD = $7FFFFFFF
  );
  D3DBASISTYPE = _D3DBASISTYPE;

  PD3DDEGREETYPE = ^_D3DDEGREETYPE;
  _D3DDEGREETYPE          = (
    D3DDEGREE_LINEAR      = 1,
    D3DDEGREE_QUADRATIC   = 2,
    D3DDEGREE_CUBIC       = 3,
    D3DDEGREE_QUINTIC     = 5,
    D3DDEGREE_FORCE_DWORD = $7FFFFFFF
  );
  D3DDEGREETYPE = _D3DDEGREETYPE;
  PD3DRECTPATCH_INFO = ^_D3DRECTPATCH_INFO;
  _D3DRECTPATCH_INFO = record
    StartVertexOffsetWidth: UINT;
    StartVertexOffsetHeight: UINT;
    Width: UINT;
    Height: UINT;
    Stride: UINT;
    Basis: D3DBASISTYPE;
    Degree: D3DDEGREETYPE;
  end;
  D3DRECTPATCH_INFO = _D3DRECTPATCH_INFO;

  P3DGAMMARAMP = ^_D3DGAMMARAMP;
  _D3DGAMMARAMP = record
    red: array[0..255] of WORD;
    green: array[0..255] of WORD;
    blue: array[0..255] of WORD;
  end;
  {$EXTERNALSYM _D3DGAMMARAMP}
  D3DGAMMARAMP = _D3DGAMMARAMP;
  {$EXTERNALSYM D3DGAMMARAMP}

  PD3DADAPTER_IDENTIFIER9 = ^_D3DADAPTER_IDENTIFIER9;
  _D3DADAPTER_IDENTIFIER9 = record
    Driver: array[0..MAX_DEVICE_IDENTIFIER_STRING - 1] of AnsiChar;
    Description: array[0..MAX_DEVICE_IDENTIFIER_STRING - 1] of AnsiChar;
    DeviceName: array[0..31] of AnsiChar;  { Device name for GDI (ex. \\.\DISPLAY1) }
    //#ifdef _WIN32
    DriverVersion: LARGE_INTEGER;          { Defined for 32 bit components }
    //#else
    DriverVersionLowPart: DWORD;           { Defined for 16 bit driver components }
    DriverVersionHighPart: DWORD;
    //#endif
    VendorId: DWORD;
    DeviceId: DWORD;
    SubSysId: DWORD;
    Revision: DWORD;
    DeviceIdentifier: TGUID;
    WHQLLevel: DWORD;
  end;
  {$EXTERNALSYM _D3DADAPTER_IDENTIFIER9}
  D3DADAPTER_IDENTIFIER9 = _D3DADAPTER_IDENTIFIER9;
  {$EXTERNALSYM D3DADAPTER_IDENTIFIER9}

  PD3DVERTEXELEMENT9 = ^D3DVERTEXELEMENT9;
  _D3DVERTEXELEMENT9 = record
    Stream: WORD;                    // Stream index
    Offset: WORD;                    // Offset in the stream in bytes
    _Type: Byte;                     // Data type
    Method: Byte;                    // Processing method
    Usage: Byte;                     // Semantics
    UsageIndex: Byte;                // Semantic index
  end;
  D3DVERTEXELEMENT9 = _D3DVERTEXELEMENT9;

  PMFRatio = ^MFRatio;
  _MFRatio = record
    Numerator: DWORD;
    Denominator: DWORD;
  end;
  {$EXTERNALSYM _MFRatio}
  MFRatio = _MFRatio;
  {$EXTERNALSYM MFRatio}

    PD3DSWAPEFFECT = ^_D3DSWAPEFFECT;
  _D3DSWAPEFFECT              = (
    D3DSWAPEFFECT_DISCARD     = 1,
    D3DSWAPEFFECT_FLIP        = 2,
    D3DSWAPEFFECT_COPY        = 3,
    //* D3D9Ex only -- */
    //{$IFDEF D3D_DISABLE_9EX}
    D3DSWAPEFFECT_OVERLAY     = 4,
    D3DSWAPEFFECT_FLIPEX      = 5,
    //{$ENDIF} // !D3D_DISABLE_9EX
    //* -- D3D9Ex only */
    D3DSWAPEFFECT_FORCE_DWORD = $7FFFFFFF
  );
  {$EXTERNALSYM _D3DSWAPEFFECT}
  D3DSWAPEFFECT = _D3DSWAPEFFECT;
  {$EXTERNALSYM D3DSWAPEFFECT}

  PD3DRECT = ^D3DRECT;
  _D3DRECT = record
    x1: LONG;
    y1: LONG;
    x2: LONG;
    y2: LONG;
  end;
  D3DRECT = _D3DRECT;

  PD3DRASTER_STATUS = ^_D3DRASTER_STATUS;
  _D3DRASTER_STATUS = record
    InVBlank: BOOL;
    ScanLine: UINT;
  end;
  D3DRASTER_STATUS = _D3DRASTER_STATUS;
  PD3DMATRIX = ^D3DMATRIX;
  _D3DMATRIX = record
    _11, _12, _13, _14: Single;
    _21, _22, _23, _24: Single;
    _31, _32, _33, _34: Single;
    _41, _42, _43, _44: Single;
  end;
 D3DMATRIX = _D3DMATRIX;
  PD3DCOLORVALUE = ^D3DCOLORVALUE;
  _D3DCOLORVALUE = record
    r: Single;
    g: Single;
    b: Single;
    a: Single;
  end;
  D3DCOLORVALUE = _D3DCOLORVALUE;
 PD3DMATERIAL9 = ^D3DMATERIAL9;
 _D3DMATERIAL9 = record
  Diffuse: D3DCOLORVALUE;          { Diffuse color RGBA }
  Ambient: D3DCOLORVALUE;          { Ambient color RGB }
  Specular: D3DCOLORVALUE;         { Specular 'shininess' }
  Emissive: D3DCOLORVALUE;         { Emissive color RGB }
  Power: Single;                   { Sharpness if specular highlight }
  end;
  D3DMATERIAL9 = _D3DMATERIAL9;
  PD3DSURFACE_DESC = ^_D3DSURFACE_DESC;
  _D3DSURFACE_DESC = record
    Format: D3DFORMAT;
    _Type: D3DRESOURCETYPE;
    Usage: DWORD;
    Pool: D3DPOOL;
    MultiSampleType: D3DMULTISAMPLE_TYPE;
    MultiSampleQuality: DWORD;
    Width: UINT;
    Height: UINT;
  end;
  D3DSURFACE_DESC = _D3DSURFACE_DESC;
  PD3DVOLUME_DESC = ^_D3DVOLUME_DESC;
  _D3DVOLUME_DESC = record
    Format: D3DFORMAT;
    _Type: D3DRESOURCETYPE;
    Usage: DWORD;
    Pool: D3DPOOL;
    Width: UINT;
    Height: UINT;
    Depth: UINT;
  end;
  D3DVOLUME_DESC = _D3DVOLUME_DESC;

  PD3DBOX = ^_D3DBOX;
  _D3DBOX = record
    Left: UINT;
    Top: UINT;
    Right: UINT;
    Bottom: UINT;
    Front: UINT;
    Back: UINT;
  end;
  D3DBOX = _D3DBOX;

   PD3DCUBEMAP_FACES = ^D3DCUBEMAP_FACES;
  _D3DCUBEMAP_FACES             = (
    D3DCUBEMAP_FACE_POSITIVE_X  = 0,
    D3DCUBEMAP_FACE_NEGATIVE_X  = 1,
    D3DCUBEMAP_FACE_POSITIVE_Y  = 2,
    D3DCUBEMAP_FACE_NEGATIVE_Y  = 3,
    D3DCUBEMAP_FACE_POSITIVE_Z  = 4,
    D3DCUBEMAP_FACE_NEGATIVE_Z  = 5,
    D3DCUBEMAP_FACE_FORCE_DWORD = $7FFFFFFF
  );
  D3DCUBEMAP_FACES = _D3DCUBEMAP_FACES;

  PD3DINDEXBUFFER_DESC = ^_D3DINDEXBUFFER_DESC;
  _D3DINDEXBUFFER_DESC = record
    Format: D3DFORMAT;
    _Type: D3DRESOURCETYPE;
    Usage: DWORD;
    Pool: D3DPOOL;
    Size: UINT;
  end;
  D3DINDEXBUFFER_DESC = _D3DINDEXBUFFER_DESC;

 PD3DCAPS9 = ^D3DCAPS9;
  _D3DCAPS9 = record
                                             //* Device Info */
    DeviceType: D3DDEVTYPE;
    AdapterOrdinal: UINT;
                                             //* Caps from DX7 Draw */
    Caps: DWORD;
    Caps2: DWORD;
    Caps3: DWORD;
    PresentationIntervals: DWORD;
                                             //* Cursor Caps */
    CursorCaps: DWORD;
                                             //* 3D Device Caps */
    DevCaps: DWORD;
    PrimitiveMiscCaps: DWORD;
    RasterCaps: DWORD;
    ZCmpCaps: DWORD;
    SrcBlendCaps: DWORD;
    DestBlendCaps: DWORD;
    AlphaCmpCaps: DWORD;
    ShadeCaps: DWORD;
    TextureCaps: DWORD;
    TextureFilterCaps: DWORD;                // D3DPTFILTERCAPS for IDirect3DTexture9's
    CubeTextureFilterCaps: DWORD;            // D3DPTFILTERCAPS for IDirect3DCubeTexture9's
    VolumeTextureFilterCaps: DWORD;          // D3DPTFILTERCAPS for IDirect3DVolumeTexture9's
    TextureAddressCaps: DWORD;               // D3DPTADDRESSCAPS for IDirect3DTexture9's
    VolumeTextureAddressCaps: DWORD;         // D3DPTADDRESSCAPS for IDirect3DVolumeTexture9's
    LineCaps: DWORD;                         // D3DLINECAPS
    MaxTextureWidth: DWORD;
    MaxTextureHeight: DWORD;
    MaxVolumeExtent: DWORD;
    MaxTextureRepeat: DWORD;
    MaxTextureAspectRatio: DWORD;
    MaxAnisotropy: DWORD;
    MaxVertexW: Single;
    GuardBandLeft: Single;
    GuardBandTop: Single;
    GuardBandRight: Single;
    GuardBandBottom: Single;
    ExtentsAdjust: Single;
    StencilCaps: DWORD;
    FVFCaps: DWORD;
    TextureOpCaps: DWORD;
    MaxTextureBlendStages: DWORD;
    MaxSimultaneousTextures: DWORD;
    VertexProcessingCaps: DWORD;
    MaxActiveLights: DWORD;
    MaxUserClipPlanes: DWORD;
    MaxVertexBlendMatrices: DWORD;
    MaxVertexBlendMatrixIndex: DWORD;
    MaxPointSize: Single;
    MaxPrimitiveCount: DWORD;                // max number of primitives per DrawPrimitive call
    MaxVertexIndex: DWORD;
    MaxStreams: DWORD;
    MaxStreamStride: DWORD;                  // max stride for SetStreamSource
    VertexShaderVersion: DWORD;
    MaxVertexShaderConst: DWORD;             // number of vertex shader constant registers
    PixelShaderVersion: DWORD;
    PixelShader1xMaxValue: Single;           // max value storable in registers of ps.1.x shaders
                                             // Here are the DX9 specific ones
    DevCaps2: DWORD;
    MaxNpatchTessellationLevel: Single;
    Reserved5: DWORD;
    MasterAdapterOrdinal: UINT;              // ordinal of master adaptor for adapter group
    AdapterOrdinalInGroup: UINT;             // ordinal inside the adapter group
    NumberOfAdaptersInGroup: UINT;           // number of adapters in this adapter group (only if master)
    DeclTypes: DWORD;                        // Data types, supported in vertex declarations
    NumSimultaneousRTs: DWORD;               // Will be at least 1
    StretchRectFilterCaps: DWORD;            // Filter caps supported by StretchRect
    VS20Caps: D3DVSHADERCAPS2_0;
    PS20Caps: D3DPSHADERCAPS2_0;
    VertexTextureFilterCaps: DWORD;          // D3DPTFILTERCAPS for IDirect3DTexture9's for texture, used in vertex shaders
    MaxVShaderInstructionsExecuted: DWORD;   // maximum number of vertex shader instructions that can be executed
    MaxPShaderInstructionsExecuted: DWORD;   // maximum number of pixel shader instructions that can be executed
    MaxVertexShader30InstructionSlots: DWORD;
    MaxPixelShader30InstructionSlots: DWORD;
  end;
  D3DCAPS9 = _D3DCAPS9;

  PD3DLIGHTTYPE = ^D3DLIGHTTYPE;
  _D3DLIGHTTYPE          = (
    D3DLIGHT_POINT       = 1,
    D3DLIGHT_SPOT        = 2,
    D3DLIGHT_DIRECTIONAL = 3,
    D3DLIGHT_FORCE_DWORD = $7FFFFFFF  { force 32-bit size enum }
  );
  D3DLIGHTTYPE = _D3DLIGHTTYPE;

  PD3DCLIPSTATUS9 = ^D3DCLIPSTATUS9;
  _D3DCLIPSTATUS9 = record
    ClipUnion: DWORD;
    ClipIntersection: DWORD;
  end;
  D3DCLIPSTATUS9 = _D3DCLIPSTATUS9;

  PD3DVECTOR = ^D3DVECTOR;
  _D3DVECTOR = record
    x: Single;
    y: Single;
    z: Single;
  end;
  D3DVECTOR = _D3DVECTOR;

  PD3DLOCKED_BOX = ^_D3DLOCKED_BOX;
  _D3DLOCKED_BOX = record
    RowPitch: Integer;
    SlicePitch: Integer;
    pBits: Pointer;
  end;
  D3DLOCKED_BOX = _D3DLOCKED_BOX;

  PD3DLIGHT9 = ^D3DLIGHT9;
  _D3DLIGHT9 = record
    _Type: D3DLIGHTTYPE;             { Type of light source }
    Diffuse: D3DCOLORVALUE;          { Diffuse color of light }
    Specular: D3DCOLORVALUE;         { Specular color of light }
    Ambient: D3DCOLORVALUE;          { Ambient color of light }
    Position: D3DVECTOR;             { Position in world space }
    Direction: D3DVECTOR;            { Direction in world space }
    Range: Single;                    { Cutoff range }
    Falloff: Single;                  { Falloff }
    Attenuation0: Single;             { Constant attenuation }
    Attenuation1: Single;             { Linear attenuation }
    Attenuation2: Single;             { Quadratic attenuation }
    Theta: Single;                    { Inner angle of spotlight cone }
    Phi: Single;                      { Outer angle of spotlight cone }
  end;
  {$EXTERNALSYM _D3DLIGHT9}
  D3DLIGHT9 = _D3DLIGHT9;
  {$EXTERNALSYM D3DLIGHT9}

PIMF2DBuffer = ^IMF2DBuffer;
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IMF2DBuffer);'}
{$EXTERNALSYM IMF2DBuffer}
IMF2DBuffer = interface(IUnknown)
['{7DC9D5F9-9ED9-44ec-9BBF-0600BB589FBB}']
  function Lock2D(out pbScanline0: PByte; // Receives a pointer to the first byte of the top row of pixels in the image. The top row is defined as the top row when the image is presented to the viewer, and might not be the first row in memory.
                  out plPitch: LONG       // Receives the surface stride, in bytes.
                  ): HResult; stdcall;    // The stride might be negative, indicating that the image is oriented from the bottom up in memory.

  function Unlock2D(): HResult; stdcall;
  function GetScanline0AndPitch(out pbScanline0: PByte;
                                out plPitch: LONG): HResult; stdcall;
  function IsContiguousFormat(out pfIsContiguous: BOOL): HResult; stdcall;
  function GetContiguousLength(out pcbLength: DWord): HResult; stdcall;
  function ContiguousCopyTo(out pbDestBuffer: PByte;
                            const cbDestBuffer: DWord): HResult; stdcall;
  function ContiguousCopyFrom(pbSrcBuffer: PByte;
                              cbSrcBuffer: DWord): HResult; stdcall;
end;
IID_IMF2DBuffer = IMF2DBuffer;
{$EXTERNALSYM IID_IMF2DBuffer}

   PD3DPRESENT_PARAMETERS = ^_D3DPRESENT_PARAMETERS_;
  _D3DPRESENT_PARAMETERS_ = record
    BackBufferWidth: UINT;
    BackBufferHeight: UINT;
    BackBufferFormat: D3DFORMAT;
    BackBufferCount: UINT;
    MultiSampleType: D3DMULTISAMPLE_TYPE;
    MultiSampleQuality: DWORD;
    SwapEffect: D3DSWAPEFFECT;
    hDeviceWindow: HWND;
    Windowed: BOOL;
    EnableAutoDepthStencil: BOOL;
    AutoDepthStencilFormat: D3DFORMAT;
    Flags: DWORD;
    //* FullScreen_RefreshRateInHz must be zero for Windowed mode */
    FullScreen_RefreshRateInHz: UINT;
    PresentationInterval: UINT;
  end;
  {$EXTERNALSYM _D3DPRESENT_PARAMETERS_}
  D3DPRESENT_PARAMETERS = _D3DPRESENT_PARAMETERS_;

  PD3DDISPLAYMODE = ^_D3DDISPLAYMODE;
  _D3DDISPLAYMODE = record
    Width: UINT;
    Height: UINT;
    RefreshRate: UINT;
    Format: D3DFORMAT;
  end;
  {$EXTERNALSYM _D3DDISPLAYMODE}
  D3DDISPLAYMODE = _D3DDISPLAYMODE;


  IDirect3D9 = interface(IUnknown)
  ['{81bdcbca-64d4-426d-ae8d-ad0147f4275c}']
    //*** IDirect3D9 methods ***//
    function RegisterSoftwareDevice(pInitializeFunction: Pointer): HResult; stdcall;
    function GetAdapterCount: DWORD; stdcall;
    function GetAdapterIdentifier(Adapter: DWORD;
                                  Flags: DWORD;
                                  out pIdentifier: D3DADAPTER_IDENTIFIER9): HResult; stdcall;
    function GetAdapterModeCount(Adapter: DWORD;
                                 Format: D3DFORMAT): DWORD; stdcall;
    function EnumAdapterModes(Adapter: DWORD;
                              Format: D3DFORMAT;
                              Mode: DWORD;
                              out pMode: D3DDISPLAYMODE): HResult; stdcall;
    function GetAdapterDisplayMode(Adapter: DWORD;
                                   out pMode: D3DDISPLAYMODE): HResult; stdcall;
    function CheckDeviceType(Adapter: DWORD;
                             CheckType: D3DDEVTYPE;
                             AdapterFormat: D3DFORMAT;
                             BackBufferFormat: D3DFORMAT;
                             Windowed: BOOL): HResult; stdcall;
    function CheckDeviceFormat(Adapter: DWORD;
                               DeviceType: D3DDEVTYPE;
                               AdapterFormat: D3DFORMAT;
                               Usage: DWORD;
                               RType: D3DResourceType;
                               CheckFormat: D3DFORMAT): HResult; stdcall;
    function CheckDeviceMultiSampleType(Adapter: DWORD;
                                        DeviceType: D3DDEVTYPE;
                                        SurfaceFormat: D3DFORMAT;
                                        Windowed: BOOL;
                                        MultiSampleType: D3DMULTISAMPLE_TYPE;
                                        pQualityLevels: PDWORD): HResult; stdcall;
    function CheckDepthStencilMatch(Adapter: DWORD;
                                    DeviceType: D3DDEVTYPE;
                                    AdapterFormat: D3DFORMAT;
                                    RenderTargetFormat: D3DFORMAT;
                                    DepthStencilFormat: D3DFORMAT): HResult; stdcall;
    function CheckDeviceFormatConversion(Adapter: DWORD;
                                         DeviceType: D3DDEVTYPE;
                                         SourceFormat: D3DFORMAT;
                                         TargetFormat: D3DFORMAT): HResult; stdcall;
    function GetDeviceCaps(Adapter: DWORD;
                           DeviceType: D3DDEVTYPE;
                           out pCaps: D3DCAPS9): HResult; stdcall;
    function GetAdapterMonitor(Adapter: DWORD): HMONITOR; stdcall;
    function CreateDevice(Adapter: DWORD;
                          DeviceType: D3DDEVTYPE;
                          hFocusWindow: HWND;
                          BehaviorFlags: DWORD;
                          pPresentationParameters: PD3DPRESENT_PARAMETERS;
                          out ppReturnedDeviceInterface: IDirect3DDevice9): HResult; stdcall;
  end;
  IID_IDirect3D9 = IDirect3D9;
  {$EXTERNALSYM IID_IDirect3D9}

  // Interface IDirect3DVertexShader9
  // ================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexShader9);'}
  {$EXTERNALSYM IDirect3DVertexShader9}
  IDirect3DVertexShader9 = interface(IUnknown)
  ['{EFC5557E-6265-4613-8A94-43857889EB36}']
    //*** IDirect3DVertexShader9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetFunction(pData: Pointer;
                         out pSizeOfData: UINT): HResult; stdcall;
  end;
  IID_IDirect3DVertexShader9 = IDirect3DVertexShader9;
  {$EXTERNALSYM IID_IDirect3DVertexShader9}


  // Interface IDirect3DDevice9
  // ==========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DDevice9);'}
  {$EXTERNALSYM IDirect3DDevice9}
  IDirect3DDevice9 = interface(IUnknown)
  ['{d0223b96-bf7a-43fd-92bd-a43b0d82b9eb}']
    //*** IDirect3DDevice9 methods ***//
    function TestCooperativeLevel(): HResult; stdcall;
    function GetAvailableTextureMem(): DWORD; stdcall;
    function EvictManagedResources(): HResult; stdcall;
    function GetDirect3D(out ppD3D9: IDirect3D9): HResult; stdcall;
    function GetDeviceCaps(out pCaps: D3DCAPS9): HResult; stdcall;
    function GetDisplayMode(iSwapChain: DWORD;
                            out pMode: D3DDISPLAYMODE): HResult; stdcall;
    function GetCreationParameters(out pParameters: D3DDEVICE_CREATION_PARAMETERS): HResult; stdcall;
    function SetCursorProperties(XHotSpot: DWORD;
                                 YHotSpot: DWORD;
                                 pCursorBitmap: IDirect3DSurface9): HResult; stdcall;
    procedure SetCursorPosition(XScreenSpace: DWORD;
                                YScreenSpace: DWORD;
                                Flags: DWORD); stdcall;
    function ShowCursor(bShow: BOOL): BOOL; stdcall;
    function CreateAdditionalSwapChain(const pPresentationParameters: D3DPRESENT_PARAMETERS;
                                       out pSwapChain: IDirect3DSwapChain9): HResult; stdcall;
    function GetSwapChain(iSwapChain: DWORD;
                          out pSwapChain: IDirect3DSwapChain9): HResult; stdcall;
    function GetNumberOfSwapChains: DWORD; stdcall;
    function Reset(const pPresentationParameters: D3DPRESENT_PARAMETERS): HResult; stdcall;
    function Present(pSourceRect: PRect;
                     pDestRect: PRect;
                     hDestWindowOverride: HWND;
                     pDirtyRegion: PRgnData): HResult; stdcall;
    function GetBackBuffer(iSwapChain: DWORD;
                           iBackBuffer: DWORD;
                           const _Type: D3DBACKBUFFER_TYPE;
                           out ppBackBuffer: IDirect3DSurface9): HResult; stdcall;
    function GetRasterStatus(iSwapChain: DWORD;
                             out pRasterStatus: D3DRASTER_STATUS): HResult; stdcall;
    function SetDialogBoxMode(bEnableDialogs: BOOL): HResult; stdcall;
    procedure SetGammaRamp(iSwapChain: DWORD;
                           Flags: DWORD;
                           const pRamp: D3DGammaRamp); stdcall;
    procedure GetGammaRamp(iSwapChain: DWORD;
                           out pRamp: D3DGammaRamp); stdcall;
    function CreateTexture(Width: DWORD;
                           Height: DWORD;
                           Levels: DWORD;
                           Usage: DWORD;
                           Format: D3DFORMAT;
                           Pool: D3DPOOL;
                           out ppTexture: IDirect3DTexture9;
                           pSharedHandle: PHandle): HResult; stdcall;
    function CreateVolumeTexture(Width: DWORD;
                                 Height: DWORD;
                                 Depth: DWORD;
                                 Levels: DWORD;
                                 Usage: DWORD;
                                 Format: D3DFORMAT;
                                 Pool: D3DPOOL;
                                 out ppVolumeTexture: IDirect3DVolumeTexture9;
                                 pSharedHandle: PHandle): HResult; stdcall;
    function CreateCubeTexture(EdgeLength: DWORD;
                               Levels: DWORD;
                               Usage: DWORD;
                               Format: D3DFORMAT;
                               Pool: D3DPOOL;
                               out ppCubeTexture: IDirect3DCubeTexture9;
                               pSharedHandle: PHandle): HResult; stdcall;
    function CreateVertexBuffer(Length: DWORD;
                                Usage: DWORD;
                                FVF: DWORD;
                                Pool: D3DPOOL;
                                out ppVertexBuffer: IDirect3DVertexBuffer9;
                                pSharedHandle: PHandle): HResult; stdcall;
    function CreateIndexBuffer(Length: DWORD;
                               Usage: DWORD;
                               Format: D3DFORMAT;
                               Pool: D3DPOOL;
                               out ppIndexBuffer: IDirect3DIndexBuffer9;
                               pSharedHandle: PHandle): HResult; stdcall;
    function CreateRenderTarget(Width,
                                Height: DWORD;
                                Format: D3DFORMAT;
                                MultiSample: D3DMULTISAMPLE_TYPE;
                                MultisampleQuality: DWORD;
                                Lockable: BOOL;
                                out ppSurface: IDirect3DSurface9;
                                pSharedHandle: PHandle): HResult; stdcall;
    function CreateDepthStencilSurface(Width: DWORD;
                                       Height: DWORD;
                                       Format: D3DFORMAT;
                                       MultiSample: D3DMULTISAMPLE_TYPE;
                                       MultisampleQuality: DWORD;
                                       Discard: BOOL;
                                       out ppSurface: IDirect3DSurface9;
                                       pSharedHandle: PHandle): HResult; stdcall;
    function UpdateSurface(pSourceSurface: IDirect3DSurface9;
                           pSourceRect: PRect;
                           pDestinationSurface: IDirect3DSurface9;
                           pDestPoint: PPoint): HResult; stdcall;
    function UpdateTexture(pSourceTexture: IDirect3DBaseTexture9;
                           pDestinationTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetRenderTargetData(pRenderTarget: IDirect3DSurface9;
                                 pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function GetFrontBufferData(iSwapChain: DWORD;
                                pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function StretchRect(pSourceSurface: IDirect3DSurface9;
                         pSourceRect: PRect;
                         pDestSurface: IDirect3DSurface9;
                         pDestRect: PRect;
                         Filter: D3DTEXTUREFILTERTYPE): HResult; stdcall;
    function ColorFill(pSurface: IDirect3DSurface9;
                       pRect: PRect;
                       color: D3DCOLOR): HResult; stdcall;
    function CreateOffscreenPlainSurface(Width: DWORD;
                                         Height: DWORD;
                                         Format: D3DFORMAT;
                                         Pool: D3DPOOL;
                                         out ppSurface: IDirect3DSurface9;
                                         pSharedHandle: PHandle): HResult; stdcall;
    function SetRenderTarget(RenderTargetIndex: DWORD;
                             pRenderTarget: IDirect3DSurface9): HResult; stdcall;
    function GetRenderTarget(RenderTargetIndex: DWORD;
                             out ppRenderTarget: IDirect3DSurface9): HResult; stdcall;
    function SetDepthStencilSurface(pNewZStencil: IDirect3DSurface9): HResult; stdcall;
    function GetDepthStencilSurface(out ppZStencilSurface: IDirect3DSurface9): HResult; stdcall;
    function BeginScene: HResult; stdcall;
    function EndScene: HResult; stdcall;
    function Clear(Count: DWORD;
                   pRects: PD3DRECT;
                   Flags: DWORD;
                   Color: D3DCOLOR;
                   Z: Single;
                   Stencil: DWORD): HResult; stdcall;
    function SetTransform(State: D3DTRANSFORMSTATETYPE;
                          const pMatrix: D3DMATRIX): HResult; stdcall;
    function GetTransform(State: D3DTRANSFORMSTATETYPE;
                          out pMatrix: D3DMATRIX): HResult; stdcall;
    function MultiplyTransform(State: D3DTRANSFORMSTATETYPE;
                               const pMatrix: D3DMATRIX): HResult; stdcall;
    function SetViewport(const pViewport: D3DVIEWPORT9): HResult; stdcall;
    function GetViewport(out pViewport: D3DVIEWPORT9): HResult; stdcall;
    function SetMaterial(const pMaterial: D3DMATERIAL9): HResult; stdcall;
    function GetMaterial(out pMaterial: D3DMATERIAL9): HResult; stdcall;
    function SetLight(Index: DWORD;
                      const pLight: D3DLIGHT9): HResult; stdcall;
    function GetLight(Index: DWORD;
                      out pLight: D3DLIGHT9): HResult; stdcall;
    function LightEnable(Index: DWORD;
                         Enable: BOOL): HResult; stdcall;
    function GetLightEnable(Index: DWORD;
                            out pEnable: BOOL): HResult; stdcall;
    function SetClipPlane(Index: DWORD;
                          pPlane: PSingle): HResult; stdcall;
    function GetClipPlane(Index: DWORD;
                          pPlane: PSingle): HResult; stdcall;
    function SetRenderState(State: D3DRENDERSTATETYPE;
                            Value: DWORD): HResult; stdcall;
    function GetRenderState(State: D3DRENDERSTATETYPE;
                            out pValue: DWORD): HResult; stdcall;
    function CreateStateBlock(_Type: D3DSTATEBLOCKTYPE;
                              out ppSB: IDirect3DStateBlock9): HResult; stdcall;
    function BeginStateBlock: HResult; stdcall;
    function EndStateBlock(out ppSB: IDirect3DStateBlock9): HResult; stdcall;
    function SetClipStatus(const pClipStatus: D3DCLIPSTATUS9): HResult; stdcall;
    function GetClipStatus(out pClipStatus: D3DCLIPSTATUS9): HResult; stdcall;
    function GetTexture(Stage: DWORD;
                        out ppTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function SetTexture(Stage: DWORD; pTexture: IDirect3DBaseTexture9): HResult; stdcall;
    function GetTextureStageState(Stage: UINT;
                                  _Type: D3DTEXTURESTAGESTATETYPE;
                                  out pValue: DWORD): HResult; stdcall;
    function SetTextureStageState(Stage: UINT;
                                  _Type: D3DTEXTURESTAGESTATETYPE;
                                  Value: DWORD): HResult; stdcall;
    function GetSamplerState(Sampler: DWORD;
                             _Type: D3DSAMPLERSTATETYPE;
                             out pValue: DWORD): HResult; stdcall;
    function SetSamplerState(Sampler: UINT;
                             _Type: D3DSAMPLERSTATETYPE;
                             Value: DWORD): HResult; stdcall;
    function ValidateDevice(out pNumPasses: DWORD): HResult; stdcall;
    function SetPaletteEntries(PaletteNumber: UINT;
                               pEntries: PPALETTEENTRY): HResult; stdcall;
    function GetPaletteEntries(PaletteNumber: UINT;
                               pEntries: PPALETTEENTRY): HResult; stdcall;
    function SetCurrentTexturePalette(PaletteNumber: UINT): HResult; stdcall;
    function GetCurrentTexturePalette(out PaletteNumber: UINT): HResult; stdcall;
    function SetScissorRect(pRect: PRect): HResult; stdcall;
    function GetScissorRect(out pRect: TRect): HResult; stdcall;
    function SetSoftwareVertexProcessing(bSoftware: BOOL): HResult; stdcall;
    function GetSoftwareVertexProcessing: BOOL; stdcall;
    function SetNPatchMode(nSegments: Single): HResult; stdcall;
    function GetNPatchMode: Single; stdcall;
    function DrawPrimitive(PrimitiveType: D3DPRIMITIVETYPE;
                           StartVertex: UINT;
                           PrimitiveCount: UINT): HResult; stdcall;
    function DrawIndexedPrimitive(_Type: D3DPRIMITIVETYPE;
                                  BaseVertexIndex: Integer;
                                  MinVertexIndex: UINT;
                                  NumVertices: UINT;
                                  startIndex: UINT;
                                  primCount: UINT): HResult; stdcall;
    function DrawPrimitiveUP(PrimitiveType: D3DPRIMITIVETYPE;
                             PrimitiveCount: UINT;
                             const pVertexStreamZeroData;
                             VertexStreamZeroStride: UINT): HResult; stdcall;
    function DrawIndexedPrimitiveUP(PrimitiveType: D3DPRIMITIVETYPE;
                                    MinVertexIndex: UINT;
                                    NumVertice: UINT;
                                    PrimitiveCount: UINT;
                                    const pIndexData; IndexDataFormat: D3DFORMAT;
                                    const pVertexStreamZeroData;
                                    VertexStreamZeroStride: UINT): HResult; stdcall;
    function ProcessVertices(SrcStartIndex,
                             DestIndex: UINT;
                             VertexCount: UINT;
                             pDestBuffer: IDirect3DVertexBuffer9;
                             pVertexDecl: IDirect3DVertexDeclaration9;
                             Flags: UINT): HResult; stdcall;
    function CreateVertexDeclaration(pVertexElements: PD3DVertexElement9;
                                     out ppDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function SetVertexDeclaration(pDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function GetVertexDeclaration(out ppDecl: IDirect3DVertexDeclaration9): HResult; stdcall;
    function SetFVF(FVF: DWORD): HResult; stdcall;
    function GetFVF(out FVF: DWORD): HResult; stdcall;
    function CreateVertexShader(pFunction: PDWord;
                                out ppShader: IDirect3DVertexShader9): HResult; stdcall;
    function SetVertexShader(pShader: IDirect3DVertexShader9): HResult; stdcall;
    function GetVertexShader(out ppShader: IDirect3DVertexShader9): HResult; stdcall;
    function SetVertexShaderConstantF(StartRegister: UINT;
                                      pConstantData: PSingle;
                                      Vector4fCount: UINT): HResult; stdcall;
    function GetVertexShaderConstantF(StartRegister: UINT;
                                      pConstantData: PSingle;
                                      Vector4fCount: UINT): HResult; stdcall;
    function SetVertexShaderConstantI(StartRegister: UINT;
                                      pConstantData: PInteger;
                                      Vector4iCount: UINT): HResult; stdcall;
    function GetVertexShaderConstantI(StartRegister: UINT;
                                      pConstantData: PInteger;
                                      Vector4iCount: UINT): HResult; stdcall;
    function SetVertexShaderConstantB(StartRegister: UINT;
                                     pConstantData: PBOOL;
                                     BoolCount: UINT): HResult; stdcall;
    function GetVertexShaderConstantB(StartRegister: UINT;
                                      pConstantData: PBOOL;
                                      BoolCount: UINT): HResult; stdcall;
    function SetStreamSource(StreamNumber: UINT;
                             pStreamData: IDirect3DVertexBuffer9;
                             OffsetInBytes: UINT;
                             Stride: UINT): HResult; stdcall;
    function GetStreamSource(StreamNumber: UINT;
                             out ppStreamData: IDirect3DVertexBuffer9;
                             out pOffsetInBytes: UINT;
                             pStride: UINT): HResult; stdcall;
    function SetStreamSourceFreq(StreamNumber: UINT;
                                 Setting: UINT): HResult; stdcall;
    function GetStreamSourceFreq(StreamNumber: UINT;
                                 out Setting: UINT): HResult; stdcall;
    function SetIndices(pIndexData: IDirect3DIndexBuffer9): HResult; stdcall;
    function GetIndices(out ppIndexData: IDirect3DIndexBuffer9): HResult; stdcall;
    function CreatePixelShader(pFunction: PDWORD;
                               out ppShader: IDirect3DPixelShader9): HResult; stdcall;
    function SetPixelShader(pShader: IDirect3DPixelShader9): HResult; stdcall;
    function GetPixelShader(out ppShader: IDirect3DPixelShader9): HResult; stdcall;
    function SetPixelShaderConstantF(StartRegister: UINT;
                                     pConstantData: PSingle;
                                     Vector4fCount: UINT): HResult; stdcall;
    function GetPixelShaderConstantF(StartRegister: UINT;
                                     pConstantData: PSingle;
                                     Vector4fCount: UINT): HResult; stdcall;
    function SetPixelShaderConstantI(StartRegister: UINT;
                                     pConstantData: PInteger;
                                     Vector4iCount: UINT): HResult; stdcall;
    function GetPixelShaderConstantI(StartRegister: UINT;
                                     pConstantData: PInteger;
                                     Vector4iCount: UINT): HResult; stdcall;
    function SetPixelShaderConstantB(StartRegister: UINT;
                                     pConstantData: PBOOL;
                                     BoolCount: DWORD): HResult; stdcall;
    function GetPixelShaderConstantB(StartRegister: UINT;
                                     pConstantData: PBOOL;
                                     BoolCount: UINT): HResult; stdcall;
    function DrawRectPatch(Handle: UINT;
                           pNumSegs: PSingle;
                           pTriPatchInfo: PD3DRECTPATCH_INFO): HResult; stdcall;
    function DrawTriPatch(Handle: UINT;
                          pNumSegs: PSingle;
                          pTriPatchInfo: PD3DRECTPATCH_INFO): HResult; stdcall;
    function DeletePatch(Handle: UINT): HResult; stdcall;
    function CreateQuery(_Type: D3DQUERYTYPE;
                         out ppQuery: IDirect3DQuery9): HResult; stdcall;
  end;

    {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSwapChain9);'}
  {$EXTERNALSYM IDirect3DSwapChain9}
  IDirect3DSwapChain9 = interface(IUnknown)
  ['{794950F2-ADFC-458a-905E-10A10B0B503B}']
    //*** IDirect3DSwapChain9 methods ***//
    function Present(pSourceRect: PRect;
                     pDestRect: PRect;
                     hDestWindowOverride: HWND;
                     pDirtyRegion: PRgnData;
                     dwFlags: DWORD): HResult; stdcall;
    function GetFrontBufferData(pDestSurface: IDirect3DSurface9): HResult; stdcall;
    function GetBackBuffer(iBackBuffer: UINT;
                           _Type: D3DBackBuffer_Type;
                           out ppBackBuffer: IDirect3DSurface9): HResult; stdcall;
    function GetRasterStatus(out pRasterStatus: D3DRASTER_STATUS): HResult; stdcall;
    function GetDisplayMode(out pMode: D3DDISPLAYMODE): HResult; stdcall;
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetPresentParameters(out pPresentationParameters: D3DPRESENT_PARAMETERS): HResult; stdcall;
  end;
  IID_IDirect3DSwapChain9 = IDirect3DSwapChain9;
  {$EXTERNALSYM IID_IDirect3DSwapChain9}

  // Interface IDirect3DResource9
  // ============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DResource9);'}
  {$EXTERNALSYM IDirect3DResource9}
  IDirect3DResource9 = interface(IUnknown)
  ['{05EEC05D-8F7D-4362-B999-D1BAF357C704}']
    //*** IDirect3DResource9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function SetPrivateData(const refguid: TGUID;
                            const pData: PVOID;
                            SizeOfData: DWORD;
                            Flags: DWORD): HResult; stdcall;
    function GetPrivateData(const refguid: TGUID;
                            pData: PVOID;
                            out pSizeOfData: DWORD): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function SetPriority(PriorityNew: DWORD): DWORD; stdcall;
    function GetPriority(): DWORD; stdcall;
    procedure PreLoad(); stdcall;
    function GetType(): D3DRESOURCETYPE; stdcall;
  end;
  IID_IDirect3DResource9 = IDirect3DResource9;
  {$EXTERNALSYM IID_IDirect3DResource9}

    {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DBaseTexture9);'}
  {$EXTERNALSYM IDirect3DBaseTexture9}
  IDirect3DBaseTexture9 = interface(IDirect3DResource9)
  ['{580ca87e-1d3c-4d54-991d-b7d3e3c298ce}']
    //*** IDirect3DBaseTexture9 methods ***//
    function SetLOD(LODNew: DWORD): DWORD; stdcall;
    function GetLOD(): DWORD; stdcall;
    function GetLevelCount(): DWORD; stdcall;
    function SetAutoGenFilterType(FilterType: D3DTEXTUREFILTERTYPE): HResult; stdcall;
    function GetAutoGenFilterType(): D3DTEXTUREFILTERTYPE; stdcall;
    procedure GenerateMipSubLevels();
  end;
  IID_IDirect3DBaseTexture9 = IDirect3DBaseTexture9;
  {$EXTERNALSYM IID_IDirect3DBaseTexture9}

    // Interface IDirect3DVertexDeclaration9
  // =====================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexDeclaration9);'}
  {$EXTERNALSYM IDirect3DVertexDeclaration9}
  IDirect3DVertexDeclaration9 = interface(IUnknown)
  ['{DD13C59C-36FA-4098-A8FB-C7ED39DC8546}']
    //*** IDirect3DVertexDeclaration9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetDeclaration(pElement: PD3DVertexElement9;
                            out pNumElements: UINT): HResult; stdcall;
  end;
  IID_IDirect3DVertexDeclaration9 = IDirect3DVertexDeclaration9;
  {$EXTERNALSYM IID_IDirect3DVertexDeclaration9}


    // Interface IDirect3DVertexBuffer9
  // ================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVertexBuffer9);'}
  {$EXTERNALSYM IDirect3DVertexBuffer9}
  IDirect3DVertexBuffer9 = interface(IDirect3DResource9)
  ['{b64bb1b5-fd70-4df6-bf91-19d0a12455e3}']
    //*** IDirect3DVertexBuffer9 methods ***//
    function Lock(OffsetToLock: UINT;
                  SizeToLock: UINT;
                  out ppbData: Pointer;
                  Flags: DWORD): HResult; stdcall;
    function Unlock(): HResult; stdcall;
    function GetDesc(out pDesc: D3DVERTEXBUFFER_DESC): HResult; stdcall;
  end;
  IID_IDirect3DVertexBuffer9 = IDirect3DVertexBuffer9;
  {$EXTERNALSYM IID_IDirect3DVertexBuffer9}

   // Interface IDirect3DTexture9
  // ===========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DTexture9);'}
  {$EXTERNALSYM IDirect3DTexture9}
  IDirect3DTexture9 = interface(IDirect3DBaseTexture9)
  ['{85c31227-3de5-4f00-9b3a-f11ac38c18b5}']
    //*** IDirect3DTexture9 methods ***//
    function GetLevelDesc(Level: UINT;
                          out pDesc: D3DSURFACE_DESC): HResult; stdcall;
    function GetSurfaceLevel(Level: UINT;
                             out ppSurfaceLevel: IDirect3DSurface9): HResult; stdcall;
    function LockRect(Level: UINT;
                      out pLockedRect: D3DLOCKED_RECT;
                      pRect: PRect;
                      Flags: DWORD): HResult; stdcall;
    function UnlockRect(Level: UINT): HResult; stdcall;
    function AddDirtyRect(pDirtyRect: PRect): HResult; stdcall;
  end;
  IID_IDirect3DTexture9 = IDirect3DTexture9;
  {$EXTERNALSYM IID_IDirect3DTexture9}

  // Interface IDirect3DCubeTexture9
  // ===============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DCubeTexture9);'}
  {$EXTERNALSYM IDirect3DCubeTexture9}
  IDirect3DCubeTexture9 = interface(IDirect3DBaseTexture9)
  ['{fff32f81-d953-473a-9223-93d652aba93f}']
    //*** IDirect3DCubeTexture9 methods ***//
    function GetLevelDesc(Level: UINT;
                          out pDesc: D3DSURFACE_DESC): HResult; stdcall;
    function GetCubeMapSurface(FaceType: D3DSURFACE_DESC;
                               Level: UINT;
                               out ppCubeMapSurface: IDirect3DSurface9): HResult; stdcall;
    function LockRect(FaceType: D3DCUBEMAP_FACES;
                      Level: UINT;
                      out pLockedRect: D3DLOCKED_RECT;
                      pRect: PRect;
                      Flags: DWORD): HResult; stdcall;
    function UnlockRect(FaceType: D3DCUBEMAP_FACES;
                        Level: UINT): HResult; stdcall;
    function AddDirtyRect(FaceType: D3DCUBEMAP_FACES;
                          pDirtyRect: PRect): HResult; stdcall;
  end;
  IID_IDirect3DCubeTexture9 = IDirect3DCubeTexture9;
  {$EXTERNALSYM IID_IDirect3DCubeTexture9}

  // Interface IDirect3DIndexBuffer9
  // ===============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DIndexBuffer9);'}
  {$EXTERNALSYM IDirect3DIndexBuffer9}
  IDirect3DIndexBuffer9 = interface(IDirect3DResource9)
  ['{7C9DD65E-D3F7-4529-ACEE-785830ACDE35}']
    //*** IDirect3DIndexBuffer9 methods ***//
    function Lock(OffsetToLock: DWORD;
                  SizeToLock: DWORD;
                  out ppbData: Pointer;
                  Flags: DWord): HResult; stdcall;
    function Unlock(): HResult; stdcall;
    function GetDesc(out pDesc: D3DINDEXBUFFER_DESC): HResult; stdcall;
  end;
  IID_IDirect3DIndexBuffer9 = IDirect3DIndexBuffer9;
  {$EXTERNALSYM IID_IDirect3DIndexBuffer9}

  // Interface IDirect3DSurface9
  // ===========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DSurface9);'}
  {$EXTERNALSYM IDirect3DSurface9}
  IDirect3DSurface9 = interface(IDirect3DResource9)
  ['{0cfbaf3a-9ff6-429a-99b3-a2796af8b89b}']
    //*** IDirect3DSurface9 methods ***//
    function GetContainer(const riid: TGuid;
                          out ppContainer{: Pointer}): HResult; stdcall;
    function GetDesc(out pDesc: D3DSURFACE_DESC): HResult; stdcall;
    function LockRect(out pLockedRect: D3DLOCKED_RECT;
                      pRect: PRect;
                      Flags: DWORD): HResult; stdcall;
    function UnlockRect: HResult; stdcall;
    function GetDC(out phdc: HDC): HResult; stdcall;
    function ReleaseDC(hdc: HDC): HResult; stdcall;
  end;
  IID_IDirect3DSurface9 = IDirect3DSurface9;
  {$EXTERNALSYM IID_IDirect3DSurface9}

  // Interface IDirect3DStateBlock9
  // ==============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DStateBlock9);'}
  {$EXTERNALSYM IDirect3DStateBlock9}
  IDirect3DStateBlock9 = interface(IUnknown)
  ['{B07C4FE5-310D-4ba8-A23C-4F0F206F218B}']
     //*** IDirect3DStateBlock9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function Capture(): HResult; stdcall;
    function Apply(): HResult; stdcall;
  end;
  IID_IDirect3DStateBlock9 = IDirect3DStateBlock9;
  {$EXTERNALSYM IID_IDirect3DStateBlock9}

  // Interface IDirect3DPixelShader9
  // ===============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DPixelShader9);'}
  {$EXTERNALSYM IDirect3DPixelShader9}
  IDirect3DPixelShader9 = interface(IUnknown)
  ['{6D3BDBDC-5B02-4415-B852-CE5E8BCCB289}']
    //*** IDirect3DPixelShader9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetFunction(pData: Pointer;
                         out pSizeOfData: UINT): HResult; stdcall;
  end;
  IID_IDirect3DPixelShader9 = IDirect3DPixelShader9;
  {$EXTERNALSYM IID_IDirect3DPixelShader9}

  // Interface IDirect3DQuery9
  // =========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DQuery9);'}
  {$EXTERNALSYM IDirect3DQuery9}
  IDirect3DQuery9 = interface(IUnknown)
  ['{d9771460-a695-4f26-bbd3-27b840b541cc}']
    //*** IDirect3DQuery9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function GetType(): D3DQUERYTYPE; stdcall;
    function GetDataSize(): DWORD; stdcall;
    function Issue(dwIssueFlags: DWORD): HResult; stdcall;
    function GetData(pData: Pointer;
                     dwSize: DWORD;
                     dwGetDataFlags: DWORD): HResult; stdcall;
  end;
  IID_IDirect3DQuery9 = IDirect3DQuery9;
  {$EXTERNALSYM IID_IDirect3DQuery9}

    // Interface IDirect3DVolume9
  // ==========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolume9);'}
  {$EXTERNALSYM IDirect3DVolume9}
  IDirect3DVolume9 = interface (IUnknown)
  ['{24F416E6-1F67-4aa7-B88E-D33F6F3128A1}']
    //*** IDirect3DVolume9 methods ***//
    function GetDevice(out ppDevice: IDirect3DDevice9): HResult; stdcall;
    function SetPrivateData(const refguid: TGuid;
                            const pData; DWORD,
                            Flags: DWORD): HResult; stdcall;
    function GetPrivateData(const refguid: TGuid;
                            pData: Pointer;
                            out pSizeOfData: DWORD): HResult; stdcall;
    function FreePrivateData(const refguid: TGUID): HResult; stdcall;
    function GetContainer(const riid: TGUID;
                          [ref] const ppContainer: Pointer): HResult; stdcall;
    function GetDesc(out pDesc: D3DVolume_Desc): HResult; stdcall;
    function LockBox(out pLockedVolume: D3DLOCKED_BOX;
                     pBox: PD3DBOX;
                     Flags: DWORD): HResult; stdcall;
    function UnlockBox(): HResult; stdcall;
  end;
  IID_IDirect3DVolume9 = IDirect3DVolume9;
  {$EXTERNALSYM IID_IDirect3DVolume9}


    // Interface IDirect3DVolumeTexture9
  // =================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDirect3DVolumeTexture9);'}
  {$EXTERNALSYM IDirect3DVolumeTexture9}
  IDirect3DVolumeTexture9 = interface(IDirect3DBaseTexture9)
  ['{2518526C-E789-4111-A7B9-47EF328D13E6}']
    //*** IDirect3DVolumeTexture9 methods ***//
    function GetLevelDesc(Level: UINT;
                          out pDesc: D3DVOLUME_DESC): HResult; stdcall;
    function GetVolumeLevel(Level: UINT;
                            out ppVolumeLevel: IDirect3DVolume9): HResult; stdcall;
    function LockBox(Level: UINT;
                     out pLockedVolume: D3DLOCKED_BOX;
                     pBox: PD3DBOX; // Specifying Nil for this parameter locks the entire volume level.
                     Flags: DWORD): HResult; stdcall;
    function UnlockBox(Level: UINT): HResult; stdcall;
    function AddDirtyBox(pDirtyBox: PD3DBox): HResult; stdcall; // Specifying Nil expands the dirty region to cover the entire volume texture.
  end;
  IID_IDirect3DVolumeTexture9 = IDirect3DVolumeTexture9;
  {$EXTERNALSYM IID_IDirect3DVolumeTexture9}


  function ConvertYCrCbToRGB(aY: Integer;
                           aCr: Integer;
                           aCb: Integer): RGBQUAD; inline;

  function Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
  function _Direct3DCreate9(SDKVersion: LongWord): Pointer; stdcall;

  function D3DCOLOR_XRGB(r: Int32; g: Int32; b: Int32): D3DCOLOR;

  function MFCopyImage(pDest: PByte;
                     lDestStride: LONG;
                     const pSrc: PByte;
                     lSrcStride: LONG;
                     dwWidthInBytes: DWORD;
                     dwLines: DWORD): HRESULT; stdcall;

  procedure CopyTRectToTRect(const rs: TRect;
                     out rd: TRect); inline;

  function MFGetStrideForBitmapInfoHeader(Format: DWORD;
                                        dwWidth: DWORD;
                                        out pStride: LONG): HRESULT; stdcall;

  const
    D3D9Lib                = 'D3d9.dll';
    _FACD3D                             = $876;
    MAKE_D3DHRESULT_R = (1 shl 31) OR (_FACD3D shl 16);
    MAKE_D3DSTATUS_R = (0 shl 31) OR (_FACD3D shl 16);

    D3DADAPTER_DEFAULT                  = 0;
    D3D_SDK_VERSION                     = 32;

    D3DTEXF_LINEAR                      = D3DTEXTUREFILTERTYPE(2);      // linear interpolation

    D3DFMT_UNKNOWN                      = D3DFORMAT(0);
    D3DFMT_X8R8G8B8                     = D3DFORMAT(22);

    MFVideoInterlace_Unknown            = MFVideoInterlaceMode(0);
    MFVideoInterlace_Progressive        = MFVideoInterlaceMode(2);

    MF_SOURCE_READERF_ERROR                   = MF_SOURCE_READER_FLAG($00000001);
    MF_SOURCE_READERF_NEWSTREAM               = MF_SOURCE_READER_FLAG($00000004);
    MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED  = MF_SOURCE_READER_FLAG($00000010);
    MF_SOURCE_READERF_STREAMTICK              = MF_SOURCE_READER_FLAG($00000100);
    MF_SOURCE_READERF_ALLEFFECTSREMOVED       = MF_SOURCE_READER_FLAG($00000200);

    MF_E_INVALIDREQUEST                 = _HRESULT_TYPEDEF_($C00D36B2);
    MF_E_NO_MORE_TYPES                  = _HRESULT_TYPEDEF_($C00D36B9);

    D3DPRESENT_INTERVAL_IMMEDIATE       = $80000000;
    D3DPRESENTFLAG_LOCKABLE_BACKBUFFER  = $00000001;
    D3DCREATE_FPU_PRESERVE              = $00000002;
    D3DPRESENTFLAG_DEVICECLIP           = $00000004;
    D3DPRESENTFLAG_VIDEO                = $00000010;
    D3DCREATE_HARDWARE_VERTEXPROCESSING = $00000040;
    D3DLOCK_NOSYSLOCK                   = $00000800;

    D3D_OK                              = S_OK;

    D3DERR_DEVICELOST                   = MAKE_D3DHRESULT_R OR (2152);
    D3DERR_DEVICENOTRESET               = MAKE_D3DHRESULT_R OR (2153);

    GUID_NULL                           : TGUID = '{00000000-0000-0000-0000-000000000000}';
    MF_MT_DEFAULT_STRIDE                : TGUID = '{644b4e48-1e02-4516-b0eb-c01ca9d49ac6}';
    MF_READWRITE_DISABLE_CONVERTERS     : TGUID = '{98d5b065-1374-4847-8d5d-31520fee7156}';


implementation

  function _Direct3DCreate9;         external D3D9Lib name 'Direct3DCreate9' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFCopyImage;              external MfApiLibA name 'MFCopyImage' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};
  function MFGetStrideForBitmapInfoHeader;       external MfApiLibA name 'MFGetStrideForBitmapInfoHeader' {$IF COMPILERVERSION > 20.0} delayed {$ENDIF};


function Clip(clr: Integer): Byte; inline;
begin
  if (clr > 255) then
    Result := Byte(255)
  else if clr < 0 then
    Result := Byte(0)
  else
    Result := Byte(clr);
end;

function D3DCOLOR_ARGB(a: Int32; r: Int32;
                       g: Int32; b: Int32): D3DCOLOR;
  begin
    Result:= ((a AND $FF) shl 24) OR ((r AND $FF) shl 16) OR ((g AND $FF) shl 8) OR (b AND $FF);
  end;


function ConvertYCrCbToRGB(aY: Integer;
                           aCr: Integer;
                           aCb: Integer): RGBQUAD; inline;
var
  rgbq: RGBQUAD;
  c, d, e: Integer;
begin
  rgbq := Default(RGBQUAD);
  c := aY - 16;
  d := aCb - 128;
  e := aCr - 128;
  rgbq.rgbRed :=   Clip(( 298 * c + 409 * e + 128) shr 8);
  rgbq.rgbGreen := Clip(( 298 * c - 100 * d - 208 * e + 128) shr 8);
  rgbq.rgbBlue :=  Clip(( 298 * c + 516 * d + 128) shr 8);
  Result:=  rgbq;
end;

function Direct3DCreate9(SDKVersion: LongWord): IDirect3D9; stdcall;
begin
  // Cast returned pointer to IDirect3D9 pointer.
  Result:= IDirect3D9(_Direct3DCreate9(SDKVersion));
  // Release from autoincrement reference count
  if Assigned(Result) then
    Result._Release;
end;
function D3DCOLOR_XRGB(r: Int32; g: Int32;
                       b: Int32): D3DCOLOR;
begin
  Result:= D3DCOLOR_ARGB ($FF, r, g, b);
end;

// Copy TRect values to another TRect
procedure CopyTRectToTRect(const rs: TRect;
                           out rd: TRect); inline;
begin
  rd.Top := rs.Top;
  rd.Bottom := rs.Bottom;
  rd.Left := rs.Left;
  rd.Right := rs.Right;
end;



end.
