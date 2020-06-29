#!/bin/bash
#
# *************************************************************************
# *************************************************************************
# * ShowMemory.sh - ShowMemory - it shows Free/Used/Total/etc RAM/Memory Size/Amount.
# * Copyright © 2020 Erik T Ashfolk (<atErïk＠ÖυťĹöōķ·ċōm;atErïk＠AśhFölķ·ćōm>, Do Not Copy 
# *  Eml-Adrs, Type in English/basic-latin, No Soliciting Permitted). All rights reserved.
# * Written initially on 2020-06-24 by Erik T Ashfolk.
# * Released with below Licenses+Restrictions+Permissions:
# *  (*) Do Not Use My/Our Contribution(s) To Kill/Harm/Violate(or Steal-from)(Any) Human/Community,Earth,etc.
# *  (*) GNU General Public License v3 (GPL v3) https://www.GNU.org/licenses/gpl-3.0.en.html 
# *
# * ShowMemory.sh v0.59
# * It shows Free RAM, Used RAM, Total RAM, etc memory size/amount.
# *************************************************************************
# *************************************************************************
#
# Line# | A sample/example Output of "vm_stat" command, on macOSX:
# 01    | Mach Virtual Memory Statistics: (page size of 4096 bytes)
# 02    | Pages free:                               29349.
# 03    | Pages active:                            687993.
# 04    | Pages inactive:                          682768.
# 05    | Pages speculative:                         4862.
# 06    | Pages throttled:                              0.
# 07    | Pages wired down:                        360086.
# 08    | Pages purgeable:                           3178.
# 09    | "Translation faults":                 121433300.
# 10    | Pages copy-on-write:                    2739034.
# 11    | Pages zero filled:                     90069451.
# 12    | Pages reactivated:                      2688913.
# 13    | Pages purged:                            472357.
# 14    | File-backed pages:                       317426.
# 15    | Anonymous pages:                        1058197.
# 16    | Pages stored in compressor:              899695.
# 17    | Pages occupied by compressor:            331547.
# 18    | Decompressions:                         1301864.
# 19    | Compressions:                           2410285.
# 20    | Pageins:                                9984186.
# 21    | Pageouts:                                 86461.
# 22    | Swapins:                                      0.
# 23    | Swapouts:                                   192.


LnNumbr=1;

totalPhysicalMem=0;
pgFree=0;
pgActv=0;
pgInactv=0;
pgSpecu=0;
pgThrot=0;
pgWirdDn=0;
pgPurgbl=0;
pgFileBkd=0;
pgCmprsStor=0;
pgCmprsr=0;

# Flag Variables for above content varibales:
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
	# Removing all 'space'-chars ; Removing 1st ":" colon in left-side, & anything in it's left side:
	memInLn="${Ln//\ /}";  memInLn="${memInLn#*\:}";
	# Removing all '.' dot-chars:
	memInLn="${memInLn//\./}";
	# It contains/shows Number of "Pages"-memory-unit, Multiplying With pgSize bytes = Total Bytes,
	# then Dividing with 1MBytes(1048576) to get size in MB: 
	memInLn=$(( ( $memInLn * pgSize ) / 1048576 ));		
	# Collecting "Page" count/number from a specific line (only one time), when that line is read in this loop:
	if [ "$pgSizeRcvd" -eq "0" ] && [[ "$Ln" == *"bytes"* ]] ; then
		# removing anything before "of " & this word itself ; removing all after " bytes" & this word itself ;
		pgSize="${Ln#*of\ }";  pgSize="${pgSize%\ bytes*}";
		# As we have read this specific line, this if-condition-then-fi section needs to be skipped in next loops:
		pgSizeRcvd=1;
		# printf "\174 $pgSize \174\n";  # debug
		# Only for this top/1st line, the memInLn needs ot be "MB" to show the "MB" in the header/top row line:
		memInLn="MB";
	else
		# When a line is not the top-most header-row line (with the text "(page size of 4096 bytes)")
		#  then we add 9-extra-space-chars at 32nd-position, to align it with top/header-row:
		Ln="${Ln:0:32}         ${Ln:32}";
	fi;
	if [ "$pgFreeRcvd" -eq "0" ] && [[ "$Ln" == *"Pages free"* ]] ; then
		# Removing 1st colon in left-side, & the colon itself ; Removing all spaces ; Removing all dots ;
		pgFree="${Ln#*\:}";  pgFree="${pgFree//\ /}";  pgFree="${pgFree//\./}";
		pgFreeRcvd=1;
		totalPhysicalMem=$(( $totalPhysicalMem + $pgFree ));
		# printf "\174 $pgFree \174\n";  # debug
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
	
	# showing each line from "vm_stat" command on screen plus few more data 
	if [ "$LnNumbr" -le "9" ] ; then
		m="0$LnNumbr";
		# the "\174" is "|" pipe-symbol's RefNum value in Octal number-system. \011 is Tab 
		printf "\174$m\174 $Ln \174 $memInLn\011 \174\n";
	else
		printf "\174$LnNumbr\174 $Ln \174 $memInLn\011 \174\n";
	fi;
	LnNumbr=$(( $LnNumbr + 1 ));
done 3< <(/usr/bin/vm_stat);
# We used "vm_stat", as it appears that, it does not need privileged access to run


# 1 MegaBytes(MB) = 1048576 Bytes
echo "CATEGORY OF MEMORY              : MB (MegaBytes)";
echo "Free (Physical/RAM) Memory      : $(( ( $pgFree * $pgSize ) / 1048576 ))";
echo "Purgeable (Physical/RAM) Memory : $(( ( $pgPurgbl * $pgSize ) / 1048576 ))";
echo "Cached (Physical/RAM) Memory    : $(( ( $pgFileBkd * $pgSize ) / 1048576 ))";
echo "Used (Physical/RAM) Memory      : $(( (( $pgActv + $pgWirdDn + $pgCmprsr ) * $pgSize ) / 1048576 ))";
echo "Total (Physical/RAM) Memory     : $(( ( $totalPhysicalMem * $pgSize ) / 1048576 ))";


# Below bash command-set will output actual RAM mem size, but below command may need privileged access to run:
# ramBytes="`sysctl hw.memsize`"; echo "$ramBytes" ; ramBytes="${ramBytes#*\:\ }"; echo "$ramBytes Bytes"; ramMB=$(( $ramBytes / 1048576 )); echo "$ramMB MB"; ramGB=$(( $ramBytes / 1073741824 )); echo "$ramGB GB"; unset ramBytes ramMB ramGB;

unset m memInLn;
unset pgSize pgFree pgActv pgInactv pgSpecu pgThrot pgWirdDn pgCmprsr;

unset Ln LnNumbr totalPhysicalMem;
unset pgSizeRcvd pgFreeRcvd pgActvRcvd pgInactvRcvd pgSpecuRcvd pgThrotRcvd pgWirdDnRcvd pgPurgblRcvd;
unset pgCmprsStorRcvd pgCmprsrRcvd;
