k8s_context('playground')
secret_settings (disable_scrub=True) 

config.define_string_list("to-run", args=True)
cfg = config.parse()
groups = {
  'mysql': ['mysql:statefulset', 'phpmyadmin'],
  'redis': ['redis-master', 'redis-commander'],
  'mongodb': ['mongodb', 'mongo-express'],
  'postgresql': ['postgresql', 'pgadmin', 'pg-upload-data'],
  'minio': ['minio:deployment:default', 'minio-post-job'],
  'kfp': [
    'metadata-grpc-deployment',
    'metadata-writer',
    'ml-pipeline-persistenceagent',
    'ml-pipeline-visualizationserver',
    'mysql:deployment',
    'minio:deployment:kubeflow',
    'ml-pipeline',
    'ml-pipeline-viewer-crd',
    'cache-server',
    'ml-pipeline-ui',
    'cache-deployer-deployment',
    'ml-pipeline-scheduledworkflow',
    'metadata-envoy-deployment',
    'workflow-controller',
  ],
  "airflow": [
    "airflow-scheduler",
    "airflow-statsd",
    "airflow-webserver",
    "airflow-postgresql",
    "airflow-redis",
    "airflow-triggerer",
    "airflow-worker",
    "airflow-create-user",
    "airflow-run-airflow-migrations",
  ]
}
resources = []
for arg in cfg.get('to-run', []):
  if arg in groups:
    resources += groups[arg]
  else:
    # also support specifying individual services instead of groups, e.g. `tilt up a b d`
    resources.append(arg)
config.set_enabled_resources(resources)

for p in listdir('./services', recursive=True):
  if p.endswith('Tiltfile'):
    load_dynamic(p)
