program FZKService;

uses
  Vcl.SvcMgr,
  uLogger in '..\Common\uLogger.pas',
  ElAES in 'ElAES.pas',
  QBAes in 'QBAes.pas',
  uDDThread in 'uDDThread.pas',
  uVariants in 'uVariants.pas',
  uExportThread in 'uExportThread.pas',
  uUpdateYZBH in 'uUpdateYZBH.pas',
  uSQLHelper in '..\Common\uSQLHelper.pas',
  uMainService in 'uMainService.pas' {ItsFZKService: TService};

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TItsFZKService, ItsFZKService);
  Application.Run;

end.
