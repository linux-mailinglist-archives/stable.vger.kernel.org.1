Return-Path: <stable+bounces-146221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27832AC2B24
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 22:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6743A6D33
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439571FE47D;
	Fri, 23 May 2025 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEU11FD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF361FBEA6;
	Fri, 23 May 2025 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033653; cv=none; b=AYb0WEWBBJQ8le0MxZeeDMPUgPaOFXGuPRloccz9m1ehO1uMXEZqDPrICelSQ2ezRl5ztG7ulTLeSdav2QE8MgVcH5hCG/L7xgjbQhLdAIBhkEJObmPJVQ/elSTrq7zt8r5Dk7fw3wlnEoj25F8977qGxHvha9ijDVLPSL27RIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033653; c=relaxed/simple;
	bh=kBeKz5QBuJTCJReqJpqDcB25vJmmHdfsdPvVNnCnS4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l7k46tX7+rucQOi14eeYZwdcXDMk454YhjInNr7kfiZYiqsU3vpnILut/wQTwItAFkQZUNtrRUdkYzFSVI/zj0KzIlM4pJNR8R5TfsgAPxtKX3oFsYw358WDoqa3noDeoWMzH4fHbyIWpLQLEvHAK3Z+Fuk5Q5W+u6oc5Y+GYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEU11FD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4C9C4CEE9;
	Fri, 23 May 2025 20:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748033652;
	bh=kBeKz5QBuJTCJReqJpqDcB25vJmmHdfsdPvVNnCnS4U=;
	h=Date:From:To:Cc:Subject:From;
	b=jEU11FD9zAjO2kY09r8dvErZHeoos6ozVUOFBQDqA6MPem1iXcaZETGoRt+ofSTHV
	 l80acqkrCiBCzMpkgodxfiTxGNI47EHgWtUjaXYy4Va2Eaopyh2CYnOsubOOfaIIH1
	 AoKUgeKlxUMSteWHUyYfOM1FE1wT10ydD+Nk61NldOx9I8FDkY+7m6OYtpH8awi4M8
	 /hTJFUJXdNKJhIEX8ahNbs0uk9LQ56JZ5UC4Mm5TLhXuKL6z/1ZwafvJQ7QGDVr3DG
	 qtlspfQtsXkBe/+9owf4q+QM1NpGeVKrC5VHtQspuD9FHIqmJLQ9YHeITWREFrccC5
	 8Q1Wl3u02StoA==
Date: Fri, 23 May 2025 13:54:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Series for -Wunterminated-string-initialization in 6.14 and 6.12
Message-ID: <20250523205408.GA863786@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oFsRdxISTMfy/87n"
Content-Disposition: inline


--oFsRdxISTMfy/87n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please find attatched backports for 6.14 and 6.12 (which have -Wextra
enabled by default) to turn off a new warning from -Wextra in GCC 15 and
Clang 21, -Wunterminated-string-initialization, which is fatal when
CONFIG_WERROR is enabled. Please let me know if there are any issues or
questions.

Cheers,
Nathan

--oFsRdxISTMfy/87n
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=6.12-Wunterminated-string-initialization.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 796e12921f3e4c298de97d5ad9775e052faa5eb6 Mon Sep 17 00:00:00 2001=0A=
=46rom: Linus Torvalds <torvalds@linux-foundation.org>=0ADate: Sun, 20 Apr =
2025 10:33:23 -0700=0ASubject: [PATCH 6.12 1/4] gcc-15: make 'unterminated =
string initialization'=0A just a warning=0AMIME-Version: 1.0=0AContent-Type=
: text/plain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit=
 d5d45a7f26194460964eb5677a9226697f7b7fdd upstream.=0A=0Agcc-15 enabling -W=
unterminated-string-initialization in -Wextra by=0Adefault was done with th=
e best intentions, but the warning is still=0Aquite broken.=0A=0AWhat annoy=
s me about the warning is that this is a very traditional AND=0ACORRECT way=
 to initialize fixed byte arrays in C:=0A=0A	unsigned char hex[16] =3D "012=
3456789abcdef";=0A=0Aand we use this all over the kernel.  And the warning =
is fine, but gcc=0Adevelopers apparently never made a reasonable way to dis=
able it.  As is=0A(sadly) tradition with these things.=0A=0AYes, there's "_=
_attribute__((nonstring))", and we have a macro to make=0Athat absolutely d=
isgusting syntax more palatable (ie the kernel syntax=0Afor that monstrosit=
y is just "__nonstring").=0A=0ABut that attribute is misdesigned.  What you=
'd typically want to do is=0Atell the compiler that you are using a type th=
at isn't a string but a=0Abyte array, but that doesn't work at all:=0A=0A	w=
arning: =E2=80=98nonstring=E2=80=99 attribute does not apply to types [-Wat=
tributes]=0A=0Aand because of this fundamental mis-design, you then have to=
 mark each=0Ainstance of that pattern.=0A=0AThis is particularly noticeable=
 in our ACPI code, because ACPI has this=0Anotion of a 4-byte "type name" t=
hat gets used all over, and is exactly=0Athis kind of byte array.=0A=0AThis=
 is a sad oversight, because the warning is useful, but really would=0Abe s=
o much better if gcc had also given a sane way to indicate that we=0Areally=
 just want a byte array type at a type level, not the broken "each=0Aand ev=
ery array definition" level.=0A=0ASo now instead of creating a nice "ACPI n=
ame" type using something like=0A=0A	typedef char acpi_name_t[4] __nonstrin=
g;=0A=0Awe have to do things like=0A=0A	char name[ACPI_NAMESEG_SIZE] __nons=
tring;=0A=0Ain every place that uses this concept and then happens to have =
the=0Atypical initializers.=0A=0AThis is annoying me mainly because I think=
 the warning _is_ a good=0Awarning, which is why I'm not just turning it of=
