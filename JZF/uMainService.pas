unit uMainService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, uTaskThread, uKKAlarm,
  uGlobal, uCommon, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Vcl.ExtCtrls, uZBDXThread, uUploadVio, uJQThread, uVioSBThread,
  uDeviceMonitorThread, uDelExpiredVioThread, uHBCVioThread, uWNJVioThread,
  uBuKongDaHuoCheThread, uAlarmVehicleToHikThread, uLogUploadThread;

type
  TItsJZFService = class(TService)
    Timer1: TTimer;
    IdHTTP1: TIdHTTP;
    Timer2: TTimer;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ItsJZFService: TItsJZFService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ItsJZFService.Controller(CtrlCode);
end;

function TItsJZFService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TItsJZFService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  TCommon.ProgramInit;
  if gJZF then
    TTaskThread.Create;
  if gKKALARM then
    TKKAlarmThread.Create(False);
  TVioSBThread.Create(False);
  Timer1.Interval := gHeartbeatInterval * 60000;
  Timer1Timer(nil);
  Timer1.Enabled := True;
  Timer2.Enabled := True;
  gLogger.Info('Service Started');
end;

procedure TItsJZFService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  gLogger.Info('Service Stoped');
  TCommon.ProgramDestroy;
end;

procedure TItsJZFService.Timer1Timer(Sender: TObject);
var
  response: TStringStream;
  requestStream: TStringStream;
begin
  response := TStringStream.Create('');
  requestStream := TStringStream.Create('');
  requestStream.WriteString('ServiceName=ItsJZFService');
  try
    IdHTTP1.Post(gHeartbeatUrl + 'ServiceHeartbeat', requestStream, response);
  except
  end;
  requestStream.Free;
  response.Free;
end;

procedure TItsJZFService.Timer2Timer(Sender: TObject);
var
  Hour, Min, Sec, MSec: word;
begin
  if gZBDX and (FormatDateTime('hhnn', Now()) = gZBDXTime) then
    TZBDXThread.Create(False);

  if FormatDateTime('hhnn', Now()) = '1056' then
    TDelExpiredVioThread.Create(False);

  DecodeTime(Now, Hour, Min, Sec, MSec);
  if Min Mod 3 = 0 then
    TJQThread.Create;

  if (gDeviceMonitorSJHM.Count > 0) and (Min Mod 10 = 0) then
    TDeviceMonitorThread.Create;

  if Min = 5 then
    THBCVioThread.Create(False);

  if gUploadVio and (FormatDateTime('hhnn', Now) = gUploadVioTime) then
    TUploadVioThread.Create(False);

  if Min = 0 then
    TWNJVioThread.Create(False);

  if Min = 7 then
    TBuKongDaHuoCheThread.Create(false);

  if (Hour = 5) and (Min = 0) and (gHikAlarmVehicleUrl <> '') then
    TAlarmVehicleToHikThread.Create;

  if (Hour = 2) and (Min = 0) and (gLogUploadConfig.UploadUrl <> '') then
    TLogUploadThread.Create;
end;

end.
