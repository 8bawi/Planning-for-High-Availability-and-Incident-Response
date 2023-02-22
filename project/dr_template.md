# Infrastructure

## AWS Zones
**Primary**: us-east-2
**Secondary**:us-west-1

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

### Descriptions
More detailed descriptions of each asset identified above.
Web: Responsible for running the flask app and respond to API requests.

EKS(Elastic Kubernetes Service) Control: Responsible for Managing and running workload, requested by the Admin.

EKS(Elastic Kubernetes Service) Nodes: Responsible for running the workload on the cluster.

VPC: Responsible for providing the IP CIDR for Resources to be Dynamically assigned one a resource is created.

ALB (Application Load Balancer): Responsible for routing the requests from Internet to application attached to the ALB.

Aurora DB: Responsible for storing data related to the APP.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.
**Infrastructure**:

EC2 instances will be replicated on DR region.

EKS control DR will be handled by AWS as these nodes are managed by AWS.

EKS Node will have DR nodes in DR zone.

VPC there will one VPC on DR zone.

ALB there will one ALB on DR to handle traffic incase of switch.

Aurora DB has data replication from Primary DB to secondary DB on DR.


## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

1. Perform RDS Cluster failover to DR zone.
2. Confrim the Web instance is responding to API requests on DR zone after swithc over.