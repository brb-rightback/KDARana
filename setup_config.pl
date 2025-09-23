#!/usr/bin/perl

my $new_config = $ARGV[0];
my $fakedata = $ARGV[1];
print "New configuration is $new_config for $fakedata\n";

my $old_config = "NONE";
open my $file, '<', "config.txt" or die "Cannot open config.txt: $!";
my $old_config = <$file>;
print "The old config is $old_config\n";
close $file;

my $counter = 0;
while($counter<100){
  my $directory_path = "hist_rootfiles_$old_config\_$counter";
  if(-d $directory_path){
   $counter++; 
  }else{
    last;
  }
}
if ($counter==100) {
  print "Too many hist_rootfiles";
  exit 1;
}

print "Moving old files to hist_rootfiles_$old_config\_$counter\n";
system("mv hist_rootfiles hist_rootfiles_$old_config\_$counter");
system("mv mcstat hist_rootfiles_$old_config\_$counter/");
system("mv merge_xs.root hist_rootfiles_$old_config\_$counter/");
system("mkdir hist_rootfiles_$old_config\_$counter/configuration/");
system("cp configurations/*.txt hist_rootfiles_$old_config\_$counter/configuration/");
system("rm config.txt");

system("mkdir hist_rootfiles");
system("mkdir hist_rootfiles/DetVar/");
system("mkdir hist_rootfiles/XsFlux/");
system("mkdir mcstat");

system("cp configurations/$new_config/*.txt configurations/");

if ($fakedata ne "data") {
  system("cp configurations/$new_config/$fakedata/*.txt configurations/");
  my $new_config = $new_config . "_" . $fakedata;
}

open(FH, '>', "config.txt") or die $!;
print FH $new_config;
close(FH);
