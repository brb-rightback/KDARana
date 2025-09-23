#!/usr/bin/perl

for (my $i=0;$i != 100; $i++){
    my $lee_strength = 0.5 + 0.04 * $i;
    if ($i % 6 == 5){
	system("./bin/merge_hist -r0 -e2 -l$lee_strength > ./mcstat/mc_stat_$i\.log");
    }else{
	system("./bin/merge_hist -r0 -e2 -l$lee_strength > ./mcstat/mc_stat_$i\.log &");
    }
    
}
