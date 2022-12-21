program Post;
uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Api in 'Api.pas',
  ApiObjects in 'ApiObjects.pas',
  BasicApiObjects in 'BasicApiObjects.pas';
//  PreviewApipas in 'PreviewApipas.pas',
//  Device in 'Device.pas',
//  VideoBufferLock in 'VideoBufferLock.pas';
//  PreviewApiEx in 'PreviewApiEx.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
