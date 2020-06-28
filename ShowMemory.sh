#!/bin/bash
#
# *************************************************************************
# *************************************************************************
# * ShowMemory.sh - ShowMemory - shows Free RAM, Used RAM, Total RAM, etc.
# * Copyright © 2020 Erik T Ashfolk (<atErïk＠ÖυťĹöōķ·ċōm;atErïk＠AśhFölķ·ćōm>, Do Not Copy 
# *  Adrs, Type in English/basic-latin char. No Soliciting Permitted). All rights reserved.
# * Written initially on 2020-06-24 by Erik T Ashfolk.
# * Released with below Licenses+Restrictions+Permissions:
# *  (*) Do Not Use My/Our Contribution(s) To Kill/Harm/Violate(or Steal-from)(Any) Human/Community,Earth,etc.
# *  (*) GNU General Public License v3 (GPL v3) https://www.GNU.org/licenses/gpl-3.0.en.html 
# *
# * ShowMemory.sh v0.58
# * It shows Free RAM, Used RAM, Total RAM, etc memory size/amount.
# *************************************************************************
# *************************************************************************
#
# A sample/example Output of "vm_stat" command, on macOSX:
# 01 |Mach Virtual Memory Statistics: (page size of 4096 bytes)
# 02 |Pages free:                               29349.
# 03 |Pages active:                            687993.
# 04 |Pages inactive:                          682768.
# 05 |Pages speculative:                         4862.
# 06 |Pages throttled:                              0.
# 07 |Pages wired down:                        360086.
# 08 |Pages purgeable:                           3178.
# 09 |"Translation faults":                 121433300.
# 10 |Pages copy-on-write:                    2739034.
# 11 |Pages zero filled:                     90069451.
# 12 |Pages reactivated:                      2688913.
# 13 |Pages purged:                            472357.
# 14 |File-backed pages:                       317426.
# 15 |Anonymous pages:                        1058197.
# 16 |Pages stored in compressor:              899695.
# 17 |Pages occupied by compressor:            331547.
# 18 |Decompressions:                         1301864.
# 19 |Compressions:                           2410285.
# 20 |Pageins:                                9984186.
# 21 |Pageouts:                                 86461.
# 22 |Swapins:                                      0.
# 23 |Swapouts:                                   192.


LnNumbr=1;
totalPhysicalMem=0;
pgSizeRcvd=0;
pgFreeRcvd=0;
pgActvRcvd=0;
pgInactvRcvd=0;
pgSpecuRcvd=0;
pgThrotRcvd=0;
pgWirdDnRcvd=0;
pgPurgblRcvd=0;
pgFileBkdRcvd=0;
pgCmprsStorRcvd=0;
pgCmprsrRcvd=0;

