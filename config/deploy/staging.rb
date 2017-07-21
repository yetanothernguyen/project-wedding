server "139.59.241.76", user: "deploy", roles: %w{app db web}

set :application, "project-wedding-staging"
set :rails_env, "staging"