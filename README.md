# aws
This is the github repository for the Eichler lab Amazon Web Services (AWS) pipelines

## Eichler Lab Cloud Cost sheets as of August 1, 2016 (On-demand)
| Pipeline	| Analysis type |	Instance type |	Instance cost per hour ($)	| Volume size | 	Volume cost per hour ($) |	Number of cores on instance	| Memory (GB) on instance	| Number of samples run in test |	Actual hours to run	cpu hours by analysis type |	cpu hours by sample |	cost per sample ($) |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| FreeBayes |	Family	| m4.10xlarge	| 2.394	| 1 x 1000 GB	| 0.13	| 40	| 160	| 4	| 8	| 320 |	80	| 5.05| 
| GATK |	Family	| m4.10xlarge	| 2.394	| 1 x 1000 GB	| 0.13	| 40	| 160	| 4	| 20	| 800	| 200	| 12.62| 
| Lumpy	| Family	| m4.xlarge	| 0.239	| 1 x 1000 GB	| 0.13	| 4	| 16	| 4	| 8	| 24	| 8	| 0.74| 
| QC | 	Sample	| m4.2xlarge	| 0.479	| 1 x 1000 GB	| 0.13	| 8	| 32	| 4	| 7	| 56	| 14	| 1.07| 
| VariationHunter |	Family	| m4.2xlarge	| 0.479	| 1 x 1000 GB	| 0.13	| 8	| 32	| 4 |	6	| 48	| 12	| 0.91| 
| Wham | Family	| m4.2xlarge	| 0.479	| 1 x 1000 GB |	0.13	| 8	| 32	| 4	| 6	| 48	| 12	| 0.91| 
| Whamg | 	Family	| m4.2xlarge	| 0.479	| 1 x 1000 GB	| 0.13	| 8	| 32	| 4	| 4	| 32	| 8	| 0.61| 
* Note: QC includes Picard Hybridization Metrics, Picard WGS Metrics, Flagstat, Wham to calculate insert size median and standard deviation, Samtools to extract mitochondria												