while read -u3 -r Ln ; do
	memInLn="${Ln//\ /}";  memInLn="${memInLn#*\:}";  memInLn="${memInLn//\./}";
	memInLn=$(( ( $memInLn * pgSize ) / 1048576 ));		
	
	if [ "$pgSizeRcvd" -eq "0" ] && [[ "$Ln" == *"bytes"* ]] ; then
		# removing anything before "of " & this word itself ; removing all after " bytes" & this word itself ;
		pgSize="${Ln#*of\ }";  pgSize="${pgSize%\ bytes*}";
		pgSizeRcvd=1;
		# printf "\174 $pgSize \174\n";
		memInLn="MB";
	fi;
	if [ "$pgFreeRcvd" -eq "0" ] && [[ "$Ln" == *"Pages free"* ]] ; then
		# removing anything before colon & the colon ; removing all spaces ; removing all dots ;
		pgFree="${Ln#*\:}";  pgFree="${pgFree//\ /}";  pgFree="${pgFree//\./}";
		pgFreeRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgFree ));
		# printf "\174 $pgFree \174\n";
	fi;
	if [ "$pgActvRcvd" -eq "0" ] && [[ "$Ln" == *"Pages active"* ]] ; then
		pgActv="${Ln#*\:}";  pgActv="${pgActv//\ /}";  pgActv="${pgActv//\./}";
		pgActvRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgActv ));
	fi;
	if [ "$pgInactvRcvd" -eq "0" ] && [[ "$Ln" == *"Pages inactive"* ]] ; then
		pgInactv="${Ln#*\:}";  pgInactv="${pgInactv//\ /}";  pgInactv="${pgInactv//\./}";
		pgInactvRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgInactv ));
	fi;
	if [ "$pgSpecuRcvd" -eq "0" ] && [[ "$Ln" == *"Pages speculative"* ]] ; then
		pgSpecu="${Ln#*\:}";  pgSpecu="${pgSpecu//\ /}";  pgSpecu="${pgSpecu//\./}";
		pgSpecuRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgSpecu ));
	fi;
	if [ "$pgThrotRcvd" -eq "0" ] && [[ "$Ln" == *"Pages throttled"* ]] ; then
		pgThrot="${Ln#*\:}";  pgThrot="${pgThrot//\ /}";  pgThrot="${pgThrot//\./}";
		pgThrotRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgThrot ));
	fi;
	if [ "$pgWirdDnRcvd" -eq "0" ] && [[ "$Ln" == *"wired down"* ]] ; then
		pgWirdDn="${Ln#*\:}";  pgWirdDn="${pgWirdDn//\ /}";  pgWirdDn="${pgWirdDn//\./}";
		pgWirdDnRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgWirdDn ));
	fi;
	if [ "$pgPurgblRcvd" -eq "0" ] && [[ "$Ln" == *"Pages purgeable"* ]] ; then
		pgPurgbl="${Ln#*\:}";  pgPurgbl="${pgPurgbl//\ /}";  pgPurgbl="${pgPurgbl//\./}";
		pgPurgblRcvd=1;
	fi;
	if [ "$pgFileBkdRcvd" -eq "0" ] && [[ "$Ln" == *"File-backed"* ]] ; then
		pgFileBkd="${Ln#*\:}";  pgFileBkd="${pgFileBkd//\ /}";  pgFileBkd="${pgFileBkd//\./}";
		pgFileBkdrRcvd=1;
	fi;
	if [ "$pgCmprsStorRcvd" -eq "0" ] && [[ "$Ln" == *"stored in compressor"* ]] ; then
		pgCmprsStor="${Ln#*\:}";  pgCmprsStor="${pgCmprsStor//\ /}";  pgCmprsStor="${pgCmprsStor//\./}";
		pgCmprsStorRcvd=1;
	fi;
	if [ "$pgCmprsrRcvd" -eq "0" ] && [[ "$Ln" == *"occupied by compressor"* ]] ; then
		pgCmprsr="${Ln#*\:}";  pgCmprsr="${pgCmprsr//\ /}";  pgCmprsr="${pgCmprsr//\./}";
		pgCmprsrRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgCmprsr ));
	fi;

	if [ "$LnNumbr" -le "9" ] ; then
		m="0$LnNumbr";
		# the "\174" is pipe-symbol's value in Octal number.
		printf "\174$m\174 $Ln \174 $memInLn \174\n";
	else
		printf "\174$LnNumbr\174 $Ln \174 $memInLn \174\n";
	fi;
	LnNumbr=$(( $LnNumbr + 1 ));
done 3< <(/usr/bin/vm_stat);
# We used "vm_stat", as it appears that, it does not need privileged access to run

# 1 MegaBytes(MB) = 1048576 Bytes
echo "Free (Physical/RAM) Memory      : $(( ( $pgFree * $pgSize ) / 1048576 ))";
echo "Purgeable (Physical/RAM) Memory : $(( ( $pgPurgbl * $pgSize ) / 1048576 ))";
echo "Cached (Physical/RAM) Memory    : $(( ( $pgFileBkd * $pgSize ) / 1048576 ))";
echo "Used (Physical/RAM) Memory      : $(( (( $pgActv + $pgWirdDn + $pgCmprsr ) * $pgSize ) / 1048576 ))";
echo "Total (Physical/RAM) Memory     : $(( ( $totalPhysicalMem * $pgSize ) / 1048576 ))";


# Below bash command-set will output actual RAM mem size, but this command may need privileged access to run:
# ramBytes="`sysctl hw.memsize`"; echo "$ramBytes" ; ramBytes="${ramBytes#*\:\ }"; echo "$ramBytes Bytes"; ramMB=$(( $ramBytes / 1048576 )); echo "$ramMB MB"; ramGB=$(( $ramBytes / 1073741824 )); echo "$ramGB GB"; unset ramBytes ramMB ramGB;

unset m memInLn;
unset pgSize pgFree pgActv pgInactv pgSpecu pgThrot pgWirdDn pgCmprsr;

unset Ln LnNumbr totalPhysicalMem;
unset pgSizeRcvd pgFreeRcvd pgActvRcvd pgInactvRcvd pgSpecuRcvd pgThrotRcvd pgWirdDnRcvd pgPurgblRcvd;
unset pgCmprsStorRcvd pgCmprsrRcvd;