f in disgust.  But it is=0Ahampered by this bad implementation detail.=0A=
=0A[ And obviously I'm doing this now because system upgrades for me are=0A=
  something that happen in the middle of the release cycle: don't do it=0A =
 before or during travel, or just before or during the busy merge=0A  windo=
w period. ]=0A=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.o=
rg>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Makefil=
e | 3 +++=0A 1 file changed, 3 insertions(+)=0A=0Adiff --git a/Makefile b/M=
akefile=0Aindex 6e8afa78bbef..74dc1572a200 100644=0A--- a/Makefile=0A+++ b/=
Makefile=0A@@ -1001,6 +1001,9 @@ KBUILD_CFLAGS +=3D $(call cc-option, -fstr=
ict-flex-arrays=3D3)=0A KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=
=3D $(call cc-option, -Wno-stringop-overflow)=0A KBUILD_CFLAGS-$(CONFIG_CC_=
STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=0A =0A+#Curr=
ently, disable -Wunterminated-string-initialization as an error=0A+KBUILD_C=
FLAGS +=3D $(call cc-option, -Wno-error=3Dunterminated-string-initializatio=
n)=0A+=0A # disable invalid "can't wrap" optimizations for signed / pointer=
s=0A KBUILD_CFLAGS	+=3D -fno-strict-overflow=0A =0A=0Abase-commit: e0e2f782=
43385e7188a57fcfceb6a19f723f1dff=0A-- =0A2.49.0=0A=0A=0AFrom 50c02d93990e94=
bc6bacc1ce71e7895b40316b5a Mon Sep 17 00:00:00 2001=0AFrom: Linus Torvalds =
<torvalds@linux-foundation.org>=0ADate: Sun, 20 Apr 2025 15:30:53 -0700=0AS=
ubject: [PATCH 6.12 2/4] gcc-15: disable=0A '-Wunterminated-string-initiali=
zation' entirely for now a commit=0A 9d7a0577c9db35c4cc52db90bc415ea2484464=
72 upstream.=0A=0AI had left the warning around but as a non-fatal error to=
 get my gcc-15=0Abuilds going, but fixed up some of the most annoying warni=
ng cases so=0Athat it wouldn't be *too* verbose.=0A=0ABecause I like the _c=
oncept_ of the warning, even if I detested the=0Aimplementation to shut it =
up.=0A=0AIt turns out the implementation to shut it up is even more broken =
than I=0Athought, and my "shut up most of the warnings" patch just caused f=
atal=0Aerrors on gcc-14 instead.=0A=0AI had tested with clang, but when I u=
pgrade my development environment,=0AI try to do it on all machines because=
 I hate having different systems=0Ato maintain, and hadn't realized that gc=
c-14 now had issues.=0A=0AThe ACPI case is literally why I wanted to have a=
 *type* that doesn't=0Atrigger the warning (see commit d5d45a7f2619: "gcc-1=
5: make=0A'unterminated string initialization' just a warning"), instead of=
=0Amarking individual places as "__nonstring".=0A=0ABut gcc-14 doesn't like=
 that __nonstring location that shut gcc-15 up,=0Abecause it's on an array =
of char arrays, not on one single array:=0A=0A  drivers/acpi/tables.c:399:1=
: error: 'nonstring' attribute ignored on objects of type 'const char[][4]'=
 [-Werror=3Dattributes]=0A    399 | static const char table_sigs[][ACPI_NAM=
ESEG_SIZE] __initconst __nonstring =3D {=0A        | ^~~~~~=0A=0Aand my att=
empts to nest it properly with a type had failed, because of=0Ahow gcc does=
n't like marking the types as having attributes, only=0Asymbols.=0A=0AThere=
 may be some trick to it, but I was already annoyed by the bad=0Aattribute =
design, now I'm just entirely fed up with it.=0A=0AI wish gcc had a proper =
way to say "this type is a *byte* array, not a=0Astring".=0A=0AThe obvious =
thing would be to distinguish between "char []" and an=0Aexplicitly signed =
"unsigned char []" (as opposed to an implicitly=0Aunsigned char, which is t=
ypically an architecture-specific default, but=0Afor the kernel is universa=
l thanks to '-funsigned-char').=0A=0ABut any "we can typedef a 8-bit type t=
o not become a string just because=0Ait's an array" model would be fine.=0A=
=0ABut "__attribute__((nonstring))" is sadly not that sane model.=0A=0ARepo=
rted-by: Chris Clayton <chris2553@googlemail.com>=0AFixes: 4b4bd8c50f48 ("g=
cc-15: acpi: sprinkle random '__nonstring' crumbles around")=0AFixes: d5d45=
a7f2619 ("gcc-15: make 'unterminated string initialization' just a warning"=
)=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.org>=0A[nathan=
: drivers/acpi diff dropped due to lack of 4b4bd8c50f48 in stable]=0ASigned=
-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Makefile | 4 ++--=
=0A 1 file changed, 2 insertions(+), 2 deletions(-)=0A=0Adiff --git a/Makef=
ile b/Makefile=0Aindex 74dc1572a200..6579a7cae11d 100644=0A--- a/Makefile=
=0A+++ b/Makefile=0A@@ -1001,8 +1001,8 @@ KBUILD_CFLAGS +=3D $(call cc-opti=
on, -fstrict-flex-arrays=3D3)=0A KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVER=
FLOW) +=3D $(call cc-option, -Wno-stringop-overflow)=0A KBUILD_CFLAGS-$(CON=
FIG_CC_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=0A =
=0A-#Currently, disable -Wunterminated-string-initialization as an error=0A=
-KBUILD_CFLAGS +=3D $(call cc-option, -Wno-error=3Dunterminated-string-init=
ialization)=0A+#Currently, disable -Wunterminated-string-initialization as =
broken=0A+KBUILD_CFLAGS +=3D $(call cc-option, -Wno-unterminated-string-ini=
tialization)=0A =0A # disable invalid "can't wrap" optimizations for signed=
 / pointers=0A KBUILD_CFLAGS	+=3D -fno-strict-overflow=0A-- =0A2.49.0=0A=0A=
=0AFrom ed91ac5bb04aa893ac0e53ea6dc274633527d039 Mon Sep 17 00:00:00 2001=
=0AFrom: Linus Torvalds <torvalds@linux-foundation.org>=0ADate: Wed, 23 Apr=
 2025 10:08:29 -0700=0ASubject: [PATCH 6.12 3/4] Fix mis-uses of 'cc-option=
' for warning disablement=0AMIME-Version: 1.0=0AContent-Type: text/plain; c=
harset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit a79be02bba5c31=
f967885c7f3bf3a756d77d11d9 upstream.=0A=0AThis was triggered by one of my m=
is-uses causing odd build warnings on=0Asparc in linux-next, but while figu=
ring out why the "obviously correct"=0Ause of cc-option caused such odd bre=
akage, I found eight other cases of=0Athe same thing in the tree.=0A=0AThe =
root cause is that 'cc-option' doesn't work for checking negative=0Awarning=
 options (ie things like '-Wno-stringop-overflow') because gcc=0Awill silen=
tly accept options it doesn't recognize, and so 'cc-option'=0Aends up think=
ing they are perfectly fine.=0A=0AAnd it all works, until you have a situat=
ion where _another_ warning is=0Aemitted.  At that point the compiler will =
go "Hmm, maybe the user=0Aintended to disable this warning but used that wr=
ong option that I=0Adidn't recognize", and generate a warning for the unrec=
ognized negative=0Aoption.=0A=0AWhich explains why we have several cases of=
 this in the tree: the=0A'cc-option' test really doesn't work for this situ=
ation, but most of the=0Atime it simply doesn't matter that ity doesn't wor=
k.=0A=0AThe reason my recently added case caused problems on sparc was poin=
ted=0Aout by Thomas Wei=C3=9Fschuh: the sparc build had a previous explicit=
 warning=0Athat then triggered the new one.=0A=0AI think the best fix for t=
his would be to make 'cc-option' a bit smarter=0Aabout this sitation, possi=
bly by adding an intentional warning to the=0Atest case that then triggers =
the unrecognized option warning reliably.=0A=0ABut the short-term fix is to=
 replace 'cc-option' with an existing helper=0Adesigned for this exact case=
: 'cc-disable-warning', which picks the=0Anegative warning but uses the pos=
itive form for testing the compiler=0Asupport.=0A=0AReported-by: Stephen Ro=
thwell <sfr@canb.auug.org.au>=0ALink: https://lore.kernel.org/all/202504222=
04718.0b4e3f81@canb.auug.org.au/=0AExplained-by: Thomas Wei=C3=9Fschuh <lin=
ux@weissschuh.net>=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundati=
on.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Mak=
efile                       | 4 ++--=0A arch/loongarch/kernel/Makefile | 8 =
++++----=0A arch/loongarch/kvm/Makefile    | 2 +-=0A arch/riscv/kernel/Make=
file     | 4 ++--=0A scripts/Makefile.extrawarn     | 2 +-=0A 5 files chang=
ed, 10 insertions(+), 10 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=
=0Aindex 6579a7cae11d..7f4436415bf4 100644=0A--- a/Makefile=0A+++ b/Makefil=
e=0A@@ -998,11 +998,11 @@ NOSTDINC_FLAGS +=3D -nostdinc=0A KBUILD_CFLAGS +=
=3D $(call cc-option, -fstrict-flex-arrays=3D3)=0A =0A #Currently, disable =
-Wstringop-overflow for GCC 11, globally.=0A-KBUILD_CFLAGS-$(CONFIG_CC_NO_S=
TRINGOP_OVERFLOW) +=3D $(call cc-option, -Wno-stringop-overflow)=0A+KBUILD_=
CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=3D $(call cc-disable-warning, st=
ringop-overflow)=0A KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(cal=
l cc-option, -Wstringop-overflow)=0A =0A #Currently, disable -Wunterminated=
-string-initialization as broken=0A-KBUILD_CFLAGS +=3D $(call cc-option, -W=
no-unterminated-string-initialization)=0A+KBUILD_CFLAGS +=3D $(call cc-disa=
ble-warning, unterminated-string-initialization)=0A =0A # disable invalid "=
can't wrap" optimizations for signed / pointers=0A KBUILD_CFLAGS	+=3D -fno-=
strict-overflow=0Adiff --git a/arch/loongarch/kernel/Makefile b/arch/loonga=
rch/kernel/Makefile=0Aindex c9bfeda89e40..66132683f1ed 100644=0A--- a/arch/=
loongarch/kernel/Makefile=0A+++ b/arch/loongarch/kernel/Makefile=0A@@ -21,1=
0 +21,10 @@ obj-$(CONFIG_CPU_HAS_LBT)	+=3D lbt.o=0A =0A obj-$(CONFIG_ARCH_S=
TRICT_ALIGN)	+=3D unaligned.o=0A =0A-CFLAGS_module.o		+=3D $(call cc-option=
,-Wno-override-init,)=0A-CFLAGS_syscall.o	+=3D $(call cc-option,-Wno-overri=
de-init,)=0A-CFLAGS_traps.o		+=3D $(call cc-option,-Wno-override-init,)=0A-=
CFLAGS_perf_event.o	+=3D $(call cc-option,-Wno-override-init,)=0A+CFLAGS_mo=
dule.o		+=3D $(call cc-disable-warning, override-init)=0A+CFLAGS_syscall.o	=
+=3D $(call cc-disable-warning, override-init)=0A+CFLAGS_traps.o		+=3D $(ca=
ll cc-disable-warning, override-init)=0A+CFLAGS_perf_event.o	+=3D $(call cc=
-disable-warning, override-init)=0A =0A ifdef CONFIG_FUNCTION_TRACER=0A   i=
fndef CONFIG_DYNAMIC_FTRACE=0Adiff --git a/arch/loongarch/kvm/Makefile b/ar=
ch/loongarch/kvm/Makefile=0Aindex b2f4cbe01ae8..2e188e8f1468 100644=0A--- a=
/arch/loongarch/kvm/Makefile=0A+++ b/arch/loongarch/kvm/Makefile=0A@@ -19,4=
 +19,4 @@ kvm-y +=3D tlb.o=0A kvm-y +=3D vcpu.o=0A kvm-y +=3D vm.o=0A =0A-C=
FLAGS_exit.o	+=3D $(call cc-option,-Wno-override-init,)=0A+CFLAGS_exit.o	+=
=3D $(call cc-disable-warning, override-init)=0Adiff --git a/arch/riscv/ker=
nel/Makefile b/arch/riscv/kernel/Makefile=0Aindex 69dc8aaab3fb..6b3b5255c88=
9 100644=0A--- a/arch/riscv/kernel/Makefile=0A+++ b/arch/riscv/kernel/Makef=
ile=0A@@ -9,8 +9,8 @@ CFLAGS_REMOVE_patch.o	=3D $(CC_FLAGS_FTRACE)=0A CFLAG=
S_REMOVE_sbi.o	=3D $(CC_FLAGS_FTRACE)=0A CFLAGS_REMOVE_return_address.o	=3D=
 $(CC_FLAGS_FTRACE)=0A endif=0A-CFLAGS_syscall_table.o	+=3D $(call cc-optio=
n,-Wno-override-init,)=0A-CFLAGS_compat_syscall_table.o +=3D $(call cc-opti=
on,-Wno-override-init,)=0A+CFLAGS_syscall_table.o	+=3D $(call cc-disable-wa=
rning, override-init)=0A+CFLAGS_compat_syscall_table.o +=3D $(call cc-disab=
le-warning, override-init)=0A =0A ifdef CONFIG_KEXEC_CORE=0A AFLAGS_kexec_r=
elocate.o :=3D -mcmodel=3Dmedany $(call cc-option,-mno-relax)=0Adiff --git =
a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn=0Aindex 686197407=
c3c..32dcf9eb4fa8 100644=0A--- a/scripts/Makefile.extrawarn=0A+++ b/scripts=
/Makefile.extrawarn=0A@@ -15,7 +15,7 @@ KBUILD_CFLAGS +=3D -Werror=3Dreturn=
-type=0A KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes=0A KBUILD_CFLAGS +=
=3D -Wno-format-security=0A KBUILD_CFLAGS +=3D -Wno-trigraphs=0A-KBUILD_CFL=
AGS +=3D $(call cc-disable-warning,frame-address,)=0A+KBUILD_CFLAGS +=3D $(=
call cc-disable-warning, frame-address)=0A KBUILD_CFLAGS +=3D $(call cc-dis=
able-warning, address-of-packed-member)=0A KBUILD_CFLAGS +=3D -Wmissing-dec=
larations=0A KBUILD_CFLAGS +=3D -Wmissing-prototypes=0A-- =0A2.49.0=0A=0A=
=0AFrom 8ca4ef650ff1b1fd0f52985d81a0f4bd806bedf9 Mon Sep 17 00:00:00 2001=
=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Wed, 30 Apr 2025 15:=
56:34 -0700=0ASubject: [PATCH 6.12 4/4] kbuild: Properly disable=0A -Wunter=
minated-string-initialization for clang=0AMIME-Version: 1.0=0AContent-Type:=
 text/plain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit =
4f79eaa2ceac86a0e0f304b0bab556cca5bf4f30 upstream.=0A=0AClang and GCC have =
different behaviors around disabling warnings=0Aincluded in -Wall and -Wext=
ra and the order in which flags are=0Aspecified, which is exposed by clang'=
s new support for=0A-Wunterminated-string-initialization.=0A=0A  $ cat test=
=2Ec=0A  const char foo[3] =3D "FOO";=0A  const char bar[3] __attribute__((=
__nonstring__)) =3D "BAR";=0A=0A  $ clang -fsyntax-only -Wextra test.c=0A  =
test.c:1:21: warning: initializer-string for character array is too long, a=
rray size is 3 but initializer has size 4 (including the null terminating c=
haracter); did you mean to use the 'nonstring' attribute? [-Wunterminated-s=
tring-initialization]=0A      1 | const char foo[3] =3D "FOO";=0A        | =
                    ^~~~~=0A  $ clang -fsyntax-only -Wextra -Wno-unterminat=
ed-string-initialization test.c=0A  $ clang -fsyntax-only -Wno-unterminated=
-string-initialization -Wextra test.c=0A  test.c:1:21: warning: initializer=
-string for character array is too long, array size is 3 but initializer ha=
s size 4 (including the null terminating character); did you mean to use th=
e 'nonstring' attribute? [-Wunterminated-string-initialization]=0A      1 |=
 const char foo[3] =3D "FOO";=0A        |                     ^~~~~=0A=0A  =
$ gcc -fsyntax-only -Wextra test.c=0A  test.c:1:21: warning: initializer-st=
ring for array of =E2=80=98char=E2=80=99 truncates NUL terminator but desti=
nation lacks =E2=80=98nonstring=E2=80=99 attribute (4 chars into 3 availabl=
e) [-Wunterminated-string-initialization]=0A      1 | const char foo[3] =3D=
 "FOO";=0A        |                     ^~~~~=0A  $ gcc -fsyntax-only -Wext=
ra -Wno-unterminated-string-initialization test.c=0A  $ gcc -fsyntax-only -=
Wno-unterminated-string-initialization -Wextra test.c=0A=0AMove -Wextra up =
right below -Wall in Makefile.extrawarn to ensure these=0Aflags are at the =
beginning of the warning options list. Move the couple=0Aof warning options=
 that have been added to the main Makefile since=0Acommit e88ca24319e4 ("kb=
uild: consolidate warning flags in=0Ascripts/Makefile.extrawarn") to script=
s/Makefile.extrawarn after -Wall /=0A-Wextra to ensure they get properly di=
sabled for all compilers.=0A=0AFixes: 9d7a0577c9db ("gcc-15: disable '-Wunt=
erminated-string-initialization' entirely for now")=0ALink: https://github.=
com/llvm/llvm-project/issues/10359=0ASigned-off-by: Nathan Chancellor <nath=
an@kernel.org>=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.o=
rg>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Makefil=
e                   | 7 -------=0A scripts/Makefile.extrawarn | 9 ++++++++-=
=0A 2 files changed, 8 insertions(+), 8 deletions(-)=0A=0Adiff --git a/Make=
file b/Makefile=0Aindex 7f4436415bf4..551d7556e88a 100644=0A--- a/Makefile=
=0A+++ b/Makefile=0A@@ -997,13 +997,6 @@ NOSTDINC_FLAGS +=3D -nostdinc=0A #=
 perform bounds checking.=0A KBUILD_CFLAGS +=3D $(call cc-option, -fstrict-=
flex-arrays=3D3)=0A =0A-#Currently, disable -Wstringop-overflow for GCC 11,=
 globally.=0A-KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=3D $(call c=
c-disable-warning, stringop-overflow)=0A-KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP=
_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=0A-=0A-#Currently, d=
isable -Wunterminated-string-initialization as broken=0A-KBUILD_CFLAGS +=3D=
 $(call cc-disable-warning, unterminated-string-initialization)=0A-=0A # di=
sable invalid "can't wrap" optimizations for signed / pointers=0A KBUILD_CF=
LAGS	+=3D -fno-strict-overflow=0A =0Adiff --git a/scripts/Makefile.extrawar=
n b/scripts/Makefile.extrawarn=0Aindex 32dcf9eb4fa8..5652d9035232 100644=0A=
--- a/scripts/Makefile.extrawarn=0A+++ b/scripts/Makefile.extrawarn=0A@@ -8=
,6 +8,7 @@=0A =0A # Default set of warnings, always enabled=0A KBUILD_CFLAG=
S +=3D -Wall=0A+KBUILD_CFLAGS +=3D -Wextra=0A KBUILD_CFLAGS +=3D -Wundef=0A=
 KBUILD_CFLAGS +=3D -Werror=3Dimplicit-function-declaration=0A KBUILD_CFLAG=
S +=3D -Werror=3Dimplicit-int=0A@@ -68,6 +69,13 @@ KBUILD_CFLAGS +=3D -Wno-=
pointer-sign=0A # globally built with -Wcast-function-type.=0A KBUILD_CFLAG=
S +=3D $(call cc-option, -Wcast-function-type)=0A =0A+# Currently, disable =
-Wstringop-overflow for GCC 11, globally.=0A+KBUILD_CFLAGS-$(CONFIG_CC_NO_S=
TRINGOP_OVERFLOW) +=3D $(call cc-disable-warning, stringop-overflow)=0A+KBU=
ILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop=
-overflow)=0A+=0A+# Currently, disable -Wunterminated-string-initialization=
 as broken=0A+KBUILD_CFLAGS +=3D $(call cc-disable-warning, unterminated-st=
ring-initialization)=0A+=0A # The allocators already balk at large sizes, s=
o silence the compiler=0A # warnings for bounds checks involving those poss=
ible values. While=0A # -Wno-alloc-size-larger-than would normally be used =
here, earlier versions=0A@@ -97,7 +105,6 @@ KBUILD_CFLAGS +=3D $(call cc-op=
tion,-Wenum-conversion)=0A # Explicitly clear padding bits during variable =
initialization=0A KBUILD_CFLAGS +=3D $(call cc-option,-fzero-init-padding-b=
its=3Dall)=0A =0A-KBUILD_CFLAGS +=3D -Wextra=0A KBUILD_CFLAGS +=3D -Wunused=
=0A =0A #=0A-- =0A2.49.0=0A=0A
--oFsRdxISTMfy/87n
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=6.14-Wunterminated-string-initialization.mbox
Content-Transfer-Encoding: quoted-printable

=46rom bcf6b670c9be863958c50eb3d3ec04ad2e5cee69 Mon Sep 17 00:00:00 2001=0A=
=46rom: Linus Torvalds <torvalds@linux-foundation.org>=0ADate: Sun, 20 Apr =
2025 10:33:23 -0700=0ASubject: [PATCH 6.14 1/4] gcc-15: make 'unterminated =
string initialization'=0A just a warning=0AMIME-Version: 1.0=0AContent-Type=
: text/plain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit=
 d5d45a7f26194460964eb5677a9226697f7b7fdd upstream.=0A=0Agcc-15 enabling -W=
unterminated-string-initialization in -Wextra by=0Adefault was done with th=
e best intentions, but the warning is still=0Aquite broken.=0A=0AWhat annoy=
s me about the warning is that this is a very traditional AND=0ACORRECT way=
 to initialize fixed byte arrays in C:=0A=0A	unsigned char hex[16] =3D "012=
3456789abcdef";=0A=0Aand we use this all over the kernel.  And the warning =
is fine, but gcc=0Adevelopers apparently never made a reasonable way to dis=
able it.  As is=0A(sadly) tradition with these things.=0A=0AYes, there's "_=
_attribute__((nonstring))", and we have a macro to make=0Athat absolutely d=
isgusting syntax more palatable (ie the kernel syntax=0Afor that monstrosit=
y is just "__nonstring").=0A=0ABut that attribute is misdesigned.  What you=
'd typically want to do is=0Atell the compiler that you are using a type th=
at isn't a string but a=0Abyte array, but that doesn't work at all:=0A=0A	w=
arning: =E2=80=98nonstring=E2=80=99 attribute does not apply to types [-Wat=
tributes]=0A=0Aand because of this fundamental mis-design, you then have to=
 mark each=0Ainstance of that pattern.=0A=0AThis is particularly noticeable=
 in our ACPI code, because ACPI has this=0Anotion of a 4-byte "type name" t=
hat gets used all over, and is exactly=0Athis kind of byte array.=0A=0AThis=
 is a sad oversight, because the warning is useful, but really would=0Abe s=
o much better if gcc had also given a sane way to indicate that we=0Areally=
 just want a byte array type at a type level, not the broken "each=0Aand ev=
ery array definition" level.=0A=0ASo now instead of creating a nice "ACPI n=
ame" type using something like=0A=0A	typedef char acpi_name_t[4] __nonstrin=
g;=0A=0Awe have to do things like=0A=0A	char name[ACPI_NAMESEG_SIZE] __nons=
tring;=0A=0Ain every place that uses this concept and then happens to have =
the=0Atypical initializers.=0A=0AThis is annoying me mainly because I think=
 the warning _is_ a good=0Awarning, which is why I'm not just turning it of=
f in disgust.  But it is=0Ahampered by this bad implementation detail.=0A=
=0A[ And obviously I'm doing this now because system upgrades for me are=0A=
  something that happen in the middle of the release cycle: don't do it=0A =
 before or during travel, or just before or during the busy merge=0A  windo=
w period. ]=0A=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.o=
rg>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Makefil=
e | 3 +++=0A 1 file changed, 3 insertions(+)=0A=0Adiff --git a/Makefile b/M=
akefile=0Aindex 70011eb4745f..d57e6d5d82b8 100644=0A--- a/Makefile=0A+++ b/=
Makefile=0A@@ -1053,6 +1053,9 @@ KBUILD_CFLAGS +=3D $(call cc-option, -fstr=
ict-flex-arrays=3D3)=0A KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=
=3D $(call cc-option, -Wno-stringop-overflow)=0A KBUILD_CFLAGS-$(CONFIG_CC_=
STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=0A =0A+#Curr=
ently, disable -Wunterminated-string-initialization as an error=0A+KBUILD_C=
FLAGS +=3D $(call cc-option, -Wno-error=3Dunterminated-string-initializatio=
n)=0A+=0A # disable invalid "can't wrap" optimizations for signed / pointer=
s=0A KBUILD_CFLAGS	+=3D -fno-strict-overflow=0A =0A=0Abase-commit: 78155acc=
fe563a8f72dac383bd1d754b690e92de=0A-- =0A2.49.0=0A=0A=0AFrom fef53e1026db79=
228bbe4694347311d03db5a560 Mon Sep 17 00:00:00 2001=0AFrom: Linus Torvalds =
<torvalds@linux-foundation.org>=0ADate: Sun, 20 Apr 2025 15:30:53 -0700=0AS=
ubject: [PATCH 6.14 2/4] gcc-15: disable=0A '-Wunterminated-string-initiali=
zation' entirely for now=0A=0Acommit 9d7a0577c9db35c4cc52db90bc415ea2484464=
72 upstream.=0A=0AI had left the warning around but as a non-fatal error to=
 get my gcc-15=0Abuilds going, but fixed up some of the most annoying warni=
ng cases so=0Athat it wouldn't be *too* verbose.=0A=0ABecause I like the _c=
oncept_ of the warning, even if I detested the=0Aimplementation to shut it =
up.=0A=0AIt turns out the implementation to shut it up is even more broken =
than I=0Athought, and my "shut up most of the warnings" patch just caused f=
atal=0Aerrors on gcc-14 instead.=0A=0AI had tested with clang, but when I u=
pgrade my development environment,=0AI try to do it on all machines because=
 I hate having different systems=0Ato maintain, and hadn't realized that gc=
c-14 now had issues.=0A=0AThe ACPI case is literally why I wanted to have a=
 *type* that doesn't=0Atrigger the warning (see commit d5d45a7f2619: "gcc-1=
5: make=0A'unterminated string initialization' just a warning"), instead of=
=0Amarking individual places as "__nonstring".=0A=0ABut gcc-14 doesn't like=
 that __nonstring location that shut gcc-15 up,=0Abecause it's on an array =
of char arrays, not on one single array:=0A=0A  drivers/acpi/tables.c:399:1=
: error: 'nonstring' attribute ignored on objects of type 'const char[][4]'=
 [-Werror=3Dattributes]=0A    399 | static const char table_sigs[][ACPI_NAM=
ESEG_SIZE] __initconst __nonstring =3D {=0A        | ^~~~~~=0A=0Aand my att=
empts to nest it properly with a type had failed, because of=0Ahow gcc does=
n't like marking the types as having attributes, only=0Asymbols.=0A=0AThere=
 may be some trick to it, but I was already annoyed by the bad=0Aattribute =
design, now I'm just entirely fed up with it.=0A=0AI wish gcc had a proper =
way to say "this type is a *byte* array, not a=0Astring".=0A=0AThe obvious =
thing would be to distinguish between "char []" and an=0Aexplicitly signed =
"unsigned char []" (as opposed to an implicitly=0Aunsigned char, which is t=
ypically an architecture-specific default, but=0Afor the kernel is universa=
l thanks to '-funsigned-char').=0A=0ABut any "we can typedef a 8-bit type t=
o not become a string just because=0Ait's an array" model would be fine.=0A=
=0ABut "__attribute__((nonstring))" is sadly not that sane model.=0A=0ARepo=
rted-by: Chris Clayton <chris2553@googlemail.com>=0AFixes: 4b4bd8c50f48 ("g=
cc-15: acpi: sprinkle random '__nonstring' crumbles around")=0AFixes: d5d45=
a7f2619 ("gcc-15: make 'unterminated string initialization' just a warning"=
)=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundation.org>=0A[nathan=
: drivers/acpi diff dropped due to lack of 4b4bd8c50f48 in stable]=0ASigned=
-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Makefile | 4 ++--=
=0A 1 file changed, 2 insertions(+), 2 deletions(-)=0A=0Adiff --git a/Makef=
ile b/Makefile=0Aindex d57e6d5d82b8..0d60f9fa7035 100644=0A--- a/Makefile=
=0A+++ b/Makefile=0A@@ -1053,8 +1053,8 @@ KBUILD_CFLAGS +=3D $(call cc-opti=
on, -fstrict-flex-arrays=3D3)=0A KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVER=
FLOW) +=3D $(call cc-option, -Wno-stringop-overflow)=0A KBUILD_CFLAGS-$(CON=
FIG_CC_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=0A =
=0A-#Currently, disable -Wunterminated-string-initialization as an error=0A=
-KBUILD_CFLAGS +=3D $(call cc-option, -Wno-error=3Dunterminated-string-init=
ialization)=0A+#Currently, disable -Wunterminated-string-initialization as =
broken=0A+KBUILD_CFLAGS +=3D $(call cc-option, -Wno-unterminated-string-ini=
tialization)=0A =0A # disable invalid "can't wrap" optimizations for signed=
 / pointers=0A KBUILD_CFLAGS	+=3D -fno-strict-overflow=0A-- =0A2.49.0=0A=0A=
=0AFrom 8c59e5cea22980e5ca7e7f9c0feb0db8fcbeb5a3 Mon Sep 17 00:00:00 2001=
=0AFrom: Linus Torvalds <torvalds@linux-foundation.org>=0ADate: Wed, 23 Apr=
 2025 10:08:29 -0700=0ASubject: [PATCH 6.14 3/4] Fix mis-uses of 'cc-option=
' for warning disablement=0AMIME-Version: 1.0=0AContent-Type: text/plain; c=
harset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit a79be02bba5c31=
f967885c7f3bf3a756d77d11d9 upstream.=0A=0AThis was triggered by one of my m=
is-uses causing odd build warnings on=0Asparc in linux-next, but while figu=
ring out why the "obviously correct"=0Ause of cc-option caused such odd bre=
akage, I found eight other cases of=0Athe same thing in the tree.=0A=0AThe =
root cause is that 'cc-option' doesn't work for checking negative=0Awarning=
 options (ie things like '-Wno-stringop-overflow') because gcc=0Awill silen=
tly accept options it doesn't recognize, and so 'cc-option'=0Aends up think=
ing they are perfectly fine.=0A=0AAnd it all works, until you have a situat=
ion where _another_ warning is=0Aemitted.  At that point the compiler will =
go "Hmm, maybe the user=0Aintended to disable this warning but used that wr=
ong option that I=0Adidn't recognize", and generate a warning for the unrec=
ognized negative=0Aoption.=0A=0AWhich explains why we have several cases of=
 this in the tree: the=0A'cc-option' test really doesn't work for this situ=
ation, but most of the=0Atime it simply doesn't matter that ity doesn't wor=
k.=0A=0AThe reason my recently added case caused problems on sparc was poin=
ted=0Aout by Thomas Wei=C3=9Fschuh: the sparc build had a previous explicit=
 warning=0Athat then triggered the new one.=0A=0AI think the best fix for t=
his would be to make 'cc-option' a bit smarter=0Aabout this sitation, possi=
bly by adding an intentional warning to the=0Atest case that then triggers =
the unrecognized option warning reliably.=0A=0ABut the short-term fix is to=
 replace 'cc-option' with an existing helper=0Adesigned for this exact case=
: 'cc-disable-warning', which picks the=0Anegative warning but uses the pos=
itive form for testing the compiler=0Asupport.=0A=0AReported-by: Stephen Ro=
thwell <sfr@canb.auug.org.au>=0ALink: https://lore.kernel.org/all/202504222=
04718.0b4e3f81@canb.auug.org.au/=0AExplained-by: Thomas Wei=C3=9Fschuh <lin=
ux@weissschuh.net>=0ASigned-off-by: Linus Torvalds <torvalds@linux-foundati=
on.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A Mak=
efile                       | 4 ++--=0A arch/loongarch/kernel/Makefile | 8 =
++++----=0A arch/loongarch/kvm/Makefile    | 2 +-=0A arch/riscv/kernel/Make=
file     | 4 ++--=0A scripts/Makefile.extrawarn     | 2 +-=0A 5 files chang=
ed, 10 insertions(+), 10 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=
=0Aindex 0d60f9fa7035..7039c880b6b0 100644=0A--- a/Makefile=0A+++ b/Makefil=
e=0A@@ -1050,11 +1050,11 @@ NOSTDINC_FLAGS +=3D -nostdinc=0A KBUILD_CFLAGS =
+=3D $(call cc-option, -fstrict-flex-arrays=3D3)=0A =0A #Currently, disable=
 -Wstringop-overflow for GCC 11, globally.=0A-KBUILD_CFLAGS-$(CONFIG_CC_NO_=
STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wno-stringop-overflow)=0A+KBUILD=
_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=3D $(call cc-disable-warning, s=
tringop-overflow)=0A KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(ca=
ll cc-option, -Wstringop-overflow)=0A =0A #Currently, disable -Wunterminate=
d-string-initialization as broken=0A-KBUILD_CFLAGS +=3D $(call cc-option, -=
Wno-unterminated-string-initialization)=0A+KBUILD_CFLAGS +=3D $(call cc-dis=
able-warning, unterminated-string-initialization)=0A =0A # disable invalid =
"can't wrap" optimizations for signed / pointers=0A KBUILD_CFLAGS	+=3D -fno=
-strict-overflow=0Adiff --git a/arch/loongarch/kernel/Makefile b/arch/loong=
arch/kernel/Makefile=0Aindex 4853e8b04c6f..f9dcaa60033d 100644=0A--- a/arch=
/loongarch/kernel/Makefile=0A+++ b/arch/loongarch/kernel/Makefile=0A@@ -21,=
10 +21,10 @@ obj-$(CONFIG_CPU_HAS_LBT)	+=3D lbt.o=0A =0A obj-$(CONFIG_ARCH_=
STRICT_ALIGN)	+=3D unaligned.o=0A =0A-CFLAGS_module.o		+=3D $(call cc-optio=
n,-Wno-override-init,)=0A-CFLAGS_syscall.o	+=3D $(call cc-option,-Wno-overr=
ide-init,)=0A-CFLAGS_traps.o		+=3D $(call cc-option,-Wno-override-init,)=0A=
-CFLAGS_perf_event.o	+=3D $(call cc-option,-Wno-override-init,)=0A+CFLAGS_m=
odule.o		+=3D $(call cc-disable-warning, override-init)=0A+CFLAGS_syscall.o=
	+=3D $(call cc-disable-warning, override-init)=0A+CFLAGS_traps.o		+=3D $(c=
all cc-disable-warning, override-init)=0A+CFLAGS_perf_event.o	+=3D $(call c=
c-disable-warning, override-init)=0A =0A ifdef CONFIG_FUNCTION_TRACER=0A   =
ifndef CONFIG_DYNAMIC_FTRACE=0Adiff --git a/arch/loongarch/kvm/Makefile b/a=
rch/loongarch/kvm/Makefile=0Aindex 3a01292f71cc..8e8f6bc87f89 100644=0A--- =
a/arch/loongarch/kvm/Makefile=0A+++ b/arch/loongarch/kvm/Makefile=0A@@ -23,=
4 +23,4 @@ kvm-y +=3D intc/eiointc.o=0A kvm-y +=3D intc/pch_pic.o=0A kvm-y =
+=3D irqfd.o=0A =0A-CFLAGS_exit.o	+=3D $(call cc-option,-Wno-override-init,=
)=0A+CFLAGS_exit.o	+=3D $(call cc-disable-warning, override-init)=0Adiff --=
git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile=0Aindex 8d186=
bfced45..f7480c9c6f8d 100644=0A--- a/arch/riscv/kernel/Makefile=0A+++ b/arc=
h/riscv/kernel/Makefile=0A@@ -9,8 +9,8 @@ CFLAGS_REMOVE_patch.o	=3D $(CC_FL=
AGS_FTRACE)=0A CFLAGS_REMOVE_sbi.o	=3D $(CC_FLAGS_FTRACE)=0A CFLAGS_REMOVE_=
return_address.o	=3D $(CC_FLAGS_FTRACE)=0A endif=0A-CFLAGS_syscall_table.o	=
+=3D $(call cc-option,-Wno-override-init,)=0A-CFLAGS_compat_syscall_table.o=
 +=3D $(call cc-option,-Wno-override-init,)=0A+CFLAGS_syscall_table.o	+=3D =
$(call cc-disable-warning, override-init)=0A+CFLAGS_compat_syscall_table.o =
+=3D $(call cc-disable-warning, override-init)=0A =0A ifdef CONFIG_KEXEC_CO=
RE=0A AFLAGS_kexec_relocate.o :=3D -mcmodel=3Dmedany $(call cc-option,-mno-=
relax)=0Adiff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawa=
rn=0Aindex 686197407c3c..32dcf9eb4fa8 100644=0A--- a/scripts/Makefile.extra=
warn=0A+++ b/scripts/Makefile.extrawarn=0A@@ -15,7 +15,7 @@ KBUILD_CFLAGS +=
=3D -Werror=3Dreturn-type=0A KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes=
=0A KBUILD_CFLAGS +=3D -Wno-format-security=0A KBUILD_CFLAGS +=3D -Wno-trig=
raphs=0A-KBUILD_CFLAGS +=3D $(call cc-disable-warning,frame-address,)=0A+KB=
UILD_CFLAGS +=3D $(call cc-disable-warning, frame-address)=0A KBUILD_CFLAGS=
 +=3D $(call cc-disable-warning, address-of-packed-member)=0A KBUILD_CFLAGS=
 +=3D -Wmissing-declarations=0A KBUILD_CFLAGS +=3D -Wmissing-prototypes=0A-=
- =0A2.49.0=0A=0A=0AFrom c98f8b0bd8c1042da51efbad6a9f1cf2e4884f3f Mon Sep 1=
7 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Wed, =
30 Apr 2025 15:56:34 -0700=0ASubject: [PATCH 6.14 4/4] kbuild: Properly dis=
able=0A -Wunterminated-string-initialization for clang=0AMIME-Version: 1.0=
=0AContent-Type: text/plain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8=
bit=0A=0Acommit 4f79eaa2ceac86a0e0f304b0bab556cca5bf4f30 upstream.=0A=0ACla=
ng and GCC have different behaviors around disabling warnings=0Aincluded in=
 -Wall and -Wextra and the order in which flags are=0Aspecified, which is e=
xposed by clang's new support for=0A-Wunterminated-string-initialization.=
=0A=0A  $ cat test.c=0A  const char foo[3] =3D "FOO";=0A  const char bar[3]=
 __attribute__((__nonstring__)) =3D "BAR";=0A=0A  $ clang -fsyntax-only -We=
xtra test.c=0A  test.c:1:21: warning: initializer-string for character arra=
y is too long, array size is 3 but initializer has size 4 (including the nu=
ll terminating character); did you mean to use the 'nonstring' attribute? [=
-Wunterminated-string-initialization]=0A      1 | const char foo[3] =3D "FO=
O";=0A        |                     ^~~~~=0A  $ clang -fsyntax-only -Wextra=
 -Wno-unterminated-string-initialization test.c=0A  $ clang -fsyntax-only -=
Wno-unterminated-string-initialization -Wextra test.c=0A  test.c:1:21: warn=
ing: initializer-string for character array is too long, array size is 3 bu=
t initializer has size 4 (including the null terminating character); did yo=
u mean to use the 'nonstring' attribute? [-Wunterminated-string-initializat=
ion]=0A      1 | const char foo[3] =3D "FOO";=0A        |                  =
   ^~~~~=0A=0A  $ gcc -fsyntax-only -Wextra test.c=0A  test.c:1:21: warning=
: initializer-string for array of =E2=80=98char=E2=80=99 truncates NUL term=
inator but destination lacks =E2=80=98nonstring=E2=80=99 attribute (4 chars=
 into 3 available) [-Wunterminated-string-initialization]=0A      1 | const=
 char foo[3] =3D "FOO";=0A        |                     ^~~~~=0A  $ gcc -fs=
yntax-only -Wextra -Wno-unterminated-string-initialization test.c=0A  $ gcc=
 -fsyntax-only -Wno-unterminated-string-initialization -Wextra test.c=0A=0A=
Move -Wextra up right below -Wall in Makefile.extrawarn to ensure these=0Af=
lags are at the beginning of the warning options list. Move the couple=0Aof=
 warning options that have been added to the main Makefile since=0Acommit e=
88ca24319e4 ("kbuild: consolidate warning flags in=0Ascripts/Makefile.extra=
warn") to scripts/Makefile.extrawarn after -Wall /=0A-Wextra to ensure they=
 get properly disabled for all compilers.=0A=0AFixes: 9d7a0577c9db ("gcc-15=
: disable '-Wunterminated-string-initialization' entirely for now")=0ALink:=
 https://github.com/llvm/llvm-project/issues/10359=0ASigned-off-by: Nathan =
Chancellor <nathan@kernel.org>=0ASigned-off-by: Linus Torvalds <torvalds@li=
nux-foundation.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=
=0A---=0A Makefile                   | 7 -------=0A scripts/Makefile.extraw=
arn | 9 ++++++++-=0A 2 files changed, 8 insertions(+), 8 deletions(-)=0A=0A=
diff --git a/Makefile b/Makefile=0Aindex 7039c880b6b0..ead54c2dd4d4 100644=
=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -1049,13 +1049,6 @@ NOSTDINC_FLAGS =
+=3D -nostdinc=0A # perform bounds checking.=0A KBUILD_CFLAGS +=3D $(call c=
c-option, -fstrict-flex-arrays=3D3)=0A =0A-#Currently, disable -Wstringop-o=
verflow for GCC 11, globally.=0A-KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVER=
FLOW) +=3D $(call cc-disable-warning, stringop-overflow)=0A-KBUILD_CFLAGS-$=
(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstringop-overflow)=
=0A-=0A-#Currently, disable -Wunterminated-string-initialization as broken=
=0A-KBUILD_CFLAGS +=3D $(call cc-disable-warning, unterminated-string-initi=
alization)=0A-=0A # disable invalid "can't wrap" optimizations for signed /=
 pointers=0A KBUILD_CFLAGS	+=3D -fno-strict-overflow=0A =0Adiff --git a/scr=
ipts/Makefile.extrawarn b/scripts/Makefile.extrawarn=0Aindex 32dcf9eb4fa8..=
5652d9035232 100644=0A--- a/scripts/Makefile.extrawarn=0A+++ b/scripts/Make=
file.extrawarn=0A@@ -8,6 +8,7 @@=0A =0A # Default set of warnings, always e=
nabled=0A KBUILD_CFLAGS +=3D -Wall=0A+KBUILD_CFLAGS +=3D -Wextra=0A KBUILD_=
CFLAGS +=3D -Wundef=0A KBUILD_CFLAGS +=3D -Werror=3Dimplicit-function-decla=
ration=0A KBUILD_CFLAGS +=3D -Werror=3Dimplicit-int=0A@@ -68,6 +69,13 @@ KB=
UILD_CFLAGS +=3D -Wno-pointer-sign=0A # globally built with -Wcast-function=
-type.=0A KBUILD_CFLAGS +=3D $(call cc-option, -Wcast-function-type)=0A =0A=
+# Currently, disable -Wstringop-overflow for GCC 11, globally.=0A+KBUILD_C=
FLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=3D $(call cc-disable-warning, str=
ingop-overflow)=0A+KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(call=
 cc-option, -Wstringop-overflow)=0A+=0A+# Currently, disable -Wunterminated=
-string-initialization as broken=0A+KBUILD_CFLAGS +=3D $(call cc-disable-wa=
rning, unterminated-string-initialization)=0A+=0A # The allocators already =
balk at large sizes, so silence the compiler=0A # warnings for bounds check=
s involving those possible values. While=0A # -Wno-alloc-size-larger-than w=
ould normally be used here, earlier versions=0A@@ -97,7 +105,6 @@ KBUILD_CF=
LAGS +=3D $(call cc-option,-Wenum-conversion)=0A # Explicitly clear padding=
 bits during variable initialization=0A KBUILD_CFLAGS +=3D $(call cc-option=
,-fzero-init-padding-bits=3Dall)=0A =0A-KBUILD_CFLAGS +=3D -Wextra=0A KBUIL=
D_CFLAGS +=3D -Wunused=0A =0A #=0A-- =0A2.49.0=0A=0A
--oFsRdxISTMfy/87n--

