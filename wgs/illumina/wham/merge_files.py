import pandas as pd
import glob
import argparse
import os

#Usage : python join_files.py final_biallelic_dups_filtered_merged_with_inh.txt dels final_biallelic_dups_filtered_merged_with_inh_annotations.txt

if __name__ == "__main__":
	
	parser = argparse.ArgumentParser()
	parser.add_argument("filtered_genotypes", help="filtered genotypes with events annotated")
	parser.add_argument("dirname",help="folder inside which the files to be merged resides")
	parser.add_argument("outfile" , help="required output file")
	args = parser.parse_args()
	os.chdir(args.dirname)
	fn=[]
	for name in glob.glob('*.bed'):
	
		if not name in ["calls.bed" , "final_calls.bed"]:
			fn.append(name)


	fn.sort()
	calls = pd.read_table(args.filtered_genotypes)
	for i in fn :
		df=pd.read_table(i)
		calls=pd.merge(calls,df,on=["contig","start","stop"],how="left")

	calls.to_csv(args.outfile,sep='\t',index=False)

