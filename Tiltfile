k8s_context('playground')

config.define_string_list("to-run", args=True)
cfg = config.parse()
groups = {
  'mysql': ['mysql', 'phpmyadmin'],
  'redis': ['redis-master', 'redis-commander'],
  'mongodb': ['mongodb', 'mongo-express'],
  'postgresql': ['postgresql', 'pgadmin', 'pg-upload-data'],
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
