#!/usr/bin/perl

my $config = "NONE";
open my $file, '<', "config.txt" or die "Cannot open config.txt: $!";
my $config = <$file>;
close $file;
print "Running xf sys for $config\n";

system("./bin/xf_cov_matrix -r3 -h1&");
system("./bin/xf_cov_matrix -r6 -h1&");

if($config eq "rate" || $config eq "rate_nons"){
  print "Nominal signal normalization treatment\n";
  system("./bin/xs_cov_matrix -r17 -n0 -h1&");
  system("./bin/xf_cov_matrix -r17 -h1&");
  system("./bin/xf_cov_matrix -r14 -h1&");
  system("./bin/xf_cov_matrix -r15 -h1&");
  system("./bin/xf_cov_matrix -r16 -h1");
}else{
  print "Normalizing signal in sys calculation\n";
  system("./bin/xs_cov_matrix -r17 -n1 -h1&");
  system("./bin/xs_cov_matrix -r17 -n2 -h1&");
  system("./bin/xs_cov_matrix -r14 -n2 -h1&");
  system("./bin/xs_cov_matrix -r15 -n2 -h1&");
  system("./bin/xs_cov_matrix -r16 -n2 -h1");
}
