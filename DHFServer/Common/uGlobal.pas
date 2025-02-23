unit uGlobal;

interface

uses
  Generics.Collections, uSQLHelper, uLogger, uTypes, uBaseThread,
  System.Threading;

var
  sqlhelper: TSqlHelper;
  borderDBHelper: TSqlHelper;

  gDicDevice: TDictionary<string, TDevice>;
  gDicHBC: TDictionary<string, boolean>;
  gDicAlarm: TDictionary<string, boolean>;
  gOpenedDevice: TDictionary<string, boolean>;

  gOldDevice: TDictionary<string, TDevice>;
  gOldHBC: TDictionary<string, boolean>;
  gOldAlarm: TDictionary<string, boolean>;
  gOldOpenedDevice: TDictionary<string, boolean>;

  gUnknowDevice: TDictionary<string, boolean>;
  gDicHPZL: TDictionary<string, string>;
  gVehDic: TDictionary<string, boolean>;
  solrFtp, hdpFtp: TFtpConfig;
  logger: TLogger;
  FZJG: string; // 发证机构（本地号牌号码前缀）（用于假套牌鉴别）
  DFSHost: string; // 仓库地址 带端口
  SMSUrl: string =
    'http://10.46.137.83:8081/SMS/Send?token=%s&mobiles=%s&content=%s'; // 短信地址
  gHeartbeatUrl: string;
  kk, dj, idchina: boolean;
  DCXXZP: string;
  reload: boolean;
  holeUrl: string;
  holeSBBH: TDictionary<string, string>;

  gHikConfig: THikDaoFengConfig;

  hikJcbkdPool: TThreadPool;

  gBdrUrl: string;    // 边界URL

implementation

end.
