#!/usr/bin/perl
#
# kakasi test program for kakasi v2.2.5 (Perl module v0.1)
#    Ken-ichi Hirose <kenzo-@tama.or.jp>
#

$kakasi = "kakasi";

$process_all = 0;
$process_all = 1 if ($ARGV[0] eq "-d");

sub use_test {
BEGIN { $| = 1; print "\nPackage test\n"; }
END {print " use             => Fail\n" unless $loaded;}
    use Text::Kakasi;
    $loaded = 1;
    print " use             => Complite\n";

    ######################### End of black magic.

    if ( Text::Kakasi::getopt_argv('kakasi','-w') == 0 ) {
	    if ( Text::Kakasi::do_kakasi("1") != NULL ) {
		    if ( Text::Kakasi::close_kanwadict() == 0 ) {
				print " getopt_argv     => Complite\n";
				print " do_kakasi       => Complite\n";
				print " close_kanwadict => Complite\n";
			} else {
				print " getopt_argv     => Complite\n";
				print " do_kakasi       => Complite\n";
				print " close_kanwadict => ng\n";
			}
		} else {
			print " getopt_argv     => Complite\n";
			print " do_kakasi       => Fail\n";
			print " close_kanwadict => Fail\n";
			Text::Kakasi::close_kanwadict();
		}
    } else {
		print " getopt_argv     => Fail\n";
		print " do_kakasi       => Fail\n";
		print " close_kanwadict => Fail\n";
		Text::Kakasi::close_kanwadict();
    }
}
&use_test();

sub command_test {
    my ($argv,$in,$exp,$process) = @_;
    my ($result);
    my (@argv) = split(' ',$argv);

    open(OUT,"> kakasi.in");
    print OUT $in;
    close(OUT);

    system("$kakasi @argv <kakasi.in >kakasi.out");   # easy

    $result = '';
    open(IN,"< kakasi.out");
    while(<IN>) {
	$result .= $_;
    }
	close(IN);

    print (($result eq $exp)?"Complite":"Fail");
	print "(",length($result),"byte)";
    print STDERR "\n%$kakasi @argv <kakasi.in >kakasi.out\n"
        if ($process || $process_all);
    print STDERR "INPUT=<<__command_test__\n",$in,"__command_test__\n"
        if ($process || $process_all);
    print STDERR "\nEXPECT=<<__command_test__\n",$exp,"__command_test__\n"
        if ($process || $process_all);
    print STDERR "\nRESULT=<<__command_test__\n",$result,"__command_test__\n\n"
        if ($process || $process_all);

	unlink("./kakasi.in");
	unlink("./kakasi.out");

    return $result;
}

sub module_test {
    use Text::Kakasi;

    my ($argv,$in,$exp,$process) = @_;
    my ($result);
    my (@argv) = split(' ',$argv);

	Text::Kakasi::getopt_argv("kakasi",@argv);
	$result = Text::Kakasi::do_kakasi("$in");
	Text::Kakasi::close_kanwadict();

#print "exp:\n$exp\nresult:\n$result\n";

    print (($result eq $exp)?"Complite":"Fail");
	print "(",length($result),"byte)";
    print STDERR "\ngetopt_argv(\"kakasi\",@argv)\;\n"
        if ($process || $process_all);
    print STDERR "INPUT=<<__module_test__\n",$in,"_module_test__\n"
        if ($process || $process_all);
    print STDERR "\nEXPECT=<<__module_test__\n",$exp,"_module_test__\n"
        if ($process || $process_all);
    print STDERR "\nRESULT=<<__module_test__\n",$result,"_module_test__\n\n"
        if ($process || $process_all);

    return $result;
}

sub cross_check {
    my ($argv,$in,$exp,$process) = @_;
    my ($result1,$result2);
    my (@argv) = split $argv;

    open(OUT,"> kakasi.in");
    print OUT $in;
    close(OUT);
    system("$kakasi @argv <kakasi.in >kakasi.out");   # easy
    $result1 = '';
    open(IN,"< kakasi.out");
    while(<IN>) {
	$result1 .= $_;
    }
	close(IN);
	Text::Kakasi::getopt_argv("kakasi",@argv);
	$result2 = Text::Kakasi::do_kakasi("$in");
	Text::Kakasi::close_kanwadict();

    print (($result1 eq $result2)?"Complite":"Fail");
	print "(",length($result1),"byte,",length($result2),"byte)";
    print STDERR "RESULT=<<__command_test__\n",$result1,"\n__command_test__\n"
        if ($process || $process_all);
    print STDERR "\nRESULT=<<__module_test__\n",$result2,"\n__module_test__\n\n"
        if ($process || $process_all);

	unlink("./kakasi.in");
	unlink("./kakasi.out");

    return $result1;
}

