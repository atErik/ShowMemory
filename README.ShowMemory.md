# ShowMemory
A (set of) Tool/Script(s) To Show/Display Free/Used/Total/etc Memory/RAM Amount/Size, on macOS/macOSX, BSD/Unix, etc.<br/>
Later Linux support will be added. Later GUI tool will be added.

## License(s):
ShowMemory.sh - ShowMemory - it shows Free/Used/Total/etc RAM/Memory Size/Amount.<br/>
Copyright © 2020 Erik T Ashfolk (&lt;at&#69;rïk＠Ö&#965;ťĹö&#333;ķ·ċ&#333;m;at&#69;rïk＠&#65;śh&#70;ölķ·ć&#333;m&gt;, Do Not Copy<br/>
&#160;&#160;Eml-Adrs, Type in English/basic-latin char, No Soliciting Permitted). All rights reserved.<br/>
Released with below <b>License(s)</b>+<b>Restrictions</b>+<b>Permissions</b>:<br/>
&#160;(&#42;) Do Not Use My/Our Contribution(s) To Kill/Harm/Violate(or Steal-from)(Any) Human/Community,Earth,etc.<br/>
&#160;(&#42;) GNU General Public License v3 (GPL v3) https://www.GNU.org/licenses/gpl-3.0.en.html<br/>
<br/>
&#160;(Written initially on 2020-06-24 by Erik T Ashfolk)&#46;<br/>
<br/>
&#160;(All other trademarks, etc cited here are the property of their respective owners&#46;)<br/>
&#160;(All other copyright items cited here are the copyright of their respective author/creator&#46;)<br/>

## Info:
Currently the "<a href="ShowMemory.sh">ShowMemory.sh</a>" is a bash-shell based script/tool, 
 & for macOSX.

<div width="100%">I'm/We're now calculating memory size/amount in this way : by getting data 
 from output of "vm_stat" command, unfortunately its not super accurate now. If you want to 
 correct me/us/source further, pls don't hesitate to create an "Issue" under this "ShowMemory" 
 repo/project with your info & link, Thanks in advance. Currently, we're using below specific 
 data fields from "vm_stat", to get the total for a specific category of memory:<dl>
<dd> 
Abbreviations : pg = Page (each page is 4096 bytes) . 1048576 is Bytes in 1MB(MegaBytes) . Purgbl = Purgeable . 
WirdDn = Wired Down . FileBkd = File-backed . Actv = Active . Cmprsr = Occupied by Compressor .<br/>
"CATEGORY OF MEMORY		: MB (MegaBytes)"<br/>
"Free (Physical/RAM) Memory	= ( $pgFree * $pgSize ) / 1048576 "<br/>
"Purgeable (Physical/RAM) Memory	= ( $pgPurgbl * $pgSize ) / 1048576 "<br/>
"Cached (Physical/RAM) Memory	= ( $pgFileBkd * $pgSize ) / 1048576 "<br/>
"Used (Physical/RAM) Memory	= (( $pgActv + $pgWirdDn + $pgCmprsr ) * $pgSize ) / 1048576 "<br/>
"Total (Physical/RAM) Memory	= ( $totalPhysicalMem * $pgSize ) / 1048576 "</dd>
</dl>
</div>

## Tested-on/Supported Platform(s):
Script/tool was tested, it Worked.<br/>
<div width="100%">Tested on:<dl>
<dd>Mac:~ atErik$ uname -a<br/>
 Darwin Mac.local 19.5.0 Darwin Kernel Version 19.5.0: Tue May 26 20:41:44 PDT 2020; root:xnu-6153.121.2~2/RELEASE_X86_64 x86_64<br/>
 Mac:~ atErik$ bash --version<br/>
 GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)<br/>
 Copyright (C) 2007 Free Software Foundation, Inc.<br/>
 Mac:~ atErik$ sh --version<br/>
 GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)<br/>
 Copyright (C) 2007 Free Software Foundation, Inc.<br/>
 Mac:~ atErik$ zsh --version<br/>
 zsh 5.7.1 (x86_64-apple-darwin19.0)</dd>
</dl>
</div>

## How To Use/Run:
Any executable file needs the "Execute" attribute bit set, & if thats not done already:<br/>
execute below command in CLI "Terminal"/shell:<br/>
&#160;&#160;chmod&#160;&#160;+x&#160;&#160;ShowMemory.sh<br/>
&#160;&#160;&#46;/ShowMemory&#46;sh<br/>
&#160;&#160;(above command will show memory stat/info on screen)<br/>
