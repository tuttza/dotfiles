#!/usr/bin/perl

use strict;
use warnings;
use Cwd;
use File::Basename;

my $home = $ENV{"HOME"};
my $current_dir = getcwd();

# The CONFIGS hash contains a list of key value pairs where
# the key is full path for the config in your config repo,
# and value is the location for which you want the symlink
my %CONFIGS = (
  "$current_dir/kakrc" => "$home/.config/kak/kakrc",
  "$current_dir/zshrc" => "$home/.zshrc",
  "$current_dir/vimrc" => "$home/.vimrc",
  "$current_dir/tmux.conf" => "$home/.tmux.conf",
  "$current_dir/ssh_config" => "$home/.ssh/config",
  "$current_dir/nanorc" => "$home/.nanorc"
);

while( my($k, $v) = each %CONFIGS )
{
  my $base_path = dirname($v);

  if ( -l $v ) {
    print "[✓] LINKED: $k -> $v\n";
    next;
  }

  if ( -d $base_path ) {
    my $symd = symlink($k, $v);

    if ($symd) {
      print $k . "-> " . $v . "\n";
    } else {
      print "[✕] FAILED TO LINK: $k -> $v\n";
    }

  } else {
    print "$base_path directory is missing. Please create it and run this script again.\n";
  }
}