sub test  {

	print "module => ";
    &module_test(@_);
    #&command_test(@_);
	print "\n";

}

### Basic Conversion
$sample{'euc'} = unpack('u',<<'eofeof');
MI+.DSJ2_I-.DSZ'6:V%K87-I9F]R5VEN,S*AUZ3RI<"EIJ7SI>VAO*7)I+>D
MQL2ZI*VDHJ3JI*RDR*2FI+2DMJ2DI-ZDN:&C"J2SI.RDSVMA:V%S:78R+C(N
M-2ND[Z2KI,&]\:2MI/)C>6=W:6XL;6EN9W<S,J3'I;.E\Z71I:2EZZ3'I*VD
MZPJDZ*2FI,NDMZ2_<&%T8VBD\J6SI?.ET:6DI>NTQ+:MI,[,M:2DROVDRZ3B
MN\BDPZ3&Q+JDL:3KI.BDIE=I;F1O=W.DS@J\PKG4M\&\L*3+I+>DQJ3>I,BD
MX:2_RJJDQZ2YH:,*NL>_M\C'I,^PRK*\I,Y796)086=E"CQ54DPZ:'1T<#HO
M+W=W=RYT86UA+F]R+FIP+R4W16ME;GIO+2].86UA>G4O/@JDQ[CXLZNDMZ3&
MI*2DWJ2YH:.ARKZPH:*DLZ3.I=JAO*6XI,_)K,W7I,NQ_J2XI,:YN;^WI+6D
*[*3>I+FAHZ'+"@``
eofeof
$sample{'sjis'} = unpack('u',<<'eofeof');
M@K&"S(*]@M&"S8%U:V%K87-I9F]R5VEN,S*!=H+P@U^#18.3@XV!6X-H@K6"
MQ)*X@JN"H(+H@JJ"QH*D@K*"M(*B@MR"MX%""H*Q@NJ"S6MA:V%S:78R+C(N
M-2N"[8*I@K^/D8*K@O!C>6=W:6XL;6EN9W<S,H+%@U*#DX-P@T.#BX+%@JN"
MZ0J"YH*D@LF"M8*]<&%T8VB"\(-2@Y.#<(-#@XN*PHNK@LR6LX*BE?N"R8+@
MCF>"P8+$DKB"KX+I@N:"I%=I;F1O=W."S`J.P(USC&".KH+)@K6"Q(+<@L:"
MWX*]E:B"Q8*W@4(*C<605I3%@LV(R(FZ@LQ796)086=E"CQ54DPZ:'1T<#HO
M+W=W=RYT86UA+F]R+FIP+R4W16ME;GIO+2].86UA>G4O/@J"Q8SVBDJ"M8+$
M@J*"W(*W@4*!:8^N@4&"L8+,@WF!6X-7@LV52Y=V@LF)GH*V@L2-6)!6@K."
*ZH+<@K>!0H%J"@``
eofeof
$sample{'jis'} = unpack('u',<<'eofeof');
M&R1")#,D3B0_)%,D3R%6&RA":V%K87-I9F]R5VEN,S(;)$(A5R1R)4`E)B5S
M)6TA/"5))#<D1D0Z)"TD(B1J)"PD2"0F)#0D-B0D)%XD.2$C&RA""ALD0B0S
M)&PD3QLH0FMA:V%S:78R+C(N-2L;)$(D;R0K)$$]<20M)'(;*$)C>6=W:6XL
M;6EN9W<S,ALD0B1')3,E<R51)20E:R1')"TD:QLH0@H;)$(D:"0F)$LD-R0_
M&RA"<&%T8V@;)$(D<B4S)7,E424D)6LT1#8M)$Y,-20D2GTD2R1B.T@D0R1&
M1#HD,21K)&@D)ALH0E=I;F1O=W,;)$(D3ALH0@H;)$(\0CE4-T$\,"1+)#<D
M1B1>)$@D820_2BHD1R0Y(2,;*$(*&R1".D<_-TA')$\P2C(\)$X;*$)796)0
M86=E"CQ54DPZ:'1T<#HO+W=W=RYT86UA+F]R+FIP+R4W16ME;GIO+2].86UA
M>G4O/@H;)$(D1SAX,RLD-R1&)"0D7B0Y(2,A2CXP(2(D,R1.)5HA/"4X)$])
?+$U7)$LQ?B0X)$8Y.3\W)#4D;"1>)#DA(R%+&RA""@``
eofeof

