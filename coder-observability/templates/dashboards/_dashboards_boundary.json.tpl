{{ define "agent-boundaries-dashboard.json" }}
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "target": {
          "limit": 100,
          "matchAny": false,
          "tags": [],
          "type": "dashboard"
        },
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "links": [],
  "panels": [
    {
      "datasource": {
        "type": "loki",
        "uid": "loki"
      },
      "description": "Total number of requests allowed/denied",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "{decision=\"allow\"}"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "Allowed"
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "{decision=\"deny\"}"
            },
            "properties": [
              {
                "id": "displayName",
                "value": "Denied"
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 7,
        "w": 20,
        "x": 0,
        "y": 0
      },
      "id": 5,
      "options": {
        "colorMode": "value",
        "graphMode": "area",
        "justifyMode": "auto",
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showPercentChange": false,
        "textMode": "auto",
        "wideLayout": true
      },
      "pluginVersion": "10.4.0",
      "targets": [
        {
          "datasource": {
            "type": "loki",
            "uid": "loki"
          },
          "direction": "backward",
          "editorMode": "code",
          "expr": "sum by (decision) (count_over_time({ {{- include "non-workspace-selector" . -}}, logger=`coderd.agentrpc`} |= `boundary_request` | logfmt | decision=~`deny|allow` | owner=~`$owner` [$__range]))",
          "queryType": "range",
          "refId": "A"
        }
      ],
      "title": "Request Totals",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "loki",
        "uid": "loki"
      },
      "description": "Top 20 allowed domains for HTTP requests",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "filterable": false,
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "Domain"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 340
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 12,
        "w": 10,
        "x": 0,
        "y": 7
      },
      "id": 1,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "enablePagination": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "frameIndex": 1,
        "showHeader": true,
        "sortBy": [
          {
            "desc": true,
            "displayName": "Count"
          }
        ]
      },
      "pluginVersion": "10.4.0",
      "targets": [
        {
          "datasource": {
            "type": "loki",
            "uid": "loki"
          },
          "direction": "backward",
          "editorMode": "code",
          "expr": "topk(20, sum by (domain) (count_over_time({ {{- include "non-workspace-selector" . -}}, logger=`coderd.agentrpc`} |= `boundary_request` | logfmt | decision=`allow` | owner=~`$owner` | regexp `http_url=(?P<scheme>https?)://(?P<domain>[^/:]+)` | domain=~`$domain` [$__auto])))",
          "legendFormat": "",
          "queryType": "instant",
          "refId": "A"
        }
      ],
      "title": "Top Allowed Domains",
      "transformations": [
        {
          "id": "organize",
          "options": {
            "excludeByName": {
              "Time": true
            },
            "includeByName": {},
            "indexByName": {},
            "renameByName": {
              "Time": "",
              "Value #A": "Count",
              "domain": "Domain"
            }
          }
        },
        {
          "id": "sortBy",
          "options": {
            "fields": {},
            "sort": [
              {
                "desc": true,
                "field": "Count"
              }
            ]
          }
        }
      ],
      "type": "table"
    },
    {
      "datasource": {
        "type": "loki",
        "uid": "loki"
      },
      "description": "Top 20 denied domains for HTTP requests",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "filterable": false,
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "Domain"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 382
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 12,
        "w": 10,
        "x": 10,
        "y": 7
      },
      "id": 2,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "enablePagination": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "frameIndex": 1,
        "showHeader": true,
        "sortBy": [
          {
            "desc": true,
            "displayName": "Count"
          }
        ]
      },
      "pluginVersion": "10.4.0",
      "targets": [
        {
          "datasource": {
            "type": "loki",
            "uid": "loki"
          },
          "direction": "backward",
          "editorMode": "code",
          "expr": "topk(20, sum by (domain) (count_over_time({ {{- include "non-workspace-selector" . -}}, logger=`coderd.agentrpc`} |= `boundary_request` | logfmt | decision=`deny` | owner=~`$owner` | regexp `http_url=(?P<scheme>https?)://(?P<domain>[^/:]+)` | domain=~`$domain` [$__auto])))",
          "legendFormat": "",
          "queryType": "instant",
          "refId": "A"
        }
      ],
      "title": "Top Denied Domains",
      "transformations": [
        {
          "id": "organize",
          "options": {
            "excludeByName": {
              "Time": true
            },
            "includeByName": {},
            "indexByName": {},
            "renameByName": {
              "Time": "",
              "Value #A": "Count",
              "domain": "Domain"
            }
          }
        },
        {
          "id": "sortBy",
          "options": {
            "fields": {},
            "sort": [
              {
                "desc": true,
                "field": "Count"
              }
            ]
          }
        }
      ],
      "type": "table"
    },
    {
      "datasource": {
        "type": "loki",
        "uid": "loki"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "Time"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 282
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Domain"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 185
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "method"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 73
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "path"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 397
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Workspace Owner"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 144
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 12,
        "w": 22,
        "x": 0,
        "y": 19
      },
      "id": 3,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": []
      },
      "pluginVersion": "10.4.0",
      "targets": [
        {
          "datasource": {
            "type": "loki",
            "uid": "loki"
          },
          "direction": "backward",
          "editorMode": "code",
          "expr": "{ {{- include "non-workspace-selector" . -}}, logger=`coderd.agentrpc`} |= `boundary_request` | logfmt | decision=`allow` | owner=~`$owner` | regexp `http_url=https?://(?P<domain>[^/?#]+)(?P<path>/[^?#]*)?` | domain=~`$domain` | line_format `time=\"{{ "{{" }}.event_time{{ "}}" }}\" domain={{ "{{" }}.domain{{ "}}" }} method={{ "{{" }}.http_method{{ "}}" }} path=\"{{ "{{" }}.path{{ "}}" }}\" owner={{ "{{" }}.owner{{ "}}" }} workspace_name=\"{{ "{{" }}.workspace_name{{ "}}" }}\"`",
          "queryType": "range",
          "refId": "A"
        }
      ],
      "title": "Most recent allowed requests",
      "transformations": [
        {
          "id": "limit",
          "options": {
            "limitField": "10"
          }
        },
        {
          "id": "extractFields",
          "options": {
            "delimiter": "|",
            "format": "kvp",
            "keepTime": false,
            "replace": true,
            "source": "Line"
          }
        },
        {
          "id": "organize",
          "options": {
            "excludeByName": {
              "id": true,
              "labelTypes": true,
              "labels": true,
              "tsNs": true
            },
            "includeByName": {},
            "indexByName": {
              "domain": 2,
              "method": 1,
              "owner": 4,
              "path": 3,
              "time": 0,
              "workspace_name": 5
            },
            "renameByName": {
              "Line": "Domain",
              "domain": "Domain",
              "labels": "",
              "method": "Method",
              "owner": "Workspace Owner",
              "path": "Path",
              "time": "Time",
              "tsNs": "",
              "workspace_name": "Workspace Name"
            }
          }
        }
      ],
      "type": "table"
    },
    {
      "datasource": {
        "type": "loki",
        "uid": "loki"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "custom": {
            "align": "auto",
            "cellOptions": {
              "type": "auto"
            },
            "inspect": false
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "matcher": {
              "id": "byName",
              "options": "Time"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 282
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Domain"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 185
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "method"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 73
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "path"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 397
              }
            ]
          },
          {
            "matcher": {
              "id": "byName",
              "options": "Workspace Owner"
            },
            "properties": [
              {
                "id": "custom.width",
                "value": 152
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 12,
        "w": 22,
        "x": 0,
        "y": 31
      },
      "id": 6,
      "options": {
        "cellHeight": "sm",
        "footer": {
          "countRows": false,
          "fields": "",
          "reducer": [
            "sum"
          ],
          "show": false
        },
        "showHeader": true,
        "sortBy": []
      },
      "pluginVersion": "10.4.0",
      "targets": [
        {
          "datasource": {
            "type": "loki",
            "uid": "loki"
          },
          "direction": "backward",
          "editorMode": "code",
          "expr": "{ {{- include "non-workspace-selector" . -}}, logger=`coderd.agentrpc`} |= `boundary_request` | logfmt | decision=`deny` | owner=~`$owner` | regexp `http_url=https?://(?P<domain>[^/?#]+)(?P<path>/[^?#]*)?` | domain=~`$domain` | line_format `time=\"{{ "{{" }}.event_time{{ "}}" }}\" domain={{ "{{" }}.domain{{ "}}" }} method={{ "{{" }}.http_method{{ "}}" }} path=\"{{ "{{" }}.path{{ "}}" }}\" owner={{ "{{" }}.owner{{ "}}" }} workspace_name=\"{{ "{{" }}.workspace_name{{ "}}" }}\"`",
          "queryType": "range",
          "refId": "A"
        }
      ],
      "title": "Most recent denied requests",
      "transformations": [
        {
          "id": "limit",
          "options": {
            "limitField": "10"
          }
        },
        {
          "id": "extractFields",
          "options": {
            "delimiter": "|",
            "format": "kvp",
            "keepTime": false,
            "replace": true,
            "source": "Line"
          }
        },
        {
          "id": "organize",
          "options": {
            "excludeByName": {
              "id": true,
              "labelTypes": true,
              "labels": true,
              "tsNs": true
            },
            "includeByName": {},
            "indexByName": {
              "domain": 2,
              "method": 1,
              "owner": 4,
              "path": 3,
              "time": 0,
              "workspace_name": 5
            },
            "renameByName": {
              "Line": "Domain",
              "domain": "Domain",
              "labels": "",
              "method": "Method",
              "owner": "Workspace Owner",
              "path": "Path",
              "time": "Time",
              "tsNs": "",
              "workspace_name": "Workspace Name"
            }
          }
        }
      ],
      "type": "table"
    }
  ],
  "refresh": "{{ include "dashboard-refresh" . }}",
  "schemaVersion": 39,
  "tags": [],
  "templating": {
    "list": [
      {
        "current": {
          "text": "",
          "value": ""
        },
        "description": "Search for blocked paths/methods by domain",
        "label": "Domain",
        "name": "domain",
        "options": [
          {
            "selected": true,
            "text": "",
            "value": ""
          }
        ],
        "query": "",
        "type": "textbox"
      },
      {
        "current": {
          "text": "",
          "value": ""
        },
        "description": "Search for allowed/denied requests by workspace owner",
        "label": "Workspace Owner",
        "name": "owner",
        "options": [
          {
            "selected": true,
            "text": "",
            "value": ""
          }
        ],
        "query": "",
        "type": "textbox"
      }
    ]
  },
  "time": {
    "from": "now-{{ include "dashboard-range" . }}",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "browser",
  "title": "Coder Agent Boundaries",
  "uid": "agent-boundaries",
  "version": 1,
  "weekStart": ""
}
{{ end }}
