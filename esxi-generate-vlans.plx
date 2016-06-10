#!/usr/bin/perl
# Generates esxcli commands to add vlans to a standard (non DVS) switch. 
# Expects a CSV  for input in the form:
#<portgroup_name>,<vswitch_name>,<vlanid>
#
# Author: the-scriptinator
# You can use this to do what you like
# But if you get rich using it, please pay me or employ me.



while(<>){
	chomp;
	($portgroup,$vswitch,$vlanid) = split /,/;
	
	#if there are spaces in 4portgroup replace them with single underscores
	if($portgroup =~ / /){
		$portgroup =~ s/ /_/g;
		$portgroup =~ s/__*/_/g;
	}

	#check the vlan ID is in the valid range 0-4096	
	if ( $vlanid >4096 or $vlanid<0 )
	{
		print STDERR "bad vlan ID $vlan skipping\n";
		next;
	}

	print<<EOF
esxcli network vswitch standard portgroup add -v $vswitch -p $portgroup
esxcli network vswitch standard portgroup set -p $portgroup -v $vlanid

EOF
}
