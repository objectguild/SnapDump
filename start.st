| apiHandler healthHandler metricsHandler prefixHandler server |
Author fullName: 'docker'.

ZnLogEvent logToTranscript.

SnapDump hackUIManager.
"SnapDump current  store: (SDFilesystemStore new path: '/snapshots')."

(Cinic readFileNamed: 'configuration-server.json') apply.

SDServer startOnPort: 5555 path: '/snapshots'
