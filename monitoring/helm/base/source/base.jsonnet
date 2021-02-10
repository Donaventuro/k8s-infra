local kp = (import 'kube-prometheus/kube-prometheus.libsonnet') +
           (import 'kube-prometheus/kube-prometheus-kubeadm.libsonnet') +
{
  _config+:: {
    namespace: 'monitoring',
    grafana+:: {
      config: {
        sections: {
          security: {
            admin_user: 'admin',
            admin_password: 'gfhjkm1',
          },
        },
      },
    },
    alertmanager+:: {
      config: |||
        global:
          resolve_timeout: 10m
        route:
          group_by: ['job']
          group_wait: 30s
          group_interval: 5m
          repeat_interval: 12h
          receiver: 'null'
          routes:
          - match:
              alertname: Watchdog
            receiver: 'null'
        receivers:
        - name: 'null'
      |||,
    }
  },
  prometheus+:: {
    prometheus+: {
      spec+: {
        replicas: 1,
        retention: '336h',
        externalUrl: 'https://prometheus-monitoring.tages.dev',
        storage: {
          volumeClaimTemplate: {
            spec: {
              accessModes: ['ReadWriteOnce'],
              resources: {
                requests: {
                  storage: '1Gi'
                },
              },
              storageClassName: 'nfs-hdd',
            },
          },
        },
      },
    },
  },
  alertmanager+:: {
    alertmanager+: {
      spec+: {
        replicas: 1,
        externalUrl: 'https://alertmanager-monitoring.tages.dev',
        storage: {
          volumeClaimTemplate: {
            spec: {
              accessModes: ['ReadWriteOnce'],
              resources: {
                requests: {
                  storage: '1Gi'
                },
              },
              storageClassName: 'nfs-hdd',
            },
          },
        },
      },
    },
  },
};

{ 'helm/base/bundle/prometheus-operator-serviceMonitor': kp.prometheusOperator.serviceMonitor } +
{ ['helm/base/bundle/node-exporter-' + name]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
{ ['helm/base/bundle/kube-state-metrics-' + name]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
{ ['helm/base/bundle/alertmanager-' + name]: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
{ ['helm/base/bundle/prometheus-' + name]: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +
{ ['helm/base/bundle/prometheus-adapter-' + name]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) } +
{ ['helm/base/bundle/grafana-' + name]: kp.grafana[name] for name in std.objectFields(kp.grafana) }
