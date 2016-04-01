#Usage : /net/eichler/vol4/home/araja/Useful-Code/dCGH/calc_phylop.sh dels/phylop 
#mkdir -p dels/phylop
mkdir -p $1
cd $1
awk 'OFS="\t"{print $1,$2,$3,$1"_"$2"_"$3 >> $1".bed"; close($1".bed")}' ../calls.bed
ls chr*.bed|sed 's/.bed//' >in.txt
for i in `cat in.txt`;do echo /net/eichler/vol23/projects/simons_genome_project/nobackups/tychele/phylop/bigWigAverageOverBed ~tychele/phylop/"$i".phyloP46way.bw "$i".bed -minMax "$i"_phylop.txt >>gen.sh;done
qsub -cwd -l ssd=TRUE -pe orte 10-24 -sync y ~jlhudd/src/general_pipe/sge_commands.sh gen.sh
for i in *phylop.txt;do awk -F "_" 'OFS="\t"{print $1,$2,$3,$7,$10}' $i|awk 'OFS="\t"{print $1,$2,$3,$8,$10}' >>../phylop.bed;done
sed -i '1i\contig\tstart\tstop\tavg_phylop\tmax_phylop' ../phylop.bed
cd ../../
