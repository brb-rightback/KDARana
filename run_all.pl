#!/usr/bin/perl

system("perl setup_config.pl $ARGV[0] $ARGV[1]");
system("perl ./convert_histo.pl 1");
system("perl run_det.pl");
system("perl run_xf.pl");
system("perl run_stat.pl");
system("./bin/merge_hist_xs -r0 -l0 -h1");
