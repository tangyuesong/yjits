object ItsPicReSaveService: TItsPicReSaveService
  OldCreateOrder = False
  DisplayName = 'ITS PicReSave Service'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 302
  Width = 432
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 72
    Top = 24
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
    Top = 24
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer2Timer
    Left = 152
    Top = 32
  end
end
