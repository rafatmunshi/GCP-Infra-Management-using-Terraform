# GCP Settings
gcp_region_1  = "us-central1"
gcp_zone_1    = "us-central1-b"
# gcp_auth_file = "../coastalbloom.json"
gcp_auth_file = "keyfile.json"
# GCP Netwok
private_subnet_cidr_1  = "10.128.0.0/20"

# define GCP project name
app_project = "coastal-bloom-277007"

# define application name
app_name = "flaskapp"

# define application domain
app_domain = "test"

# define application environment
app_environment= "production"

app_node_count = 2

machine_type = "e2-medium"

bucket_name = "bucketprod"
