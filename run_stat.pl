#!/usr/bin/perl

my $config = "NONE";
open my $file, '<', "config.txt" or die "Cannot open config.txt: $!";
my $config = <$file>;
chomp($config);
close $file;
print "Running MC stat for $config\n";

system("./bin/merge_hist -r0 -l0 -e2 > mcstat/mc_stat.log&");

if($config =~ /"presel"/){
  system("bin/stat_pred_cov_matrix -r0 -h1&");
  system("bin/stat_cov_matrix -r0 -h1");

}else{
  open my $file, '<', "configurations/xs_ch.txt" or die "Cannot open configurations/xs_ch.txt: $!";
  my $sigch = <$file>;
  chomp($sigch);
  close $file;
  print "Signal channel is $sigch\n";
  system("sed -i '/$sigch/s/7.*cv_spline.*0/7    cv_spline    1/' configurations/cov_input.txt");
  my $found = 0;
  open(my $fh, '<', "configurations/cov_input.txt");
  while (my $line = <$fh>) {
    my $pattern = $sigch . ".*7.*cv_spline.*1";
    if ($line =~ $pattern) {
      system("perl run_mc_stat.pl");
      $found = 1;
      last;
    }
  }
  close($fh);
  if($found==0){
    print "WARNING editing cov_input.txt failed\n"
  }
  system("sed -i '/$sigch/s/7.*cv_spline.*1/7    cv_spline    0/' configurations/cov_input.txt");
}
