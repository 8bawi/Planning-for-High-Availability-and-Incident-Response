# Infrastructure

## AWS Regions
**Primary**: us-east-2

avalibility zones: us-east-2a, us-east-2b, us-east-2c

**Secondary**:us-west-1

avalibility zones: us-west-1b, us-west-1c

## Servers and Clusters

### Table 1.1 Summary
| Asset                                   | Purpose                                                   | Size       | Qty | DR                                                                                    |
|-----------------------------------------|-----------------------------------------------------------|------------|-----|---------------------------------------------------------------------------------------|
| Web                                     | Running the Flask Application                             | t3.micro   | 3   | Distributed to all available AZ for the Main Region, same for the DR site.            |
| EKS Control | Manages and Controls the EKS Cluster                      | N/A        | N/A | Managed by AWS, ensure the availability of the master nodes.                          |
| EKS Nodes   | Run K8s workloads, including the Prom-graf stack          | t3.medium  | 2   | Deployed to multiple AZ and to DR site.                                               |
| VPC            | Provides the IP CIDR for AWS Resources VPC in Each region | X.X.0.0/16 | 2   | One VPC per region.                                                                   |
| ALB         | Provides access to grafana, prometheus and web instances  | N/A        | 2   | One ALB per region.                                                                   |
| Aurora DB                               | Data repository for Application.                          | t3.small   | 2   | 1 cluster per region, 2 instances in each cluster. zone1(Main) replicate to zone2(DR) |
| S3                               | repo for TF state file                          | N/A   | 2   | 1 bucket per region |
| AMI                               | AMI for the ubuntu web server                          | N/A   | 2   | 1 AMI per region |

### Descriptions
More detailed descriptions of each asset identified above.

EC2(Elastic Compute Cloud, Web Application): Responsible for running the flask app and respond to API requests.

EKS(Elastic Kubernetes Service) Control: Responsible for Managing and running workload, requested by the Admin.

EKS(Elastic Kubernetes Service) Nodes: Responsible for running the workload on the cluster.

VPC(Virtual Private Cloud): Responsible for providing the IP CIDR for Resources to be Dynamically assigned one a resource is created.

ALB (Application Load Balancer): Responsible for routing the requests from Internet to application attached to the ALB.

Aurora DB: Responsible for storing data related to the APP.

S3: Bucket to track the TF state of each zone in its corresponding region.

AMI: the image used by the EC2 nodes  zone1=ami-0df92fab4fc936ce1, zone2= ami-0cf0917c6fa17e621

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.
**Infrastructure**:

1. Ensure the infrastructe is set up and working in the DR site.


## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

1. Create a cloud load balancer and point DNS to the load balancer. This way you can have multiple instances behind 1 IP in a region. During a failover scenario, you would fail over the single DNS entry at your DNS provider to point to the DR site. This is much more intelligent than pointing to a single instance of a web server.
2. Have a replicated database and perform a failover on the database. While a backup is good and necessary, it is time-consuming to restore from backup. In this DR step, you would have already configured replication and would perform the database failover. Ideally, your application would be using a generic CNAME DNS record and would just connect to the DR instance of the database.