print "\nBasic Conversion test\n";
print "EUC  to SJIS... ";&test("-ieuc -osjis",$sample{'euc'},$sample{'sjis'});
print "SJIS to SJIS... ";&test("-isjis -osjis"  ,$sample{'sjis'},$sample{'sjis'});
print "JIS  to SJIS... ";&test("-inewjis -osjis"  ,$sample{'jis'},$sample{'sjis'});
print "EUC  to JIS ... ";&test("-ieuc -onewjis",$sample{'euc'},$sample{'jis'});
print "SJIS to JIS ... ";&test("-isjis -onewjis",$sample{'sjis'},$sample{'jis'});
print "JIS  to JIS ... ";&test("-inewjis -onewjis",$sample{'jis'},$sample{'jis'});
print "EUC  to EUC ... ";&test("-ieuc -oeuc",$sample{'euc'},$sample{'euc'});
print "SJIS to EUC ... ";&test("-isjis -oeuc"   ,$sample{'sjis'},$sample{'euc'});
print "JIS  to EUC ... ";&test("-inewjis -oeuc"   ,$sample{'jis'},$sample{'euc'});

$wakachi{'euc'} = unpack('u',<<'eofeof');
MI+.DSJ2_I-.DSR"AUB!K86MA<VEF;W)7:6XS,B"AUR"D\B"EP*6FI?.E[:&\
MI<D@I+>DQB#$NJ2M(*2BI.JDK*3(I*:DM*2VI*2DWJ2Y(*&C"J2SI.RDSR!K
M86MA<VEV,BXR+C4K(*3OI*NDP2"]\:2M(*3R(&-Y9W=I;BQM:6YG=S,R(*3'
M(*6SI?.ET:6DI>L@I,>DK:3K"J3HI*:DRZ2WI+\@<&%T8V@@I/(@I;.E\Z71
MI:2EZR"TQ+:M(*3.(,RUI*0@ROT@I,NDXB"[R*3#I,8@Q+JDL2"DZZ3HI*8@
M5VEN9&]W<R"DS@J\PKG4M\&\L""DRZ2WI,:DWJ3(I.&DOR#*JB"DQZ2Y(*&C
M"KK'O[?(QR"DSR"PRK*\I,X@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M
M82YO<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*I,<@N/BSJR"DMZ3&I*2DWJ2Y
M(*&CH<H@OK`@H:(@I+.DSB"EVJ&\I;@@I,\@R:S-UR"DRR"Q_J2X(*3&(+FY
1O[<@I+6D[*3>I+D@H:.ARPH`
eofeof
$wakachi{'sjis'} = unpack('u',<<'eofeof');
M@K&"S(*]@M&"S2"!=2!K86MA<VEF;W)7:6XS,B"!=B""\""#7X-%@Y.#C8%;
M@V@@@K6"Q""2N(*K((*@@NB"JH+&@J2"LH*T@J*"W(*W((%""H*Q@NJ"S2!K
M86MA<VEV,BXR+C4K((+M@JF"OR"/D8*K((+P(&-Y9W=I;BQM:6YG=S,R((+%
M((-2@Y.#<(-#@XL@@L6"JX+I"H+F@J2"R8*U@KT@<&%T8V@@@O`@@U*#DX-P
M@T.#BR"*PHNK((+,():S@J(@E?L@@LF"X"".9X+!@L0@DKB"KR""Z8+F@J0@
M5VEN9&]W<R""S`J.P(USC&".KB""R8*U@L2"W(+&@M^"O2"5J"""Q8*W((%"
M"HW%D%:4Q2""S2"(R(FZ@LP@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M
M82YO<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*@L4@C/:*2B""M8+$@J*"W(*W
M((%"@6D@CZX@@4$@@K&"S""#>8%;@U<@@LT@E4N7=B""R2")GH*V((+$((U8
1D%8@@K."ZH+<@K<@@4*!:@H`
eofeof
$wakachi{'jis'} = unpack('u',<<'eofeof');
M&R1")#,D3B0_)%,D3QLH0B`;)$(A5ALH0B!K86MA<VEF;W)7:6XS,B`;)$(A
M5QLH0B`;)$(D<ALH0B`;)$(E0"4F)7,E;2$\)4D;*$(@&R1")#<D1ALH0B`;
M)$)$.B0M&RA"(!LD0B0B)&HD+"1()"8D-"0V)"0D7B0Y&RA"(!LD0B$C&RA"
M"ALD0B0S)&PD3QLH0B!K86MA<VEV,BXR+C4K(!LD0B1O)"LD01LH0B`;)$(]
M<20M&RA"(!LD0B1R&RA"(&-Y9W=I;BQM:6YG=S,R(!LD0B1'&RA"(!LD0B4S
M)7,E424D)6L;*$(@&R1")$<D+21K&RA""ALD0B1H)"8D2R0W)#\;*$(@<&%T
M8V@@&R1")'(;*$(@&R1")3,E<R51)20E:QLH0B`;)$(T1#8M&RA"(!LD0B1.
M&RA"(!LD0DPU)"0;*$(@&R1"2GT;*$(@&R1")$LD8ALH0B`;)$([2"1#)$8;
M*$(@&R1"1#HD,1LH0B`;)$(D:R1H)"8;*$(@5VEN9&]W<R`;)$(D3ALH0@H;
M)$(\0CE4-T$\,!LH0B`;)$(D2R0W)$8D7B1()&$D/QLH0B`;)$)**ALH0B`;
M)$(D1R0Y&RA"(!LD0B$C&RA""ALD0CI'/S=(1QLH0B`;)$(D3QLH0B`;)$(P
M2C(\)$X;*$(@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M82YO<BYJ<"\E
M-T5K96YZ;RTO3F%M87IU+SX*&R1")$<;*$(@&R1".'@S*QLH0B`;)$(D-R1&
M)"0D7B0Y&RA"(!LD0B$C(4H;*$(@&R1"/C`;*$(@&R1"(2(;*$(@&R1")#,D
M3ALH0B`;)$(E6B$\)3@;*$(@&R1")$\;*$(@&R1"22Q-5QLH0B`;)$(D2QLH
M0B`;)$(Q?B0X&RA"(!LD0B1&&RA"(!LD0CDY/S<;*$(@&R1")#4D;"1>)#D;
.*$(@&R1"(2,A2QLH0@H`
eofeof

print "\nWakachigaki Conversion test\n";
print "EUC  to SJIS... ";&test("-w -ieuc -osjis",$sample{'euc'},$wakachi{'sjis'});
print "SJIS to SJIS... ";&test("-w -isjis -osjis"  ,$sample{'sjis'},$wakachi{'sjis'});
print "JIS  to SJIS... ";&test("-w -inewjis -osjis"  ,$sample{'jis'},$wakachi{'sjis'});
print "EUC  to JIS ... ";&test("-w -ieuc -onewjis",$sample{'euc'},$wakachi{'jis'});
print "SJIS to JIS ... ";&test("-w -isjis -onewjis",$sample{'sjis'},$wakachi{'jis'});
print "JIS  to JIS ... ";&test("-w -inewjis -onewjis",$sample{'jis'},$wakachi{'jis'});
print "EUC  to EUC ... ";&test("-w -ieuc -oeuc",$sample{'euc'},$wakachi{'euc'});
print "SJIS to EUC ... ";&test("-w -isjis -oeuc"   ,$sample{'sjis'},$wakachi{'euc'});
print "JIS  to EUC ... ";&test("-w -inewjis -oeuc"   ,$sample{'jis'},$wakachi{'euc'});

$yomikata{'euc'} = unpack('u',<<'eofeof');
MI+.DSJ2_I-.DSR"AUB!K86MA<VEF;W)7:6XS,B"AUR"D\B"EP*6FI?.E[:&\
MI<D@I+>DQB#$NJ2M6Z2DI+^DP*2M72"DHJ3JI*RDR*2FI+2DMJ2DI-ZDN2"A
MHPJDLZ3LI,\@:V%K87-I=C(N,BXU*R"D[Z2KI,$@O?&DK5NDJZ2M72"D\B!C
M>6=W:6XL;6EN9W<S,B"DQR"ELZ7SI=&EI*7K(*3'I*VDZPJDZ*2FI,NDMZ2_
M('!A=&-H(*3R(*6SI?.ET:6DI>L@M,2VK5NDJZ3SI*VDYZ2F72"DSB#,M:2D
M6Z3*I*1=(,K]6WNDVZ2F?*2KI+]\I*RDOWRDW:2F?5T@I,NDXB"[R*3#I,9;
MI,2DJZ3#I,9=(,2ZI+%;I*2DOZ3`I+%=(*3KI.BDIB!7:6YD;W=S(*3."KS"
MN=2WP;RP6Z2XI,.DLZ2FI+&DI*2WI*U=(*3+I+>DQJ3>I,BDX:2_(,JJ6WND
MXJ3.?*36I,1\I.*DQ'U=(*3'I+D@H:,*NL>_M\C'6Z2UI*2DMZ3SI-"D\UT@
MI,\@L,JRO*3.6Z2DI*NDSET@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M
M82YO<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*I,<@N/BSJUNDLZ2FI*NDI%T@
MI+>DQJ2DI-ZDN2"AHZ'*(+ZP6WNDOZ2KI+=\I+>DYZ2F?*3*I*I\I-*DM7RD
MTJ2UI+=\I+^DJWRDRJ3;?5T@H:(@I+.DSB"EVJ&\I;@@I,\@R:S-UUNDTJ3$
MI.BDIET@I,L@L?ZDN%M[I*JDIJ2X?*2JI*JDN'U=(*3&(+FYO[=;I+.DIJ2W
2I/-=(*2UI.RDWJ2Y(*&CH<L*
eofeof
$yomikata{'sjis'} = unpack('u',<<'eofeof');
M@K&"S(*]@M&"S2"!=2!K86MA<VEF;W)7:6XS,B"!=B""\""#7X-%@Y.#C8%;
M@V@@@K6"Q""2N(*K6X*B@KV"OH*K72""H(+H@JJ"QH*D@K*"M(*B@MR"MR"!
M0@J"L8+J@LT@:V%K87-I=C(N,BXU*R""[8*I@K\@CY&"JUN"J8*K72""\"!C
M>6=W:6XL;6EN9W<S,B""Q2"#4H.3@W"#0X.+((+%@JN"Z0J"YH*D@LF"M8*]
M('!A=&-H((+P((-2@Y.#<(-#@XL@BL*+JUN"J8+Q@JN"Y8*D72""S""6LX*B
M6X+(@J)=()7[6WN"V8*D?(*I@KU\@JJ"O7R"VX*D?5T@@LF"X"".9X+!@L1;
M@L*"J8+!@L1=()*X@J];@J*"O8*^@J]=((+I@N:"I"!7:6YD;W=S((+,"H[`
MC7.,8(ZN6X*V@L&"L8*D@J^"HH*U@JM=((+)@K6"Q(+<@L:"WX*]()6H6WN"
MX(+,?(+4@L)\@N""PGU=((+%@K<@@4(*C<605I3%6X*S@J*"M8+Q@LZ"\5T@
M@LT@B,B)NH+,6X*B@JF"S%T@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M
M82YO<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*@L4@C/:*2EN"L8*D@JF"HET@
M@K6"Q(*B@MR"MR"!0H%I((^N6WN"O8*I@K5\@K6"Y8*D?(+(@JA\@M""LWR"
MT(*S@K5\@KV"J7R"R(+9?5T@@4$@@K&"S""#>8%;@U<@@LT@E4N7=EN"T(+"
M@N:"I%T@@LD@B9Z"MEM[@JB"I(*V?(*H@JB"MGU=((+$((U8D%9;@K&"I(*U
2@O%=((*S@NJ"W(*W((%"@6H*
eofeof
$yomikata{'jis'} = unpack('u',<<'eofeof');
M&R1")#,D3B0_)%,D3QLH0B`;)$(A5ALH0B!K86MA<VEF;W)7:6XS,B`;)$(A
M5QLH0B`;)$(D<ALH0B`;)$(E0"4F)7,E;2$\)4D;*$(@&R1")#<D1ALH0B`;
M)$)$.B0M&RA"6QLD0B0D)#\D0"0M&RA"72`;)$(D(B1J)"PD2"0F)#0D-B0D
M)%XD.1LH0B`;)$(A(QLH0@H;)$(D,R1L)$\;*$(@:V%K87-I=C(N,BXU*R`;
M)$(D;R0K)$$;*$(@&R1"/7$D+1LH0EL;)$(D*R0M&RA"72`;)$(D<ALH0B!C
M>6=W:6XL;6EN9W<S,B`;)$(D1QLH0B`;)$(E,R5S)5$E)"5K&RA"(!LD0B1'
M)"TD:QLH0@H;)$(D:"0F)$LD-R0_&RA"('!A=&-H(!LD0B1R&RA"(!LD0B4S
M)7,E424D)6L;*$(@&R1"-$0V+1LH0EL;)$(D*R1S)"TD9R0F&RA"72`;)$(D
M3ALH0B`;)$),-20D&RA"6QLD0B1*)"0;*$)=(!LD0DI]&RA"6WL;)$(D6R0F
M&RA"?!LD0B0K)#\;*$)\&R1")"PD/QLH0GP;)$(D720F&RA"?5T@&R1")$LD
M8ALH0B`;)$([2"1#)$8;*$);&R1")$0D*R1#)$8;*$)=(!LD0D0Z)#$;*$);
M&R1")"0D/R1`)#$;*$)=(!LD0B1K)&@D)ALH0B!7:6YD;W=S(!LD0B1.&RA"
M"ALD0CQ".50W03PP&RA"6QLD0B0X)$,D,R0F)#$D)"0W)"T;*$)=(!LD0B1+
M)#<D1B1>)$@D820_&RA"(!LD0DHJ&RA"6WL;)$(D8B1.&RA"?!LD0B16)$0;
M*$)\&R1")&(D1!LH0GU=(!LD0B1')#D;*$(@&R1"(2,;*$(*&R1".D<_-TA'
M&RA"6QLD0B0U)"0D-R1S)%`D<QLH0ET@&R1")$\;*$(@&R1",$HR/"1.&RA"
M6QLD0B0D)"LD3ALH0ET@5V5B4&%G90H\55),.FAT='`Z+R]W=W<N=&%M82YO
M<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*&R1")$<;*$(@&R1".'@S*QLH0EL;
M)$(D,R0F)"LD)!LH0ET@&R1")#<D1B0D)%XD.1LH0B`;)$(A(R%*&RA"(!LD
M0CXP&RA"6WL;)$(D/R0K)#<;*$)\&R1")#<D9R0F&RA"?!LD0B1*)"H;*$)\
M&R1")%(D-1LH0GP;)$(D4B0U)#<;*$)\&R1")#\D*QLH0GP;)$(D2B1;&RA"
M?5T@&R1"(2(;*$(@&R1")#,D3ALH0B`;)$(E6B$\)3@;*$(@&R1")$\;*$(@
M&R1"22Q-5QLH0EL;)$(D4B1$)&@D)ALH0ET@&R1")$L;*$(@&R1",7XD.!LH
M0EM[&R1")"HD)B0X&RA"?!LD0B0J)"HD.!LH0GU=(!LD0B1&&RA"(!LD0CDY
M/S<;*$);&R1")#,D)B0W)',;*$)=(!LD0B0U)&PD7B0Y&RA"(!LD0B$C(4L;
#*$(*
eofeof

print "\nYomikata Conversion test\n";
print "EUC  to SJIS... ";&test("-JH -p -f -s -ieuc -osjis",$sample{'euc'},$yomikata{'sjis'});
print "SJIS to SJIS... ";&test("-JH -p -f -s -isjis -osjis"  ,$sample{'sjis'},$yomikata{'sjis'});
print "JIS  to SJIS... ";&test("-JH -p -f -s -inewjis -osjis"  ,$sample{'jis'},$yomikata{'sjis'});
print "EUC  to JIS ... ";&test("-JH -p -f -s -ieuc -onewjis",$sample{'euc'},$yomikata{'jis'});
print "SJIS to JIS ... ";&test("-JH -p -f -s -isjis -onewjis",$sample{'sjis'},$yomikata{'jis'});
print "JIS  to JIS ... ";&test("-JH -p -f -s -inewjis -onewjis",$sample{'jis'},$yomikata{'jis'});
print "EUC  to EUC ... ";&test("-JH -p -f -s -ieuc -oeuc",$sample{'euc'},$yomikata{'euc'});
print "SJIS to EUC ... ";&test("-JH -p -f -s -isjis -oeuc"   ,$sample{'sjis'},$yomikata{'euc'});
print "JIS  to EUC ... ";&test("-JH -p -f -s -inewjis -oeuc"   ,$sample{'jis'},$yomikata{'euc'});

$allascii = unpack('u',<<'eofeof');
M:V]N;W1A8FEH82AK86MA<VEF;W)7:6XS,BEW;V1A=6YR;UYD;W-H:71E:71A
M9&%K:6%R:6=A=&]U9V]Z86EM87-U+@IK;W)E:&%K86MA<VEV,BXR+C4K=V%K
M86-H:6MA:VEW;V-Y9W=I;BQM:6YG=S,R9&5K;VYP86ER=61E:VER=0IY;W5N
M:7-H:71A<&%T8VAW;VMO;G!A:7)U:V%N:WEO=6YO;F%I:&]U;FEM;W1S=6MA
M='1E:71A9&%K97)U>6]U5VEN9&]W<VYO"FII:VMO=6ME:7-H:6MI;FES:&ET
M96UA=&]M971A;6]N;V1E<W4N"G-A:7-H:6YB86YH86EK86YO5V5B4&%G90H\
M55),.FAT='`Z+R]W=W<N=&%M82YO<BYJ<"\E-T5K96YZ;RTO3F%M87IU+SX*
M9&5K;W5K86ES:&ET96EM87-U+BAT86MA<VAI+&MO;F]P95YJ:6AA:&ET<W5Y
<;W5N:6]U:FET96MO=7-H:6YS87)E;6%S=2XI"@``
eofeof

print "\nAll ASCII Conversion test\n";
print "EUC  to ASCII... ";&test("-Ha -Ja -Ea -Ka -ieuc -osjis",$sample{'euc'},$allascii);
print "SJIS to ASCII... ";&test("-Ha -Ja -Ea -Ka -isjis -osjis"  ,$sample{'sjis'},$allascii);
print "JIS  to ASCII... ";&test("-Ha -Ja -Ea -Ka -inewjis -osjis"  ,$sample{'jis'},$allascii);


exit;

# test for -f is not so simple.
# end

##### Master Test Data ##########################################
# begin 644 test.euc
# MI+.DSJ2_I-.DSZ'6:V%K87-I9F]R5VEN,S*AUZ3RI<"EIJ7SI>VAO*7)I+>D
# MQL2ZI*VDHJ3JI*RDR*2FI+2DMJ2DI-ZDN:&C"J2SI.RDSVMA:V%S:78R+C(N
# M-2ND[Z2KI,&]\:2MI/)C>6=W:6XL;6EN9W<S,J3'I;.E\Z71I:2EZZ3'I*VD
# MZPJDZ*2FI,NDMZ2_<&%T8VBD\J6SI?.ET:6DI>NTQ+:MI,[,M:2DROVDRZ3B
# MN\BDPZ3&Q+JDL:3KI.BDIE=I;F1O=W.DS@J\PKG4M\&\L*3+I+>DQJ3>I,BD
# MX:2_RJJDQZ2YH:,*NL>_M\C'I,^PRK*\I,Y796)086=E"CQ54DPZ:'1T<#HO
# M+W=W=RYT86UA+F]R+FIP+R4W16ME;GIO+2].86UA>G4O/@JDQ[CXLZNDMZ3&
# MI*2DWJ2YH:.ARKZPH:*DLZ3.I=JAO*6XI,_)K,W7I,NQ_J2XI,:YN;^WI+6D
# *[*3>I+FAHZ'+"@``
# `
# end
#############################################################
