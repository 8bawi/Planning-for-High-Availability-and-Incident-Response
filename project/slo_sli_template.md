# API Service

| Category     | SLI | SLO                                                                                                         |
|--------------|-----|-------------------------------------------------------------------------------------------------------------|
| Availability |  total number of successful requests / total number of requests >=0.99  | 99%                                                                                                         |
| Latency      |    buckets of requests in a histogram showing the 90th percentile over the last n {period} <= 100ms | 90% of requests below 100ms                                                                                 |
| Error Budget |   total number of unsuccessful request = (1- total number of successful request )>=0.2 over n {period} persumbaly 30 days | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   |   total number of successful [2xx] requests over n {5m} >= 5 RPS  | 5 RPS indicates the application is functioning                                                              |
