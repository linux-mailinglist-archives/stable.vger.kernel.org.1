Return-Path: <stable+bounces-151479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34FAACE732
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 01:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6846C18960FD
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7193272E75;
	Wed,  4 Jun 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxI0PFki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0714C98;
	Wed,  4 Jun 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079907; cv=none; b=MAKUn3ShPfBWxxKUWaVffIVtLZIaad3ql4OnkicmtLEfJcc2MYboBm0UUFBvLHmTZduU3ezs7iho3eeDgg8aAhr2ef8hgMqijlOOaPjBTYFXWaBnJSRgDqrZFkOJwKvQV33Bs9wxrvw4Y2rUYISqxuo9s5b09gu0ZUDu/Rfjyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079907; c=relaxed/simple;
	bh=NCANkbhiP1Zu5ai68hntJEAsv9MFqmAAnCaxaf0+SlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8SCEVnnTl9QEqNf6vSiaXTk+QvSYK/CuOX7If1rmFA+obEjy0Q3BK0kcCutdSWGxsxYxruvXPN5WJqcj894GZbqhxlGmf3Zo66zo53wPXPlDjkSdbHw76DawUQX6QKpUjU8uPjZxF7HrPBrcYvAdVbP0G9yvPi9VhHXNXgYBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxI0PFki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93451C4CEE4;
	Wed,  4 Jun 2025 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749079906;
	bh=NCANkbhiP1Zu5ai68hntJEAsv9MFqmAAnCaxaf0+SlI=;
	h=Date:From:To:Cc:Subject:From;
	b=TxI0PFki5TeUoZEn0pzHm7AHDbWwTcY+ijqDG44ozM7A0IbuyAc5mPUPks5qa7ete
	 1577npDdaZLS8CyFowKbwXkKvtvRtFWZAwhqcnGQcMv+1QcOOMeJ6gTkifFrRnf+0F
	 +3a37owm2hqBXLEFs/X4n7USlW/+dwWtBsZra6o/95O+t/sT9xYkd1R5XGNjMwh5wJ
	 MnFwsZQYEePpvIZwpKgmI+16KtZJc06ddVq24ol9miVfF18EpH4XTIY6SoTd93Tf2n
	 rg5nyWEbJhjOM3aeM//qXEv5rY2p/1MEd7J9RUwN7+WOGJqZClxOZWDeBZhrlzSCc1
	 epdzfl8eqYYXQ==
Date: Wed, 4 Jun 2025 16:31:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Backports for 6.1 and older due to clang -Qunused-arguments change
Message-ID: <20250604233141.GA2374479@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KPhBTdCXAv1onrYE"
Content-Disposition: inline


--KPhBTdCXAv1onrYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please find attached backports for commit feb843a469fb ("kbuild: add
$(CLANG_FLAGS) to KBUILD_CPPFLAGS") and its dependent changes, commit
d5c8d6e0fa61 ("kbuild: Update assembler calls to use proper flags and
language target") and its dependent changes, and commit 7db038d9790e
("drm/amd/display: Do not add '-mhard-float' to dml_ccflags for clang")
for 6.1 and earlier. The second listed change is already in 6.1 so that
series is a little shorter.

These changes are needed there due to an upstream LLVM change [1] that
changes the behavior of -Qunused-arguments with unknown target options,
which is only used in 6.1 and older since I removed it in commit
8d9acfce3332 ("kbuild: Stop using '-Qunused-arguments' with clang") in
6.3.

Please let me know if there are any issues, I will try to pay attention
for any issues that crop up in the stable review period from these
changes but please ping me if you remember.

Cheers,
Nathan

[1]: https://github.com/llvm/llvm-project/commit/a4b2f4a72aa9b4655ecc723838830e0a7f29c9ca

--KPhBTdCXAv1onrYE
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=5.4-llvm-qunused-arguments-change.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 668a8b64118d2d263025e92ebab1233f2a9b9c1c Mon Sep 17 00:00:00 2001=0A=
=46rom: Nick Desaulniers <ndesaulniers@google.com>=0ADate: Wed, 11 Jan 2023=
 20:04:58 -0700=0ASubject: [PATCH 5.4 1/9] x86/boot/compressed: prefer cc-o=
ption for CFLAGS=0A additions=0A=0Acommit 994f5f7816ff963f49269cfc97f63cb2e=
4edb84f upstream.=0A=0Aas-option tests new options using KBUILD_CFLAGS, whi=
ch causes problems=0Awhen using as-option to update KBUILD_AFLAGS because m=
any compiler=0Aoptions are not valid assembler options.=0A=0AThis will be f=
ixed in a follow up patch. Before doing so, move the=0Aassembler test for -=
Wa,-mrelax-relocations=3Dno from using as-option to=0Acc-option.=0A=0ALink:=
 https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=3DjMszyH=3D+M_LC9Qr6yeAGRCBb=
E6xriLxtUQ@mail.gmail.com/=0ASuggested-by: Masahiro Yamada <masahiroy@kerne=
l.org>=0AReviewed-by: Nathan Chancellor <nathan@kernel.org>=0ATested-by: Na=
than Chancellor <nathan@kernel.org>=0ASigned-off-by: Nick Desaulniers <ndes=
aulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=
=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested-by=
: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yamada=
 <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.o=
rg>=0A---=0A arch/x86/boot/compressed/Makefile | 2 +-=0A 1 file changed, 1 =
insertion(+), 1 deletion(-)=0A=0Adiff --git a/arch/x86/boot/compressed/Make=
file b/arch/x86/boot/compressed/Makefile=0Aindex edfb1a718510..62ef24bb2313=
 100644=0A--- a/arch/x86/boot/compressed/Makefile=0A+++ b/arch/x86/boot/com=
pressed/Makefile=0A@@ -39,7 +39,7 @@ KBUILD_CFLAGS +=3D $(call cc-disable-w=
arning, address-of-packed-member)=0A KBUILD_CFLAGS +=3D $(call cc-disable-w=
arning, gnu)=0A KBUILD_CFLAGS +=3D -Wno-pointer-sign=0A # Disable relocatio=
n relaxation in case the link is not PIE.=0A-KBUILD_CFLAGS +=3D $(call as-o=
ption,-Wa$(comma)-mrelax-relocations=3Dno)=0A+KBUILD_CFLAGS +=3D $(call cc-=
option,-Wa$(comma)-mrelax-relocations=3Dno)=0A =0A KBUILD_AFLAGS  :=3D $(KB=
UILD_CFLAGS) -D__ASSEMBLY__=0A GCOV_PROFILE :=3D n=0A=0Abase-commit: 44613a=
259decccddd2bd4520f73cc4d5107546c6=0A-- =0A2.49.0=0A=0A=0AFrom bd32b4960e2b=
bcbb84df8fde0eb1a2efc84bf40b Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chance=
llor <nathan@kernel.org>=0ADate: Wed, 14 Jun 2023 11:04:36 -0700=0ASubject:=
 [PATCH 5.4 2/9] MIPS: Move '-Wa,-msoft-float' check from as-option to=0A c=
c-option=0A=0AThis patch is for linux-6.1.y and earlier, it has no direct m=
ainline=0Aequivalent.=0A=0AIn order to backport commit d5c8d6e0fa61 ("kbuil=
d: Update assembler=0Acalls to use proper flags and language target") to re=
solve a separate=0Aissue regarding PowerPC, the problem noticed and fixed b=
y=0Acommit 80a20d2f8288 ("MIPS: Always use -Wa,-msoft-float and eliminate=
=0AGAS_HAS_SET_HARDFLOAT") needs to be addressed. Unfortunately, 6.1 and=0A=
earlier do not contain commit e4412739472b ("Documentation: raise=0Aminimum=
 supported version of binutils to 2.25"), so it cannot be assumed=0Athat al=
l supported versions of GNU as have support for -msoft-float.=0A=0AIn order=
 to switch from KBUILD_CFLAGS to KBUILD_AFLAGS in as-option=0Awithout conse=
quence, move the '-Wa,-msoft-float' check to cc-option,=0Aincluding '$(cfla=
gs-y)' directly to avoid the issue mentioned in=0Acommit 80a20d2f8288 ("MIP=
S: Always use -Wa,-msoft-float and eliminate=0AGAS_HAS_SET_HARDFLOAT").=0A=
=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/mips/=
Makefile | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff =
--git a/arch/mips/Makefile b/arch/mips/Makefile=0Aindex e2a2e5df4fde..45422=
58027a7 100644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/Makefile=0A@@ -=
107,7 +107,7 @@ endif=0A # (specifically newer than 2.24.51.20140728) we th=
en also need to explicitly=0A # set ".set hardfloat" in all files which man=
ipulate floating point registers.=0A #=0A-ifneq ($(call as-option,-Wa$(comm=
a)-msoft-float,),)=0A+ifneq ($(call cc-option,$(cflags-y) -Wa$(comma)-msoft=
-float,),)=0A 	cflags-y		+=3D -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float=0A e=
ndif=0A =0A-- =0A2.49.0=0A=0A=0AFrom 53842cd1ecb80f2347244af2a4fdfd2956e010=
b6 Mon Sep 17 00:00:00 2001=0AFrom: Nick Desaulniers <ndesaulniers@google.c=
om>=0ADate: Wed, 11 Jan 2023 20:05:01 -0700=0ASubject: [PATCH 5.4 3/9] kbui=
ld: Update assembler calls to use proper flags=0A and language target=0A=0A=
commit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.=0A=0Aas-instr use=
s KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can=0Acause as-opti=
on to fail unexpectedly when CONFIG_WERROR is set, because=0Aclang will emi=
t -Werror,-Wunused-command-line-argument for various -m=0Aand -f flags in K=
BUILD_CFLAGS for assembler sources.=0A=0ACallers of as-option and as-instr =
should be adding flags to=0AKBUILD_AFLAGS / aflags-y, not KBUILD_CFLAGS / c=
flags-y. Use=0AKBUILD_AFLAGS in all macros to clear up the initial problem.=
=0A=0AUnfortunately, -Wunused-command-line-argument can still be triggered=
=0Awith clang by the presence of warning flags or macro definitions because=
=0A'-x assembler' is used, instead of '-x assembler-with-cpp', which will=
=0Aconsume these flags. Switch to '-x assembler-with-cpp' in places where=
=0A'-x assembler' is used, as the compiler is always used as the driver for=
=0Aout of line assembler sources in the kernel.=0A=0AFinally, add -Werror t=
o these macros so that they behave consistently=0Awhether or not CONFIG_WER=
ROR is set.=0A=0A[nathan: Reworded and expanded on problems in commit messa=
ge=0A         Use '-x assembler-with-cpp' in a couple more places]=0A=0ALin=
k: https://github.com/ClangBuiltLinux/linux/issues/1699=0ASuggested-by: Mas=
ahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nick Desaulniers <ndes=
aulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=
=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested-by=
: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yamada=
 <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.o=
rg>=0A---=0A scripts/Kbuild.include | 8 ++++----=0A 1 file changed, 4 inser=
tions(+), 4 deletions(-)=0A=0Adiff --git a/scripts/Kbuild.include b/scripts=
/Kbuild.include=0Aindex 5d247d8f1e04..e6bbe1fd7add 100644=0A--- a/scripts/K=
build.include=0A+++ b/scripts/Kbuild.include=0A@@ -99,16 +99,16 @@ try-run =
=3D $(shell set -e;		\=0A 	fi)=0A =0A # as-option=0A-# Usage: cflags-y +=3D=
 $(call as-option,-Wa$(comma)-isa=3Dfoo,)=0A+# Usage: aflags-y +=3D $(call =
as-option,-Wa$(comma)-isa=3Dfoo,)=0A =0A as-option =3D $(call try-run,\=0A-=
	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2)=
)=0A+	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/nul=
l -o "$$TMP",$(1),$(2))=0A =0A # as-instr=0A-# Usage: cflags-y +=3D $(call =
as-instr,instr,option1,option2)=0A+# Usage: aflags-y +=3D $(call as-instr,i=
nstr,option1,option2)=0A =0A as-instr =3D $(call try-run,\=0A-	printf "%b\n=
" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))=
=0A+	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-=
with-cpp -o "$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS=
 +=3D $(call __cc-option,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di5=
86)=0A-- =0A2.49.0=0A=0A=0AFrom 817da77779e9bca5e52da4c1a93dff706732ff91 Mo=
n Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate=
: Wed, 11 Jan 2023 20:05:09 -0700=0ASubject: [PATCH 5.4 4/9] drm/amd/displa=
y: Do not add '-mhard-float' to=0A dml_ccflags for clang=0A=0Acommit 7db038=
d9790eda558dd6c1dde4cdd58b64789c47 upstream.=0A=0AWhen clang's -Qunused-arg=
uments is dropped from KBUILD_CPPFLAGS, it=0Awarns:=0A=0A  clang-16: error:=
 argument unused during compilation: '-mhard-float' [-Werror,-Wunused-comma=
nd-line-argument]=0A=0ASimilar to commit 84edc2eff827 ("selftest/fpu: avoid=
 clang warning"),=0Ajust add this flag to GCC builds. Commit 0f0727d971f6 (=
"drm/amd/display:=0Areadd -msse2 to prevent Clang from emitting libcalls to=
 undefined SW FP=0Aroutines") added '-msse2' to prevent clang from emitting=
 software=0Afloating point routines.=0A=0ASigned-off-by: Nathan Chancellor =
<nathan@kernel.org>=0AAcked-by: Alex Deucher <alexander.deucher@amd.com>=0A=
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested-by: A=
nders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yamada <m=
asahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=
=0A---=0A drivers/gpu/drm/amd/display/dc/dml/Makefile | 3 ++-=0A 1 file cha=
nged, 2 insertions(+), 1 deletion(-)=0A=0Adiff --git a/drivers/gpu/drm/amd/=
display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile=0Aind=
ex 8df251626e22..26cb8f78f516 100644=0A--- a/drivers/gpu/drm/amd/display/dc=
/dml/Makefile=0A+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile=0A@@ -24,=
7 +24,8 @@=0A # It provides the general basic services required by other DA=
L=0A # subcomponents.=0A =0A-dml_ccflags :=3D -mhard-float -msse=0A+dml_ccf=
lags-$(CONFIG_CC_IS_GCC) :=3D -mhard-float=0A+dml_ccflags :=3D $(dml_ccflag=
s-y) -msse=0A =0A ifdef CONFIG_CC_IS_GCC=0A ifeq ($(call cc-ifversion, -lt,=
 0701, y), y)=0A-- =0A2.49.0=0A=0A=0AFrom ee72d68bba47e0a0f045ff33638601ef7=
ec14260 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.o=
rg>=0ADate: Thu, 1 Jun 2023 11:38:24 -0700=0ASubject: [PATCH 5.4 5/9] mips:=
 Include KBUILD_CPPFLAGS in CHECKFLAGS=0A invocation=0A=0Acommit 08f6554ff9=
0ef189e6b8f0303e57005bddfdd6a7 upstream.=0A=0AA future change will move CLA=
NG_FLAGS from KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS so that '--target' is =
available while preprocessing.=0AWhen that occurs, the following error appe=
ars when building ARCH=3Dmips=0Awith clang (tip of tree error shown):=0A=0A=
  clang: error: unsupported option '-mabi=3D' for target 'x86_64-pc-linux-g=
nu'=0A=0AAdd KBUILD_CPPFLAGS in the CHECKFLAGS invocation to keep everythin=
g=0Aworking after the move.=0A=0ASigned-off-by: Nathan Chancellor <nathan@k=
ernel.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned=
-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/mips/Makefile =
| 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/a=
rch/mips/Makefile b/arch/mips/Makefile=0Aindex 4542258027a7..cc6f8265f28c 1=
00644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/Makefile=0A@@ -319,7 +31=
9,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables=0A KBUILD_LDFLAGS=
		+=3D -m $(ld-emul)=0A =0A ifdef CONFIG_MIPS=0A-CHECKFLAGS +=3D $(shell $(=
CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \=0A+CHECKFLAGS +=3D $(shell $=
(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \=0A 	egre=
p -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \=0A 	sed -e "s/^\#define /-D'/" -e=
 "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&&/g')=0A endif=0A-- =0A2.49.0=0A=0A=
=0AFrom b7e68767a827168474d68a6f5ab998eac82f8c90 Mon Sep 17 00:00:00 2001=
=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 12:5=
0:39 -0700=0ASubject: [PATCH 5.4 6/9] kbuild: Add CLANG_FLAGS to as-instr=
=0A=0Acommit cff6e7f50bd315e5b39c4e46c704ac587ceb965f upstream.=0A=0AA futu=
re change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS=
 so that '--target' is available while preprocessing.=0AWhen that occurs, t=
he following errors appear multiple times when=0Abuilding ARCH=3Dpowerpc po=
wernv_defconfig:=0A=0A  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_6=
4.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out of range: -4611686018=
409717520 is not in [-2147483648, 2147483647]; references '__start___soft_m=
ask_table'=0A  ld.lld: error: vmlinux.a(arch/powerpc/kernel/head_64.o):(.te=
xt+0x12e8): relocation R_PPC64_ADDR16_HI out of range: -4611686018409717392=
 is not in [-2147483648, 2147483647]; references '__stop___soft_mask_table'=
=0A=0ADiffing the .o.cmd files reveals that -DHAVE_AS_ATHIGH=3D1 is not pre=
sent=0Aanymore, because as-instr only uses KBUILD_AFLAGS, which will no lon=
ger=0Acontain '--target'.=0A=0AMirror Kconfig's as-instr and add CLANG_FLAG=
S explicitly to the=0Ainvocation to ensure the target information is always=
 present.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0ASigne=
d-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Ch=
ancellor <nathan@kernel.org>=0A---=0A scripts/Kbuild.include | 2 +-=0A 1 fi=
le changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/scripts/Kbuild.=
include b/scripts/Kbuild.include=0Aindex e6bbe1fd7add..1aa02e7125e7 100644=
=0A--- a/scripts/Kbuild.include=0A+++ b/scripts/Kbuild.include=0A@@ -108,7 =
+108,7 @@ as-option =3D $(call try-run,\=0A # Usage: aflags-y +=3D $(call a=
s-instr,instr,option1,option2)=0A =0A as-instr =3D $(call try-run,\=0A-	pri=
ntf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp=
 -o "$$TMP" -,$(2),$(3))=0A+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_F=
LAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))=0A =
=0A # __cc-option=0A # Usage: MY_CFLAGS +=3D $(call __cc-option,$(CC),$(MY_=
CFLAGS),-march=3Dwinchip-c6,-march=3Di586)=0A-- =0A2.49.0=0A=0A=0AFrom a846=
e1c74e2c17443e84efefb632f0d759d5f6e1 Mon Sep 17 00:00:00 2001=0AFrom: Masah=
iro Yamada <masahiroy@kernel.org>=0ADate: Sun, 9 Apr 2023 23:53:57 +0900=0A=
Subject: [PATCH 5.4 7/9] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS=0A=
=0Acommit feb843a469fb0ab00d2d23cfb9bcc379791011bb upstream.=0A=0AWhen prep=
rocessing arch/*/kernel/vmlinux.lds.S, the target triple is=0Anot passed to=
 $(CPP) because we add it only to KBUILD_{C,A}FLAGS.=0A=0AAs a result, the =
linker script is preprocessed with predefined macros=0Afor the build host i=
nstead of the target.=0A=0AAssuming you use an x86 build machine, compare t=
he following:=0A=0A $ clang -dM -E -x c /dev/null=0A $ clang -dM -E -x c /d=
ev/null -target aarch64-linux-gnu=0A=0AThere is no actual problem presumabl=
y because our linker scripts do not=0Arely on such predefined macros, but i=
t is better to define correct ones.=0A=0AMove $(CLANG_FLAGS) to KBUILD_CPPF=
LAGS, so that all *.c, *.S, *.lds.S=0Awill be processed with the proper tar=
get triple.=0A=0A[Note]=0AAfter the patch submission, we got an actual prob=
lem that needs this=0Acommit. (CBL issue 1859)=0A=0ALink: https://github.co=
m/ClangBuiltLinux/linux/issues/1859=0AReported-by: Tom Rini <trini@konsulko=
=2Ecom>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0AReviewed-=
by: Nathan Chancellor <nathan@kernel.org>=0ATested-by: Nathan Chancellor <n=
athan@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A=
---=0A Makefile | 3 +--=0A 1 file changed, 1 insertion(+), 2 deletions(-)=
=0A=0Adiff --git a/Makefile b/Makefile=0Aindex cc8e29781c25..624dc619104a 1=
00644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -568,8 +568,7 @@ ifneq ($(LLVM=
_IAS),1)=0A CLANG_FLAGS	+=3D -no-integrated-as=0A endif=0A CLANG_FLAGS	+=3D=
 -Werror=3Dunknown-warning-option=0A-KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)=0A-K=
BUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+KBUILD_CPPFLAGS	+=3D $(CLANG_FLAGS)=0A =
export CLANG_FLAGS=0A endif=0A =0A-- =0A2.49.0=0A=0A=0AFrom 869854f263162dc=
80dc632fed8db396789bdf3ab Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancello=
r <nathan@kernel.org>=0ADate: Tue, 6 Jun 2023 15:40:35 -0700=0ASubject: [PA=
TCH 5.4 8/9] kbuild: Add KBUILD_CPPFLAGS to as-option invocation=0A=0Acommi=
t 43fc0a99906e04792786edf8534d8d58d1e9de0c upstream.=0A=0AAfter commit feb8=
43a469fb ("kbuild: add $(CLANG_FLAGS) to=0AKBUILD_CPPFLAGS"), there is an e=
rror while building certain PowerPC=0Aassembly files with clang:=0A=0A  arc=
h/powerpc/lib/copypage_power7.S: Assembler messages:=0A  arch/powerpc/lib/c=
opypage_power7.S:34: Error: junk at end of line: `0b01000'=0A  arch/powerpc=
/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010'=0A  arch/p=
owerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b01000'=0A  =
arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010=
'=0A  arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0=
b01010'=0A  clang: error: assembler command failed with exit code 1 (use -v=
 to see invocation)=0A=0Aas-option only uses KBUILD_AFLAGS, so after removi=
ng CLANG_FLAGS from=0AKBUILD_AFLAGS, there is no more '--target=3D' or '--p=
refix=3D' flags. As a=0Aresult of those missing flags, the host target=0Awi=
ll be tested during as-option calls and likely fail, meaning necessary=0Afl=
ags may not get added when building assembly files, resulting in=0Aerrors l=
ike seen above.=0A=0AAdd KBUILD_CPPFLAGS to as-option invocations to clear =
up the errors.=0AThis should have been done in commit d5c8d6e0fa61 ("kbuild=
: Update=0Aassembler calls to use proper flags and language target"), which=
=0Aswitched from using the assembler target to the assembler-with-cpp=0Atar=
get, so flags that affect preprocessing are passed along in all=0Arelevant =
tests. as-option now mirrors cc-option.=0A=0AFixes: feb843a469fb ("kbuild: =
add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")=0AReported-by: Linux Kernel Functio=
nal Testing <lkft@linaro.org>=0ACloses: https://lore.kernel.org/CA+G9fYs=3D=
koW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com/=0ASigned-off-by:=
 Nathan Chancellor <nathan@kernel.org>=0ATested-by: Naresh Kamboju <naresh.=
kamboju@linaro.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=
=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Kb=
uild.include | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Ad=
iff --git a/scripts/Kbuild.include b/scripts/Kbuild.include=0Aindex 1aa02e7=
125e7..d91d06c52da8 100644=0A--- a/scripts/Kbuild.include=0A+++ b/scripts/K=
build.include=0A@@ -102,7 +102,7 @@ try-run =3D $(shell set -e;		\=0A # Usa=
ge: aflags-y +=3D $(call as-option,-Wa$(comma)-isa=3Dfoo,)=0A =0A as-option=
 =3D $(call try-run,\=0A-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembl=
er-with-cpp /dev/null -o "$$TMP",$(1),$(2))=0A+	$(CC) -Werror $(KBUILD_CPPF=
LAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$=
(1),$(2))=0A =0A # as-instr=0A # Usage: aflags-y +=3D $(call as-instr,instr=
,option1,option2)=0A-- =0A2.49.0=0A=0A=0AFrom 935bdb6b1d0545b7c0d9d221f688b=
5786ab78b86 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kern=
el.org>=0ADate: Wed, 4 Jun 2025 14:08:09 -0700=0ASubject: [PATCH 5.4 9/9] d=
rm/amd/display: Do not add '-mhard-float' to=0A dcn2{1,0}_resource.o for cl=
ang=0A=0AThis patch is for linux-5.15.y and earlier only. It is functionall=
y=0Aequivalent to upstream commit 7db038d9790e ("drm/amd/display: Do not ad=
d=0A'-mhard-float' to dml_ccflags for clang"), which was created after all=
=0Afiles that require '-mhard-float' were moved under the dml folder. In=0A=
kernels older than 5.18, which do not contain upstream commits=0A=0A  22f87=
d998326 ("drm/amd/display: move FPU operations from dcn21 to dml/dcn20 fold=
er")=0A  cf689e869cf0 ("drm/amd/display: move FPU-related code from dcn20 t=
o dml folder")=0A=0Anewer versions of clang error with=0A=0A  clang: error:=
 unsupported option '-mhard-float' for target 'x86_64-linux-gnu'=0A  make[6=
]: *** [scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/../display/d=
c/dcn20/dcn20_resource.o] Error 1=0A  clang: error: unsupported option '-mh=
ard-float' for target 'x86_64-linux-gnu'=0A  make[6]: *** [scripts/Makefile=
=2Ebuild:289: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource=
=2Eo] Error 1=0A=0AApply a functionally equivalent change to prevent adding=
 '-mhard-float'=0Awith clang for these files.=0A=0ASigned-off-by: Nathan Ch=
ancellor <nathan@kernel.org>=0A---=0A drivers/gpu/drm/amd/display/dc/dcn20/=
Makefile | 2 +-=0A drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 2 +-=0A =
2 files changed, 2 insertions(+), 2 deletions(-)=0A=0Adiff --git a/drivers/=
gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn2=
0/Makefile=0Aindex 63f3bddba7da..9b5da78a950d 100644=0A--- a/drivers/gpu/dr=
m/amd/display/dc/dcn20/Makefile=0A+++ b/drivers/gpu/drm/amd/display/dc/dcn2=
0/Makefile=0A@@ -10,7 +10,7 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT=0A DCN20=
 +=3D dcn20_dsc.o=0A endif=0A =0A-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resou=
rce.o :=3D -mhard-float -msse=0A+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resour=
ce.o :=3D $(if $(CONFIG_CC_IS_GCC), -mhard-float) -msse=0A =0A ifdef CONFIG=
_CC_IS_GCC=0A ifeq ($(call cc-ifversion, -lt, 0701, y), y)=0Adiff --git a/d=
rivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/=
dc/dcn21/Makefile=0Aindex ff50ae71fe27..a73dd11654de 100644=0A--- a/drivers=
/gpu/drm/amd/display/dc/dcn21/Makefile=0A+++ b/drivers/gpu/drm/amd/display/=
dc/dcn21/Makefile=0A@@ -3,7 +3,7 @@=0A =0A DCN21 =3D dcn21_hubp.o dcn21_hub=
bub.o dcn21_resource.o=0A =0A-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.=
o :=3D -mhard-float -msse=0A+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o=
 :=3D $(if $(CONFIG_CC_IS_GCC), -mhard-float) -msse=0A =0A ifdef CONFIG_CC_=
IS_GCC=0A ifeq ($(call cc-ifversion, -lt, 0701, y), y)=0A-- =0A2.49.0=0A=0A
--KPhBTdCXAv1onrYE
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=5.10-llvm-qunused-arguments-change.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 425b632e52f654d98c288e748108d628f9b10a53 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nick Desaulniers <ndesaulniers@google.com>=0ADate: Wed, 11 Jan 2023=
 20:04:58 -0700=0ASubject: [PATCH 5.10 01/10] x86/boot/compressed: prefer c=
c-option for CFLAGS=0A additions=0A=0Acommit 994f5f7816ff963f49269cfc97f63c=
b2e4edb84f upstream.=0A=0Aas-option tests new options using KBUILD_CFLAGS, =
which causes problems=0Awhen using as-option to update KBUILD_AFLAGS becaus=
e many compiler=0Aoptions are not valid assembler options.=0A=0AThis will b=
e fixed in a follow up patch. Before doing so, move the=0Aassembler test fo=
r -Wa,-mrelax-relocations=3Dno from using as-option to=0Acc-option.=0A=0ALi=
nk: https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=3DjMszyH=3D+M_LC9Qr6yeAGR=
CBbE6xriLxtUQ@mail.gmail.com/=0ASuggested-by: Masahiro Yamada <masahiroy@ke=
rnel.org>=0AReviewed-by: Nathan Chancellor <nathan@kernel.org>=0ATested-by:=
 Nathan Chancellor <nathan@kernel.org>=0ASigned-off-by: Nick Desaulniers <n=
desaulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.o=
rg>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested=
-by: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yam=
ada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kerne=
l.org>=0A---=0A arch/x86/boot/compressed/Makefile | 2 +-=0A 1 file changed,=
 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/arch/x86/boot/compressed/M=
akefile b/arch/x86/boot/compressed/Makefile=0Aindex 9509d345edcb..e1a750baf=
036 100644=0A--- a/arch/x86/boot/compressed/Makefile=0A+++ b/arch/x86/boot/=
compressed/Makefile=0A@@ -49,7 +49,7 @@ KBUILD_CFLAGS +=3D $(call cc-option=
,-fmacro-prefix-map=3D$(srctree)/=3D)=0A KBUILD_CFLAGS +=3D -fno-asynchrono=
us-unwind-tables=0A KBUILD_CFLAGS +=3D -D__DISABLE_EXPORTS=0A # Disable rel=
ocation relaxation in case the link is not PIE.=0A-KBUILD_CFLAGS +=3D $(cal=
l as-option,-Wa$(comma)-mrelax-relocations=3Dno)=0A+KBUILD_CFLAGS +=3D $(ca=
ll cc-option,-Wa$(comma)-mrelax-relocations=3Dno)=0A KBUILD_CFLAGS +=3D -in=
clude $(srctree)/include/linux/hidden.h=0A =0A # sev-es.c indirectly inlude=
s inat-table.h which is generated during=0A=0Abase-commit: 01e7e36b8606e5d4=
fddf795938010f7bfa3aa277=0A-- =0A2.49.0=0A=0A=0AFrom 743adb55365b530177158a=
01e7c3797e777d4135 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nath=
an@kernel.org>=0ADate: Wed, 14 Jun 2023 11:04:36 -0700=0ASubject: [PATCH 5.=
10 02/10] MIPS: Move '-Wa,-msoft-float' check from as-option=0A to cc-optio=
n=0A=0AThis patch is for linux-6.1.y and earlier, it has no direct mainline=
=0Aequivalent.=0A=0AIn order to backport commit d5c8d6e0fa61 ("kbuild: Upda=
te assembler=0Acalls to use proper flags and language target") to resolve a=
 separate=0Aissue regarding PowerPC, the problem noticed and fixed by=0Acom=
mit 80a20d2f8288 ("MIPS: Always use -Wa,-msoft-float and eliminate=0AGAS_HA=
S_SET_HARDFLOAT") needs to be addressed. Unfortunately, 6.1 and=0Aearlier d=
o not contain commit e4412739472b ("Documentation: raise=0Aminimum supporte=
d version of binutils to 2.25"), so it cannot be assumed=0Athat all support=
ed versions of GNU as have support for -msoft-float.=0A=0AIn order to switc=
h from KBUILD_CFLAGS to KBUILD_AFLAGS in as-option=0Awithout consequence, m=
ove the '-Wa,-msoft-float' check to cc-option,=0Aincluding '$(cflags-y)' di=
rectly to avoid the issue mentioned in=0Acommit 80a20d2f8288 ("MIPS: Always=
 use -Wa,-msoft-float and eliminate=0AGAS_HAS_SET_HARDFLOAT").=0A=0ASigned-=
off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/mips/Makefile |=
 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/ar=
ch/mips/Makefile b/arch/mips/Makefile=0Aindex 289fb4b88d0e..bd04b7bf6c82 10=
0644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/Makefile=0A@@ -110,7 +110=
,7 @@ endif=0A # (specifically newer than 2.24.51.20140728) we then also ne=
ed to explicitly=0A # set ".set hardfloat" in all files which manipulate fl=
oating point registers.=0A #=0A-ifneq ($(call as-option,-Wa$(comma)-msoft-f=
loat,),)=0A+ifneq ($(call cc-option,$(cflags-y) -Wa$(comma)-msoft-float,),)=
=0A 	cflags-y		+=3D -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float=0A endif=0A =
=0A-- =0A2.49.0=0A=0A=0AFrom ec3b04dadef8d96ef7027abc208d72f01e033836 Mon S=
ep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: W=
ed, 11 Jan 2023 20:05:00 -0700=0ASubject: [PATCH 5.10 03/10] MIPS: Prefer c=
c-option for additions to cflags=0AMIME-Version: 1.0=0AContent-Type: text/p=
lain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit 337ff6b=
b8960fdc128cabd264aaea3d42ca27a32 upstream.=0A=0AA future change will switc=
h as-option to use KBUILD_AFLAGS instead of=0AKBUILD_CFLAGS to allow clang =
to drop -Qunused-arguments, which may cause=0Aissues if the flag being test=
ed requires a flag previously added to=0AKBUILD_CFLAGS but not KBUILD_AFLAG=
S. Use cc-option for cflags additions=0Aso that the flags are tested proper=
ly.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0AAcked-by: T=
homas Bogendoerfer <tsbogend@alpha.franken.de>=0AReviewed-by: Nick Desaulni=
ers <ndesaulniers@google.com>=0AReviewed-by: Philippe Mathieu-Daud=C3=A9 <p=
hilmd@linaro.org>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro=
=2Eorg>=0ATested-by: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-=
by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancell=
or <nathan@kernel.org>=0A---=0A arch/mips/Makefile             | 2 +-=0A ar=
ch/mips/loongson2ef/Platform | 2 +-=0A 2 files changed, 2 insertions(+), 2 =
deletions(-)=0A=0Adiff --git a/arch/mips/Makefile b/arch/mips/Makefile=0Ain=
dex bd04b7bf6c82..209c4b037d54 100644=0A--- a/arch/mips/Makefile=0A+++ b/ar=
ch/mips/Makefile=0A@@ -153,7 +153,7 @@ cflags-y +=3D -fno-stack-check=0A #=
=0A # Avoid this by explicitly disabling that assembler behaviour.=0A #=0A-=
cflags-y +=3D $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A+cfla=
gs-y +=3D $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A =0A #=0A=
 # CPU-dependent compiler/assembler options for optimization.=0Adiff --git =
a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform=0Aindex a=
e023b9a1c51..bc3cad78990d 100644=0A--- a/arch/mips/loongson2ef/Platform=0A+=
++ b/arch/mips/loongson2ef/Platform=0A@@ -28,7 +28,7 @@ cflags-$(CONFIG_CPU=
_LOONGSON2F) +=3D \=0A # binutils does not merge support for the flag then =
we can revisit & remove=0A # this later - for now it ensures vendor toolcha=
ins don't cause problems.=0A #=0A-cflags-$(CONFIG_CPU_LOONGSON2EF)	+=3D $(c=
all as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A+cflags-$(CONFIG_CPU_L=
OONGSON2EF)	+=3D $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A =
=0A # Enable the workarounds for Loongson2f=0A ifdef CONFIG_CPU_LOONGSON2F_=
WORKAROUNDS=0A-- =0A2.49.0=0A=0A=0AFrom 0c4e9505f4563ff12ebf470cc776e67d881=
999f1 Mon Sep 17 00:00:00 2001=0AFrom: Nick Desaulniers <ndesaulniers@googl=
e.com>=0ADate: Wed, 11 Jan 2023 20:05:01 -0700=0ASubject: [PATCH 5.10 04/10=
] kbuild: Update assembler calls to use proper flags=0A and language target=
=0A=0Acommit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.=0A=0Aas-ins=
tr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can=0Acause a=
s-option to fail unexpectedly when CONFIG_WERROR is set, because=0Aclang wi=
ll emit -Werror,-Wunused-command-line-argument for various -m=0Aand -f flag=
s in KBUILD_CFLAGS for assembler sources.=0A=0ACallers of as-option and as-=
instr should be adding flags to=0AKBUILD_AFLAGS / aflags-y, not KBUILD_CFLA=
GS / cflags-y. Use=0AKBUILD_AFLAGS in all macros to clear up the initial pr=
oblem.=0A=0AUnfortunately, -Wunused-command-line-argument can still be trig=
gered=0Awith clang by the presence of warning flags or macro definitions be=
cause=0A'-x assembler' is used, instead of '-x assembler-with-cpp', which w=
ill=0Aconsume these flags. Switch to '-x assembler-with-cpp' in places wher=
e=0A'-x assembler' is used, as the compiler is always used as the driver fo=
r=0Aout of line assembler sources in the kernel.=0A=0AFinally, add -Werror =
to these macros so that they behave consistently=0Awhether or not CONFIG_WE=
RROR is set.=0A=0A[nathan: Reworded and expanded on problems in commit mess=
age=0A         Use '-x assembler-with-cpp' in a couple more places]=0A=0ALi=
nk: https://github.com/ClangBuiltLinux/linux/issues/1699=0ASuggested-by: Ma=
sahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nick Desaulniers <nde=
saulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org=
>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested-b=
y: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yamad=
a <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.=
org>=0A---=0A scripts/Kbuild.include  | 8 ++++----=0A scripts/Kconfig.inclu=
de | 2 +-=0A scripts/as-version.sh   | 2 +-=0A 3 files changed, 6 insertion=
s(+), 6 deletions(-)=0A=0Adiff --git a/scripts/Kbuild.include b/scripts/Kbu=
ild.include=0Aindex 25696de8114a..6b42ded3b857 100644=0A--- a/scripts/Kbuil=
d.include=0A+++ b/scripts/Kbuild.include=0A@@ -101,16 +101,16 @@ try-run =
=3D $(shell set -e;		\=0A 	fi)=0A =0A # as-option=0A-# Usage: cflags-y +=3D=
 $(call as-option,-Wa$(comma)-isa=3Dfoo,)=0A+# Usage: aflags-y +=3D $(call =
as-option,-Wa$(comma)-isa=3Dfoo,)=0A =0A as-option =3D $(call try-run,\=0A-=
	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2)=
)=0A+	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/nul=
l -o "$$TMP",$(1),$(2))=0A =0A # as-instr=0A-# Usage: cflags-y +=3D $(call =
as-instr,instr,option1,option2)=0A+# Usage: aflags-y +=3D $(call as-instr,i=
nstr,option1,option2)=0A =0A as-instr =3D $(call try-run,\=0A-	printf "%b\n=
" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))=
=0A+	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-=
with-cpp -o "$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS=
 +=3D $(call __cc-option,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di5=
86)=0Adiff --git a/scripts/Kconfig.include b/scripts/Kconfig.include=0Ainde=
x 6d37cb780452..65a0ae119262 100644=0A--- a/scripts/Kconfig.include=0A+++ b=
/scripts/Kconfig.include=0A@@ -33,7 +33,7 @@ ld-option =3D $(success,$(LD) =
-v $(1))=0A =0A # $(as-instr,<instr>)=0A # Return y if the assembler suppor=
ts <instr>, n otherwise=0A-as-instr =3D $(success,printf "%b\n" "$(1)" | $(=
CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)=0A+as-instr =3D $(succes=
s,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler-with-cpp -o /=
dev/null -)=0A =0A # check if $(CC) and $(LD) exist=0A $(error-if,$(failure=
,command -v $(CC)),compiler '$(CC)' not found)=0Adiff --git a/scripts/as-ve=
rsion.sh b/scripts/as-version.sh=0Aindex 532270bd4b7e..68e9344c1bca 100755=
=0A--- a/scripts/as-version.sh=0A+++ b/scripts/as-version.sh=0A@@ -45,7 +45=
,7 @@ orig_args=3D"$@"=0A # Get the first line of the --version output.=0A =
IFS=3D'=0A '=0A-set -- $(LC_ALL=3DC "$@" -Wa,--version -c -x assembler /dev=
/null -o /dev/null 2>/dev/null)=0A+set -- $(LC_ALL=3DC "$@" -Wa,--version -=
c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)=0A =0A # Split =
the line on spaces.=0A IFS=3D' '=0A-- =0A2.49.0=0A=0A=0AFrom 134e9c96ce4835=
ce141d3a743242c2347a5a688d Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancell=
or <nathan@kernel.org>=0ADate: Wed, 11 Jan 2023 20:05:09 -0700=0ASubject: [=
PATCH 5.10 05/10] drm/amd/display: Do not add '-mhard-float' to=0A dml_ccfl=
ags for clang=0A=0Acommit 7db038d9790eda558dd6c1dde4cdd58b64789c47 upstream=
=2E=0A=0AWhen clang's -Qunused-arguments is dropped from KBUILD_CPPFLAGS, i=
t=0Awarns:=0A=0A  clang-16: error: argument unused during compilation: '-mh=
ard-float' [-Werror,-Wunused-command-line-argument]=0A=0ASimilar to commit =
84edc2eff827 ("selftest/fpu: avoid clang warning"),=0Ajust add this flag to=
 GCC builds. Commit 0f0727d971f6 ("drm/amd/display:=0Areadd -msse2 to preve=
nt Clang from emitting libcalls to undefined SW FP=0Aroutines") added '-mss=
e2' to prevent clang from emitting software=0Afloating point routines.=0A=
=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0AAcked-by: Alex De=
ucher <alexander.deucher@amd.com>=0ATested-by: Linux Kernel Functional Test=
ing <lkft@linaro.org>=0ATested-by: Anders Roxell <anders.roxell@linaro.org>=
=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: N=
athan Chancellor <nathan@kernel.org>=0A---=0A drivers/gpu/drm/amd/display/d=
c/dml/Makefile | 3 ++-=0A 1 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0Adiff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/d=
rm/amd/display/dc/dml/Makefile=0Aindex 417331438c30..ce8251151b45 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile=0A+++ b/drivers/gpu/drm/a=
md/display/dc/dml/Makefile=0A@@ -26,7 +26,8 @@=0A # subcomponents.=0A =0A i=
fdef CONFIG_X86=0A-dml_ccflags :=3D -mhard-float -msse=0A+dml_ccflags-$(CON=
FIG_CC_IS_GCC) :=3D -mhard-float=0A+dml_ccflags :=3D $(dml_ccflags-y) -msse=
=0A endif=0A =0A ifdef CONFIG_PPC64=0A-- =0A2.49.0=0A=0A=0AFrom ce2896e4f70=
a42ff646082a92172729b32b216bf Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chanc=
ellor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 11:38:24 -0700=0ASubject:=
 [PATCH 5.10 06/10] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS=0A invocati=
on=0A=0Acommit 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 upstream.=0A=0AA fu=
ture change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLA=
GS so that '--target' is available while preprocessing.=0AWhen that occurs,=
 the following error appears when building ARCH=3Dmips=0Awith clang (tip of=
 tree error shown):=0A=0A  clang: error: unsupported option '-mabi=3D' for =
target 'x86_64-pc-linux-gnu'=0A=0AAdd KBUILD_CPPFLAGS in the CHECKFLAGS inv=
ocation to keep everything=0Aworking after the move.=0A=0ASigned-off-by: Na=
than Chancellor <nathan@kernel.org>=0ASigned-off-by: Masahiro Yamada <masah=
iroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A-=
--=0A arch/mips/Makefile | 2 +-=0A 1 file changed, 1 insertion(+), 1 deleti=
on(-)=0A=0Adiff --git a/arch/mips/Makefile b/arch/mips/Makefile=0Aindex 209=
c4b037d54..5303a386cd6d 100644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips=
/Makefile=0A@@ -319,7 +319,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind=
-tables=0A KBUILD_LDFLAGS		+=3D -m $(ld-emul)=0A =0A ifdef CONFIG_MIPS=0A-C=
HECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \=0A+=
CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x=
 c /dev/null | \=0A 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \=0A 	sed =
-e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&&/g')=0A end=
if=0A-- =0A2.49.0=0A=0A=0AFrom f15492481c33c3ffc31d6e5780f3cc3c19c955c8 Mon=
 Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate:=
 Thu, 1 Jun 2023 12:50:39 -0700=0ASubject: [PATCH 5.10 07/10] kbuild: Add C=
LANG_FLAGS to as-instr=0A=0Acommit cff6e7f50bd315e5b39c4e46c704ac587ceb965f=
 upstream.=0A=0AA future change will move CLANG_FLAGS from KBUILD_{A,C}FLAG=
S to=0AKBUILD_CPPFLAGS so that '--target' is available while preprocessing.=
=0AWhen that occurs, the following errors appear multiple times when=0Abuil=
ding ARCH=3Dpowerpc powernv_defconfig:=0A=0A  ld.lld: error: vmlinux.a(arch=
/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out=
 of range: -4611686018409717520 is not in [-2147483648, 2147483647]; refere=
nces '__start___soft_mask_table'=0A  ld.lld: error: vmlinux.a(arch/powerpc/=
kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR16_HI out of range=
: -4611686018409717392 is not in [-2147483648, 2147483647]; references '__s=
top___soft_mask_table'=0A=0ADiffing the .o.cmd files reveals that -DHAVE_AS=
_ATHIGH=3D1 is not present=0Aanymore, because as-instr only uses KBUILD_AFL=
AGS, which will no longer=0Acontain '--target'.=0A=0AMirror Kconfig's as-in=
str and add CLANG_FLAGS explicitly to the=0Ainvocation to ensure the target=
 information is always present.=0A=0ASigned-off-by: Nathan Chancellor <nath=
an@kernel.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Kbuild.=
include | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff -=
-git a/scripts/Kbuild.include b/scripts/Kbuild.include=0Aindex 6b42ded3b857=
=2E.fafaa42b5982 100644=0A--- a/scripts/Kbuild.include=0A+++ b/scripts/Kbui=
ld.include=0A@@ -110,7 +110,7 @@ as-option =3D $(call try-run,\=0A # Usage:=
 aflags-y +=3D $(call as-instr,instr,option1,option2)=0A =0A as-instr =3D $=
(call try-run,\=0A-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -=
c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))=0A+	printf "%b\n" "$(1)" | =
$(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "=
$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS +=3D $(call =
__cc-option,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di586)=0A-- =0A2=
=2E49.0=0A=0A=0AFrom cdb6ce3e96faf0b6d4464666ec73d94b3fd15f37 Mon Sep 17 00=
:00:00 2001=0AFrom: Masahiro Yamada <masahiroy@kernel.org>=0ADate: Sun, 9 A=
pr 2023 23:53:57 +0900=0ASubject: [PATCH 5.10 08/10] kbuild: add $(CLANG_FL=
AGS) to KBUILD_CPPFLAGS=0A=0Acommit feb843a469fb0ab00d2d23cfb9bcc379791011b=
b upstream.=0A=0AWhen preprocessing arch/*/kernel/vmlinux.lds.S, the target=
 triple is=0Anot passed to $(CPP) because we add it only to KBUILD_{C,A}FLA=
GS.=0A=0AAs a result, the linker script is preprocessed with predefined mac=
ros=0Afor the build host instead of the target.=0A=0AAssuming you use an x8=
6 build machine, compare the following:=0A=0A $ clang -dM -E -x c /dev/null=
=0A $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu=0A=0AThere is n=
o actual problem presumably because our linker scripts do not=0Arely on suc=
h predefined macros, but it is better to define correct ones.=0A=0AMove $(C=
LANG_FLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S=0Awill be pro=
cessed with the proper target triple.=0A=0A[Note]=0AAfter the patch submiss=
ion, we got an actual problem that needs this=0Acommit. (CBL issue 1859)=0A=
=0ALink: https://github.com/ClangBuiltLinux/linux/issues/1859=0AReported-by=
: Tom Rini <trini@konsulko.com>=0ASigned-off-by: Masahiro Yamada <masahiroy=
@kernel.org>=0AReviewed-by: Nathan Chancellor <nathan@kernel.org>=0ATested-=
by: Nathan Chancellor <nathan@kernel.org>=0ASigned-off-by: Nathan Chancello=
r <nathan@kernel.org>=0A---=0A Makefile | 3 +--=0A 1 file changed, 1 insert=
ion(+), 2 deletions(-)=0A=0Adiff --git a/Makefile b/Makefile=0Aindex 7d9403=
4c906d..f8eafb004686 100644=0A--- a/Makefile=0A+++ b/Makefile=0A@@ -586,8 +=
586,7 @@ else=0A CLANG_FLAGS	+=3D -fno-integrated-as=0A endif=0A CLANG_FLAG=
S	+=3D -Werror=3Dunknown-warning-option=0A-KBUILD_CFLAGS	+=3D $(CLANG_FLAGS=
)=0A-KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+KBUILD_CPPFLAGS	+=3D $(CLANG_FLAG=
S)=0A export CLANG_FLAGS=0A endif=0A =0A-- =0A2.49.0=0A=0A=0AFrom c2a21b294=
219ab6cd6e58a8201fe888f1e3ebf94 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Cha=
ncellor <nathan@kernel.org>=0ADate: Tue, 6 Jun 2023 15:40:35 -0700=0ASubjec=
t: [PATCH 5.10 09/10] kbuild: Add KBUILD_CPPFLAGS to as-option=0A invocatio=
n=0A=0Acommit 43fc0a99906e04792786edf8534d8d58d1e9de0c upstream.=0A=0AAfter=
 commit feb843a469fb ("kbuild: add $(CLANG_FLAGS) to=0AKBUILD_CPPFLAGS"), t=
here is an error while building certain PowerPC=0Aassembly files with clang=
:=0A=0A  arch/powerpc/lib/copypage_power7.S: Assembler messages:=0A  arch/p=
owerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b01000'=0A  =
arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010=
'=0A  arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0=
b01000'=0A  arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of li=
ne: `0b01010'=0A  arch/powerpc/lib/copypage_power7.S:40: Error: junk at end=
 of line: `0b01010'=0A  clang: error: assembler command failed with exit co=
de 1 (use -v to see invocation)=0A=0Aas-option only uses KBUILD_AFLAGS, so =
after removing CLANG_FLAGS from=0AKBUILD_AFLAGS, there is no more '--target=
=3D' or '--prefix=3D' flags. As a=0Aresult of those missing flags, the host=
 target=0Awill be tested during as-option calls and likely fail, meaning ne=
cessary=0Aflags may not get added when building assembly files, resulting i=
n=0Aerrors like seen above.=0A=0AAdd KBUILD_CPPFLAGS to as-option invocatio=
ns to clear up the errors.=0AThis should have been done in commit d5c8d6e0f=
a61 ("kbuild: Update=0Aassembler calls to use proper flags and language tar=
get"), which=0Aswitched from using the assembler target to the assembler-wi=
th-cpp=0Atarget, so flags that affect preprocessing are passed along in all=
=0Arelevant tests. as-option now mirrors cc-option.=0A=0AFixes: feb843a469f=
b ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")=0AReported-by: Linux Ke=
rnel Functional Testing <lkft@linaro.org>=0ACloses: https://lore.kernel.org=
/CA+G9fYs=3DkoW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com/=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0ATested-by: Naresh Kamb=
oju <naresh.kamboju@linaro.org>=0ASigned-off-by: Masahiro Yamada <masahiroy=
@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=
=0A scripts/Kbuild.include | 2 +-=0A 1 file changed, 1 insertion(+), 1 dele=
tion(-)=0A=0Adiff --git a/scripts/Kbuild.include b/scripts/Kbuild.include=
=0Aindex fafaa42b5982..3e5c8d09d82c 100644=0A--- a/scripts/Kbuild.include=
=0A+++ b/scripts/Kbuild.include=0A@@ -104,7 +104,7 @@ try-run =3D $(shell s=
et -e;		\=0A # Usage: aflags-y +=3D $(call as-option,-Wa$(comma)-isa=3Dfoo,=
)=0A =0A as-option =3D $(call try-run,\=0A-	$(CC) -Werror $(KBUILD_AFLAGS) =
$(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))=0A+	$(CC) -We=
rror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev=
/null -o "$$TMP",$(1),$(2))=0A =0A # as-instr=0A # Usage: aflags-y +=3D $(c=
all as-instr,instr,option1,option2)=0A-- =0A2.49.0=0A=0A=0AFrom e6e998099d2=
38f334f58bd3c4a4f68528a61a45a Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chanc=
ellor <nathan@kernel.org>=0ADate: Wed, 4 Jun 2025 14:08:09 -0700=0ASubject:=
 [PATCH 5.10 10/10] drm/amd/display: Do not add '-mhard-float' to=0A dcn2{1=
,0}_resource.o for clang=0A=0AThis patch is for linux-5.15.y and earlier on=
ly. It is functionally=0Aequivalent to upstream commit 7db038d9790e ("drm/a=
md/display: Do not add=0A'-mhard-float' to dml_ccflags for clang"), which w=
as created after all=0Afiles that require '-mhard-float' were moved under t=
he dml folder. In=0Akernels older than 5.18, which do not contain upstream =
commits=0A=0A  22f87d998326 ("drm/amd/display: move FPU operations from dcn=
21 to dml/dcn20 folder")=0A  cf689e869cf0 ("drm/amd/display: move FPU-relat=
ed code from dcn20 to dml folder")=0A=0Anewer versions of clang error with=
=0A=0A  clang: error: unsupported option '-mhard-float' for target 'x86_64-=
linux-gnu'=0A  make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/am=
d/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1=0A  clang: error: un=
supported option '-mhard-float' for target 'x86_64-linux-gnu'=0A  make[6]: =
*** [scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/../display/dc/d=
cn21/dcn21_resource.o] Error 1=0A=0AApply a functionally equivalent change =
to prevent adding '-mhard-float'=0Awith clang for these files.=0A=0ASigned-=
off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A drivers/gpu/drm/amd/=
display/dc/dcn20/Makefile | 2 +-=0A drivers/gpu/drm/amd/display/dc/dcn21/Ma=
kefile | 2 +-=0A 2 files changed, 2 insertions(+), 2 deletions(-)=0A=0Adiff=
 --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/am=
d/display/dc/dcn20/Makefile=0Aindex 5fcaf78334ff..54db9af8437d 100644=0A---=
 a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile=0A+++ b/drivers/gpu/drm/am=
d/display/dc/dcn20/Makefile=0A@@ -10,7 +10,7 @@ DCN20 =3D dcn20_resource.o =
dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o d=0A DCN20 +=3D dcn20=
_dsc.o=0A =0A ifdef CONFIG_X86=0A-CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resou=
rce.o :=3D -mhard-float -msse=0A+CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resour=
ce.o :=3D $(if $(CONFIG_CC_IS_GCC), -mhard-float) -msse=0A endif=0A =0A ifd=
ef CONFIG_PPC64=0Adiff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefil=
e b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile=0Aindex 07684d3e375a..90e=
efd2c3ecf 100644=0A--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile=0A++=
+ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile=0A@@ -6,7 +6,7 @@ DCN21 =
=3D dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \=0A 	 dcn21_=
hwseq.o dcn21_link_encoder.o=0A =0A ifdef CONFIG_X86=0A-CFLAGS_$(AMDDALPATH=
)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -msse=0A+CFLAGS_$(AMDDALPATH)=
/dc/dcn21/dcn21_resource.o :=3D $(if $(CONFIG_CC_IS_GCC), -mhard-float) -ms=
se=0A endif=0A =0A ifdef CONFIG_PPC64=0A-- =0A2.49.0=0A=0A
--KPhBTdCXAv1onrYE
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=5.15-llvm-qunused-arguments-change.mbox
Content-Transfer-Encoding: quoted-printable

=46rom 06e31e53fddaab7e88f38e8f99a86e46ed8ca3f5 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nick Desaulniers <ndesaulniers@google.com>=0ADate: Wed, 11 Jan 2023=
 20:04:58 -0700=0ASubject: [PATCH 5.15 01/10] x86/boot/compressed: prefer c=
c-option for CFLAGS=0A additions=0A=0Acommit 994f5f7816ff963f49269cfc97f63c=
b2e4edb84f upstream.=0A=0Aas-option tests new options using KBUILD_CFLAGS, =
which causes problems=0Awhen using as-option to update KBUILD_AFLAGS becaus=
e many compiler=0Aoptions are not valid assembler options.=0A=0AThis will b=
e fixed in a follow up patch. Before doing so, move the=0Aassembler test fo=
r -Wa,-mrelax-relocations=3Dno from using as-option to=0Acc-option.=0A=0ALi=
nk: https://lore.kernel.org/llvm/CAK7LNATcHt7GcXZ=3DjMszyH=3D+M_LC9Qr6yeAGR=
CBbE6xriLxtUQ@mail.gmail.com/=0ASuggested-by: Masahiro Yamada <masahiroy@ke=
rnel.org>=0AReviewed-by: Nathan Chancellor <nathan@kernel.org>=0ATested-by:=
 Nathan Chancellor <nathan@kernel.org>=0ASigned-off-by: Nick Desaulniers <n=
desaulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.o=
rg>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested=
-by: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yam=
ada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kerne=
l.org>=0A---=0A arch/x86/boot/compressed/Makefile | 2 +-=0A 1 file changed,=
 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/arch/x86/boot/compressed/M=
akefile b/arch/x86/boot/compressed/Makefile=0Aindex 3ec9fb6b0378..f82b2cb24=
360 100644=0A--- a/arch/x86/boot/compressed/Makefile=0A+++ b/arch/x86/boot/=
compressed/Makefile=0A@@ -50,7 +50,7 @@ KBUILD_CFLAGS +=3D $(call cc-option=
,-fmacro-prefix-map=3D$(srctree)/=3D)=0A KBUILD_CFLAGS +=3D -fno-asynchrono=
us-unwind-tables=0A KBUILD_CFLAGS +=3D -D__DISABLE_EXPORTS=0A # Disable rel=
ocation relaxation in case the link is not PIE.=0A-KBUILD_CFLAGS +=3D $(cal=
l as-option,-Wa$(comma)-mrelax-relocations=3Dno)=0A+KBUILD_CFLAGS +=3D $(ca=
ll cc-option,-Wa$(comma)-mrelax-relocations=3Dno)=0A KBUILD_CFLAGS +=3D -in=
clude $(srctree)/include/linux/hidden.h=0A =0A # sev.c indirectly inludes i=
nat-table.h which is generated during=0A=0Abase-commit: 1c700860e8bc079c5c7=
1d73c55e51865d273943c=0A-- =0A2.49.0=0A=0A=0AFrom 4b4e7a4e8985db4d9e0dae0bf=
5a6b217fef46501 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@=
kernel.org>=0ADate: Wed, 14 Jun 2023 11:04:36 -0700=0ASubject: [PATCH 5.15 =
02/10] MIPS: Move '-Wa,-msoft-float' check from as-option=0A to cc-option=
=0A=0AThis patch is for linux-6.1.y and earlier, it has no direct mainline=
=0Aequivalent.=0A=0AIn order to backport commit d5c8d6e0fa61 ("kbuild: Upda=
te assembler=0Acalls to use proper flags and language target") to resolve a=
 separate=0Aissue regarding PowerPC, the problem noticed and fixed by=0Acom=
mit 80a20d2f8288 ("MIPS: Always use -Wa,-msoft-float and eliminate=0AGAS_HA=
S_SET_HARDFLOAT") needs to be addressed. Unfortunately, 6.1 and=0Aearlier d=
o not contain commit e4412739472b ("Documentation: raise=0Aminimum supporte=
d version of binutils to 2.25"), so it cannot be assumed=0Athat all support=
ed versions of GNU as have support for -msoft-float.=0A=0AIn order to switc=
h from KBUILD_CFLAGS to KBUILD_AFLAGS in as-option=0Awithout consequence, m=
ove the '-Wa,-msoft-float' check to cc-option,=0Aincluding '$(cflags-y)' di=
rectly to avoid the issue mentioned in=0Acommit 80a20d2f8288 ("MIPS: Always=
 use -Wa,-msoft-float and eliminate=0AGAS_HAS_SET_HARDFLOAT").=0A=0ASigned-=
off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/mips/Makefile |=
 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --git a/ar=
ch/mips/Makefile b/arch/mips/Makefile=0Aindex 37048fbffdb7..e5d4a804070d 10=
0644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/Makefile=0A@@ -110,7 +110=
,7 @@ endif=0A # (specifically newer than 2.24.51.20140728) we then also ne=
ed to explicitly=0A # set ".set hardfloat" in all files which manipulate fl=
oating point registers.=0A #=0A-ifneq ($(call as-option,-Wa$(comma)-msoft-f=
loat,),)=0A+ifneq ($(call cc-option,$(cflags-y) -Wa$(comma)-msoft-float,),)=
=0A 	cflags-y		+=3D -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float=0A endif=0A =
=0A-- =0A2.49.0=0A=0A=0AFrom 68a4897d6e554da3a1daa7458f22ce118a5f62d6 Mon S=
ep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: W=
ed, 11 Jan 2023 20:05:00 -0700=0ASubject: [PATCH 5.15 03/10] MIPS: Prefer c=
c-option for additions to cflags=0AMIME-Version: 1.0=0AContent-Type: text/p=
lain; charset=3DUTF-8=0AContent-Transfer-Encoding: 8bit=0A=0Acommit 337ff6b=
b8960fdc128cabd264aaea3d42ca27a32 upstream.=0A=0AA future change will switc=
h as-option to use KBUILD_AFLAGS instead of=0AKBUILD_CFLAGS to allow clang =
to drop -Qunused-arguments, which may cause=0Aissues if the flag being test=
ed requires a flag previously added to=0AKBUILD_CFLAGS but not KBUILD_AFLAG=
S. Use cc-option for cflags additions=0Aso that the flags are tested proper=
ly.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0AAcked-by: T=
homas Bogendoerfer <tsbogend@alpha.franken.de>=0AReviewed-by: Nick Desaulni=
ers <ndesaulniers@google.com>=0AReviewed-by: Philippe Mathieu-Daud=C3=A9 <p=
hilmd@linaro.org>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro=
=2Eorg>=0ATested-by: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-=
by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancell=
or <nathan@kernel.org>=0A---=0A arch/mips/Makefile             | 2 +-=0A ar=
ch/mips/loongson2ef/Platform | 2 +-=0A 2 files changed, 2 insertions(+), 2 =
deletions(-)=0A=0Adiff --git a/arch/mips/Makefile b/arch/mips/Makefile=0Ain=
dex e5d4a804070d..c5b5680e54ba 100644=0A--- a/arch/mips/Makefile=0A+++ b/ar=
ch/mips/Makefile=0A@@ -153,7 +153,7 @@ cflags-y +=3D -fno-stack-check=0A #=
=0A # Avoid this by explicitly disabling that assembler behaviour.=0A #=0A-=
cflags-y +=3D $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A+cfla=
gs-y +=3D $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A =0A #=0A=
 # CPU-dependent compiler/assembler options for optimization.=0Adiff --git =
a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform=0Aindex a=
e023b9a1c51..bc3cad78990d 100644=0A--- a/arch/mips/loongson2ef/Platform=0A+=
++ b/arch/mips/loongson2ef/Platform=0A@@ -28,7 +28,7 @@ cflags-$(CONFIG_CPU=
_LOONGSON2F) +=3D \=0A # binutils does not merge support for the flag then =
we can revisit & remove=0A # this later - for now it ensures vendor toolcha=
ins don't cause problems.=0A #=0A-cflags-$(CONFIG_CPU_LOONGSON2EF)	+=3D $(c=
all as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A+cflags-$(CONFIG_CPU_L=
OONGSON2EF)	+=3D $(call cc-option,-Wa$(comma)-mno-fix-loongson3-llsc,)=0A =
=0A # Enable the workarounds for Loongson2f=0A ifdef CONFIG_CPU_LOONGSON2F_=
WORKAROUNDS=0A-- =0A2.49.0=0A=0A=0AFrom 01d9e28227e3b0e79082e7acae18496c58d=
83528 Mon Sep 17 00:00:00 2001=0AFrom: Nick Desaulniers <ndesaulniers@googl=
e.com>=0ADate: Wed, 11 Jan 2023 20:05:01 -0700=0ASubject: [PATCH 5.15 04/10=
] kbuild: Update assembler calls to use proper flags=0A and language target=
=0A=0Acommit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.=0A=0Aas-ins=
tr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS. This can=0Acause a=
s-option to fail unexpectedly when CONFIG_WERROR is set, because=0Aclang wi=
ll emit -Werror,-Wunused-command-line-argument for various -m=0Aand -f flag=
s in KBUILD_CFLAGS for assembler sources.=0A=0ACallers of as-option and as-=
instr should be adding flags to=0AKBUILD_AFLAGS / aflags-y, not KBUILD_CFLA=
GS / cflags-y. Use=0AKBUILD_AFLAGS in all macros to clear up the initial pr=
oblem.=0A=0AUnfortunately, -Wunused-command-line-argument can still be trig=
gered=0Awith clang by the presence of warning flags or macro definitions be=
cause=0A'-x assembler' is used, instead of '-x assembler-with-cpp', which w=
ill=0Aconsume these flags. Switch to '-x assembler-with-cpp' in places wher=
e=0A'-x assembler' is used, as the compiler is always used as the driver fo=
r=0Aout of line assembler sources in the kernel.=0A=0AFinally, add -Werror =
to these macros so that they behave consistently=0Awhether or not CONFIG_WE=
RROR is set.=0A=0A[nathan: Reworded and expanded on problems in commit mess=
age=0A         Use '-x assembler-with-cpp' in a couple more places]=0A=0ALi=
nk: https://github.com/ClangBuiltLinux/linux/issues/1699=0ASuggested-by: Ma=
sahiro Yamada <masahiroy@kernel.org>=0ASigned-off-by: Nick Desaulniers <nde=
saulniers@google.com>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org=
>=0ATested-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ATested-b=
y: Anders Roxell <anders.roxell@linaro.org>=0ASigned-off-by: Masahiro Yamad=
a <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.=
org>=0A---=0A scripts/Kconfig.include   | 2 +-=0A scripts/Makefile.compiler=
 | 8 ++++----=0A scripts/as-version.sh     | 2 +-=0A 3 files changed, 6 ins=
ertions(+), 6 deletions(-)=0A=0Adiff --git a/scripts/Kconfig.include b/scri=
pts/Kconfig.include=0Aindex 0496efd6e117..8d5c65e355eb 100644=0A--- a/scrip=
ts/Kconfig.include=0A+++ b/scripts/Kconfig.include=0A@@ -33,7 +33,7 @@ ld-o=
ption =3D $(success,$(LD) -v $(1))=0A =0A # $(as-instr,<instr>)=0A # Return=
 y if the assembler supports <instr>, n otherwise=0A-as-instr =3D $(success=
,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -=
)=0A+as-instr =3D $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c =
-x assembler-with-cpp -o /dev/null -)=0A =0A # check if $(CC) and $(LD) exi=
st=0A $(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)=0A=
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler=0Aindex =
60ddd47bfa1b..4239ef128c20 100644=0A--- a/scripts/Makefile.compiler=0A+++ b=
/scripts/Makefile.compiler=0A@@ -29,16 +29,16 @@ try-run =3D $(shell set -e=
;		\=0A 	fi)=0A =0A # as-option=0A-# Usage: cflags-y +=3D $(call as-option,=
-Wa$(comma)-isa=3Dfoo,)=0A+# Usage: aflags-y +=3D $(call as-option,-Wa$(com=
ma)-isa=3Dfoo,)=0A =0A as-option =3D $(call try-run,\=0A-	$(CC) $(KBUILD_CF=
LAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))=0A+	$(CC) -Werro=
r $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),=
$(2))=0A =0A # as-instr=0A-# Usage: cflags-y +=3D $(call as-instr,instr,opt=
ion1,option2)=0A+# Usage: aflags-y +=3D $(call as-instr,instr,option1,optio=
n2)=0A =0A as-instr =3D $(call try-run,\=0A-	printf "%b\n" "$(1)" | $(CC) $=
(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))=0A+	printf "%b\n" "=
$(1)" | $(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" =
-,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS +=3D $(call __cc-op=
tion,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di586)=0Adiff --git a/s=
cripts/as-version.sh b/scripts/as-version.sh=0Aindex 1a21495e9ff0..af717476=
152d 100755=0A--- a/scripts/as-version.sh=0A+++ b/scripts/as-version.sh=0A@=
@ -45,7 +45,7 @@ orig_args=3D"$@"=0A # Get the first line of the --version =
output.=0A IFS=3D'=0A '=0A-set -- $(LC_ALL=3DC "$@" -Wa,--version -c -x ass=
embler /dev/null -o /dev/null 2>/dev/null)=0A+set -- $(LC_ALL=3DC "$@" -Wa,=
--version -c -x assembler-with-cpp /dev/null -o /dev/null 2>/dev/null)=0A =
=0A # Split the line on spaces.=0A IFS=3D' '=0A-- =0A2.49.0=0A=0A=0AFrom f5=
3b2c11a303ee300c7ef802da56c41f928f7ab8 Mon Sep 17 00:00:00 2001=0AFrom: Nat=
han Chancellor <nathan@kernel.org>=0ADate: Wed, 11 Jan 2023 20:05:09 -0700=
=0ASubject: [PATCH 5.15 05/10] drm/amd/display: Do not add '-mhard-float' t=
o=0A dml_ccflags for clang=0A=0Acommit 7db038d9790eda558dd6c1dde4cdd58b6478=
9c47 upstream.=0A=0AWhen clang's -Qunused-arguments is dropped from KBUILD_=
CPPFLAGS, it=0Awarns:=0A=0A  clang-16: error: argument unused during compil=
ation: '-mhard-float' [-Werror,-Wunused-command-line-argument]=0A=0ASimilar=
 to commit 84edc2eff827 ("selftest/fpu: avoid clang warning"),=0Ajust add t=
his flag to GCC builds. Commit 0f0727d971f6 ("drm/amd/display:=0Areadd -mss=
e2 to prevent Clang from emitting libcalls to undefined SW FP=0Aroutines") =
added '-msse2' to prevent clang from emitting software=0Afloating point rou=
tines.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0AAcked-by=
: Alex Deucher <alexander.deucher@amd.com>=0ATested-by: Linux Kernel Functi=
onal Testing <lkft@linaro.org>=0ATested-by: Anders Roxell <anders.roxell@li=
naro.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-=
off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A drivers/gpu/drm/amd/=
display/dc/dml/Makefile | 3 ++-=0A 1 file changed, 2 insertions(+), 1 delet=
ion(-)=0A=0Adiff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/driv=
ers/gpu/drm/amd/display/dc/dml/Makefile=0Aindex 96e70832c742..36cac3839b50 =
100644=0A--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile=0A+++ b/drivers/=
gpu/drm/amd/display/dc/dml/Makefile=0A@@ -26,7 +26,8 @@=0A # subcomponents.=
=0A =0A ifdef CONFIG_X86=0A-dml_ccflags :=3D -mhard-float -msse=0A+dml_ccfl=
ags-$(CONFIG_CC_IS_GCC) :=3D -mhard-float=0A+dml_ccflags :=3D $(dml_ccflags=
-y) -msse=0A endif=0A =0A ifdef CONFIG_PPC64=0A-- =0A2.49.0=0A=0A=0AFrom a4=
f869e88a21880939d0b956b20d6a70c5298de3 Mon Sep 17 00:00:00 2001=0AFrom: Nat=
han Chancellor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 11:38:24 -0700=
=0ASubject: [PATCH 5.15 06/10] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS=
=0A invocation=0A=0Acommit 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 upstrea=
m.=0A=0AA future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to=0AK=
BUILD_CPPFLAGS so that '--target' is available while preprocessing.=0AWhen =
that occurs, the following error appears when building ARCH=3Dmips=0Awith c=
lang (tip of tree error shown):=0A=0A  clang: error: unsupported option '-m=
abi=3D' for target 'x86_64-pc-linux-gnu'=0A=0AAdd KBUILD_CPPFLAGS in the CH=
ECKFLAGS invocation to keep everything=0Aworking after the move.=0A=0ASigne=
d-off-by: Nathan Chancellor <nathan@kernel.org>=0ASigned-off-by: Masahiro Y=
amada <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@ker=
nel.org>=0A---=0A arch/mips/Makefile | 2 +-=0A 1 file changed, 1 insertion(=
+), 1 deletion(-)=0A=0Adiff --git a/arch/mips/Makefile b/arch/mips/Makefile=
=0Aindex c5b5680e54ba..8d1b1d7b8e02 100644=0A--- a/arch/mips/Makefile=0A+++=
 b/arch/mips/Makefile=0A@@ -322,7 +322,7 @@ KBUILD_CFLAGS +=3D -fno-asynchr=
onous-unwind-tables=0A KBUILD_LDFLAGS		+=3D -m $(ld-emul)=0A =0A ifdef need=
-compiler=0A-CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /de=
v/null | \=0A+CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFL=
AGS) -dM -E -x c /dev/null | \=0A 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)=
?_' | \=0A 	sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\=
$$/&&/g')=0A endif=0A-- =0A2.49.0=0A=0A=0AFrom 46dfd9d2352d780a4931ee5bfb11=
de700f8a0ad0 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@ker=
nel.org>=0ADate: Thu, 1 Jun 2023 12:50:39 -0700=0ASubject: [PATCH 5.15 07/1=
0] kbuild: Add CLANG_FLAGS to as-instr=0A=0Acommit cff6e7f50bd315e5b39c4e46=
c704ac587ceb965f upstream.=0A=0AA future change will move CLANG_FLAGS from =
KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS so that '--target' is available whil=
e preprocessing.=0AWhen that occurs, the following errors appear multiple t=
imes when=0Abuilding ARCH=3Dpowerpc powernv_defconfig:=0A=0A  ld.lld: error=
: vmlinux.a(arch/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC=
64_ADDR16_HI out of range: -4611686018409717520 is not in [-2147483648, 214=
7483647]; references '__start___soft_mask_table'=0A  ld.lld: error: vmlinux=
=2Ea(arch/powerpc/kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR=
16_HI out of range: -4611686018409717392 is not in [-2147483648, 2147483647=
]; references '__stop___soft_mask_table'=0A=0ADiffing the .o.cmd files reve=
als that -DHAVE_AS_ATHIGH=3D1 is not present=0Aanymore, because as-instr on=
ly uses KBUILD_AFLAGS, which will no longer=0Acontain '--target'.=0A=0AMirr=
or Kconfig's as-instr and add CLANG_FLAGS explicitly to the=0Ainvocation to=
 ensure the target information is always present.=0A=0ASigned-off-by: Natha=
n Chancellor <nathan@kernel.org>=0ASigned-off-by: Masahiro Yamada <masahiro=
y@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=
=0A scripts/Makefile.compiler | 2 +-=0A 1 file changed, 1 insertion(+), 1 d=
eletion(-)=0A=0Adiff --git a/scripts/Makefile.compiler b/scripts/Makefile.c=
ompiler=0Aindex 4239ef128c20..77c2b9f0997c 100644=0A--- a/scripts/Makefile.=
compiler=0A+++ b/scripts/Makefile.compiler=0A@@ -38,7 +38,7 @@ as-option =
=3D $(call try-run,\=0A # Usage: aflags-y +=3D $(call as-instr,instr,option=
1,option2)=0A =0A as-instr =3D $(call try-run,\=0A-	printf "%b\n" "$(1)" | =
$(CC) -Werror $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$=
(3))=0A+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAG=
S) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A=
 # Usage: MY_CFLAGS +=3D $(call __cc-option,$(CC),$(MY_CFLAGS),-march=3Dwin=
chip-c6,-march=3Di586)=0A-- =0A2.49.0=0A=0A=0AFrom f48a7cc6d5347888037fc41b=
d55014b0f578a9d9 Mon Sep 17 00:00:00 2001=0AFrom: Masahiro Yamada <masahiro=
y@kernel.org>=0ADate: Sun, 9 Apr 2023 23:53:57 +0900=0ASubject: [PATCH 5.15=
 08/10] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS=0A=0Acommit feb843a46=
9fb0ab00d2d23cfb9bcc379791011bb upstream.=0A=0AWhen preprocessing arch/*/ke=
rnel/vmlinux.lds.S, the target triple is=0Anot passed to $(CPP) because we =
add it only to KBUILD_{C,A}FLAGS.=0A=0AAs a result, the linker script is pr=
eprocessed with predefined macros=0Afor the build host instead of the targe=
t.=0A=0AAssuming you use an x86 build machine, compare the following:=0A=0A=
 $ clang -dM -E -x c /dev/null=0A $ clang -dM -E -x c /dev/null -target aar=
ch64-linux-gnu=0A=0AThere is no actual problem presumably because our linke=
r scripts do not=0Arely on such predefined macros, but it is better to defi=
ne correct ones.=0A=0AMove $(CLANG_FLAGS) to KBUILD_CPPFLAGS, so that all *=
=2Ec, *.S, *.lds.S=0Awill be processed with the proper target triple.=0A=0A=
[Note]=0AAfter the patch submission, we got an actual problem that needs th=
is=0Acommit. (CBL issue 1859)=0A=0ALink: https://github.com/ClangBuiltLinux=
/linux/issues/1859=0AReported-by: Tom Rini <trini@konsulko.com>=0ASigned-of=
f-by: Masahiro Yamada <masahiroy@kernel.org>=0AReviewed-by: Nathan Chancell=
or <nathan@kernel.org>=0ATested-by: Nathan Chancellor <nathan@kernel.org>=
=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Ma=
kefile.clang | 3 +--=0A 1 file changed, 1 insertion(+), 2 deletions(-)=0A=
=0Adiff --git a/scripts/Makefile.clang b/scripts/Makefile.clang=0Aindex 51f=
c23e2e9e5..c36ccd396b2d 100644=0A--- a/scripts/Makefile.clang=0A+++ b/scrip=
ts/Makefile.clang=0A@@ -35,6 +35,5 @@ endif=0A # so they can be implemented=
 or wrapped in cc-option.=0A CLANG_FLAGS	+=3D -Werror=3Dunknown-warning-opt=
ion=0A CLANG_FLAGS	+=3D -Werror=3Dignored-optimization-argument=0A-KBUILD_C=
FLAGS	+=3D $(CLANG_FLAGS)=0A-KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+KBUILD_CP=
PFLAGS	+=3D $(CLANG_FLAGS)=0A export CLANG_FLAGS=0A-- =0A2.49.0=0A=0A=0AFro=
m 6889c84760677af5cb34e1432ea09fd18975f8e3 Mon Sep 17 00:00:00 2001=0AFrom:=
 Nathan Chancellor <nathan@kernel.org>=0ADate: Tue, 6 Jun 2023 15:40:35 -07=
00=0ASubject: [PATCH 5.15 09/10] kbuild: Add KBUILD_CPPFLAGS to as-option=
=0A invocation=0A=0Acommit 43fc0a99906e04792786edf8534d8d58d1e9de0c upstrea=
m.=0A=0AAfter commit feb843a469fb ("kbuild: add $(CLANG_FLAGS) to=0AKBUILD_=
CPPFLAGS"), there is an error while building certain PowerPC=0Aassembly fil=
es with clang:=0A=0A  arch/powerpc/lib/copypage_power7.S: Assembler message=
s:=0A  arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `=
0b01000'=0A  arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of l=
ine: `0b01010'=0A  arch/powerpc/lib/copypage_power7.S:37: Error: junk at en=
d of line: `0b01000'=0A  arch/powerpc/lib/copypage_power7.S:38: Error: junk=
 at end of line: `0b01010'=0A  arch/powerpc/lib/copypage_power7.S:40: Error=
: junk at end of line: `0b01010'=0A  clang: error: assembler command failed=
 with exit code 1 (use -v to see invocation)=0A=0Aas-option only uses KBUIL=
D_AFLAGS, so after removing CLANG_FLAGS from=0AKBUILD_AFLAGS, there is no m=
ore '--target=3D' or '--prefix=3D' flags. As a=0Aresult of those missing fl=
ags, the host target=0Awill be tested during as-option calls and likely fai=
l, meaning necessary=0Aflags may not get added when building assembly files=
, resulting in=0Aerrors like seen above.=0A=0AAdd KBUILD_CPPFLAGS to as-opt=
ion invocations to clear up the errors.=0AThis should have been done in com=
mit d5c8d6e0fa61 ("kbuild: Update=0Aassembler calls to use proper flags and=
 language target"), which=0Aswitched from using the assembler target to the=
 assembler-with-cpp=0Atarget, so flags that affect preprocessing are passed=
 along in all=0Arelevant tests. as-option now mirrors cc-option.=0A=0AFixes=
: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")=0AReported=
-by: Linux Kernel Functional Testing <lkft@linaro.org>=0ACloses: https://lo=
re.kernel.org/CA+G9fYs=3DkoW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gm=
ail.com/=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0ATested-by=
: Naresh Kamboju <naresh.kamboju@linaro.org>=0ASigned-off-by: Masahiro Yama=
da <masahiroy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel=
=2Eorg>=0A---=0A scripts/Makefile.compiler | 2 +-=0A 1 file changed, 1 inse=
rtion(+), 1 deletion(-)=0A=0Adiff --git a/scripts/Makefile.compiler b/scrip=
ts/Makefile.compiler=0Aindex 77c2b9f0997c..3eddd0ab2532 100644=0A--- a/scri=
pts/Makefile.compiler=0A+++ b/scripts/Makefile.compiler=0A@@ -32,7 +32,7 @@=
 try-run =3D $(shell set -e;		\=0A # Usage: aflags-y +=3D $(call as-option,=
-Wa$(comma)-isa=3Dfoo,)=0A =0A as-option =3D $(call try-run,\=0A-	$(CC) -We=
rror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(=
1),$(2))=0A+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x a=
ssembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))=0A =0A # as-instr=0A # Us=
age: aflags-y +=3D $(call as-instr,instr,option1,option2)=0A-- =0A2.49.0=0A=
=0A=0AFrom 95a29c05be26757e20051920b9ecc2d72c73c1f3 Mon Sep 17 00:00:00 200=
1=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADate: Wed, 4 Jun 2025 14:=
08:09 -0700=0ASubject: [PATCH 5.15 10/10] drm/amd/display: Do not add '-mha=
rd-float' to=0A dcn2{1,0}_resource.o for clang=0A=0AThis patch is for linux=
-5.15.y and earlier only. It is functionally=0Aequivalent to upstream commi=
t 7db038d9790e ("drm/amd/display: Do not add=0A'-mhard-float' to dml_ccflag=
s for clang"), which was created after all=0Afiles that require '-mhard-flo=
at' were moved under the dml folder. In=0Akernels older than 5.18, which do=
 not contain upstream commits=0A=0A  22f87d998326 ("drm/amd/display: move F=
PU operations from dcn21 to dml/dcn20 folder")=0A  cf689e869cf0 ("drm/amd/d=
isplay: move FPU-related code from dcn20 to dml folder")=0A=0Anewer version=
s of clang error with=0A=0A  clang: error: unsupported option '-mhard-float=
' for target 'x86_64-linux-gnu'=0A  make[6]: *** [scripts/Makefile.build:28=
9: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1=
=0A  clang: error: unsupported option '-mhard-float' for target 'x86_64-lin=
ux-gnu'=0A  make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/amd/a=
mdgpu/../display/dc/dcn21/dcn21_resource.o] Error 1=0A=0AApply a functional=
ly equivalent change to prevent adding '-mhard-float'=0Awith clang for thes=
e files.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A=
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 2 +-=0A drivers/gpu/drm/am=
d/display/dc/dcn21/Makefile | 2 +-=0A 2 files changed, 2 insertions(+), 2 d=
eletions(-)=0A=0Adiff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile=
 b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile=0Aindex 5fcaf78334ff..54db=
9af8437d 100644=0A--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile=0A+++=
 b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile=0A@@ -10,7 +10,7 @@ DCN20 =
=3D dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o =
d=0A DCN20 +=3D dcn20_dsc.o=0A =0A ifdef CONFIG_X86=0A-CFLAGS_$(AMDDALPATH)=
/dc/dcn20/dcn20_resource.o :=3D -mhard-float -msse=0A+CFLAGS_$(AMDDALPATH)/=
dc/dcn20/dcn20_resource.o :=3D $(if $(CONFIG_CC_IS_GCC), -mhard-float) -mss=
e=0A endif=0A =0A ifdef CONFIG_PPC64=0Adiff --git a/drivers/gpu/drm/amd/dis=
play/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile=0Ain=
dex bb8c95141082..347d86848bac 100644=0A--- a/drivers/gpu/drm/amd/display/d=
c/dcn21/Makefile=0A+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile=0A@@=
 -6,7 +6,7 @@ DCN21 =3D dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_reso=
urce.o \=0A 	 dcn21_hwseq.o dcn21_link_encoder.o dcn21_dccg.o=0A =0A ifdef =
CONFIG_X86=0A-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-fl=
oat -msse=0A+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D $(if $(CON=
FIG_CC_IS_GCC), -mhard-float) -msse=0A endif=0A =0A ifdef CONFIG_PPC64=0A--=
 =0A2.49.0=0A=0A
--KPhBTdCXAv1onrYE
Content-Type: application/mbox
Content-Disposition: attachment;
	filename=6.1-llvm-qunused-arguments-change.mbox
Content-Transfer-Encoding: quoted-printable

=46rom ede0c90fee40878969bd09b1eeeeec4c81fd3548 Mon Sep 17 00:00:00 2001=0A=
=46rom: Nathan Chancellor <nathan@kernel.org>=0ADate: Wed, 11 Jan 2023 20:0=
5:09 -0700=0ASubject: [PATCH 6.1 1/5] drm/amd/display: Do not add '-mhard-f=
loat' to=0A dml_ccflags for clang=0A=0Acommit 7db038d9790eda558dd6c1dde4cdd=
58b64789c47 upstream.=0A=0AWhen clang's -Qunused-arguments is dropped from =
KBUILD_CPPFLAGS, it=0Awarns:=0A=0A  clang-16: error: argument unused during=
 compilation: '-mhard-float' [-Werror,-Wunused-command-line-argument]=0A=0A=
Similar to commit 84edc2eff827 ("selftest/fpu: avoid clang warning"),=0Ajus=
t add this flag to GCC builds. Commit 0f0727d971f6 ("drm/amd/display:=0Area=
dd -msse2 to prevent Clang from emitting libcalls to undefined SW FP=0Arout=
ines") added '-msse2' to prevent clang from emitting software=0Afloating po=
int routines.=0A=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0AA=
cked-by: Alex Deucher <alexander.deucher@amd.com>=0ATested-by: Linux Kernel=
 Functional Testing <lkft@linaro.org>=0ATested-by: Anders Roxell <anders.ro=
xell@linaro.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0A=
Signed-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A drivers/gpu/d=
rm/amd/display/dc/dml/Makefile | 3 ++-=0A 1 file changed, 2 insertions(+), =
1 deletion(-)=0A=0Adiff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile=
 b/drivers/gpu/drm/amd/display/dc/dml/Makefile=0Aindex 6c7b286e1123..948e28=
648f42 100644=0A--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile=0A+++ b/d=
rivers/gpu/drm/amd/display/dc/dml/Makefile=0A@@ -26,7 +26,8 @@=0A # subcomp=
onents.=0A =0A ifdef CONFIG_X86=0A-dml_ccflags :=3D -mhard-float -msse=0A+d=
ml_ccflags-$(CONFIG_CC_IS_GCC) :=3D -mhard-float=0A+dml_ccflags :=3D $(dml_=
ccflags-y) -msse=0A endif=0A =0A ifdef CONFIG_PPC64=0A=0Abase-commit: 58485=
ff1a74f6c5be9e7c6aafb7293e4337348e7=0A-- =0A2.49.0=0A=0A=0AFrom 3bc7437c5a5=
38d6173c863172c7222cc3b513088 Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chanc=
ellor <nathan@kernel.org>=0ADate: Thu, 1 Jun 2023 11:38:24 -0700=0ASubject:=
 [PATCH 6.1 2/5] mips: Include KBUILD_CPPFLAGS in CHECKFLAGS=0A invocation=
=0A=0Acommit 08f6554ff90ef189e6b8f0303e57005bddfdd6a7 upstream.=0A=0AA futu=
re change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS to=0AKBUILD_CPPFLAGS=
 so that '--target' is available while preprocessing.=0AWhen that occurs, t=
he following error appears when building ARCH=3Dmips=0Awith clang (tip of t=
ree error shown):=0A=0A  clang: error: unsupported option '-mabi=3D' for ta=
rget 'x86_64-pc-linux-gnu'=0A=0AAdd KBUILD_CPPFLAGS in the CHECKFLAGS invoc=
ation to keep everything=0Aworking after the move.=0A=0ASigned-off-by: Nath=
an Chancellor <nathan@kernel.org>=0ASigned-off-by: Masahiro Yamada <masahir=
oy@kernel.org>=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=
=0A arch/mips/Makefile | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion=
(-)=0A=0Adiff --git a/arch/mips/Makefile b/arch/mips/Makefile=0Aindex 6468f=
1eb39f3..94080a507348 100644=0A--- a/arch/mips/Makefile=0A+++ b/arch/mips/M=
akefile=0A@@ -351,7 +351,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-t=
ables=0A KBUILD_LDFLAGS		+=3D -m $(ld-emul)=0A =0A ifdef need-compiler=0A-C=
HECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \=0A+=
CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x=
 c /dev/null | \=0A 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \=0A 	se=
d -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$/&&/g')=0A e=
ndif=0A-- =0A2.49.0=0A=0A=0AFrom e3843526e47cb379e5c8d2e8babf09ed52eb062b M=
on Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@kernel.org>=0ADat=
e: Thu, 1 Jun 2023 12:50:39 -0700=0ASubject: [PATCH 6.1 3/5] kbuild: Add CL=
ANG_FLAGS to as-instr=0A=0Acommit cff6e7f50bd315e5b39c4e46c704ac587ceb965f =
upstream.=0A=0AA future change will move CLANG_FLAGS from KBUILD_{A,C}FLAGS=
 to=0AKBUILD_CPPFLAGS so that '--target' is available while preprocessing.=
=0AWhen that occurs, the following errors appear multiple times when=0Abuil=
ding ARCH=3Dpowerpc powernv_defconfig:=0A=0A  ld.lld: error: vmlinux.a(arch=
/powerpc/kernel/head_64.o):(.text+0x12d4): relocation R_PPC64_ADDR16_HI out=
 of range: -4611686018409717520 is not in [-2147483648, 2147483647]; refere=
nces '__start___soft_mask_table'=0A  ld.lld: error: vmlinux.a(arch/powerpc/=
kernel/head_64.o):(.text+0x12e8): relocation R_PPC64_ADDR16_HI out of range=
: -4611686018409717392 is not in [-2147483648, 2147483647]; references '__s=
top___soft_mask_table'=0A=0ADiffing the .o.cmd files reveals that -DHAVE_AS=
_ATHIGH=3D1 is not present=0Aanymore, because as-instr only uses KBUILD_AFL=
AGS, which will no longer=0Acontain '--target'.=0A=0AMirror Kconfig's as-in=
str and add CLANG_FLAGS explicitly to the=0Ainvocation to ensure the target=
 information is always present.=0A=0ASigned-off-by: Nathan Chancellor <nath=
an@kernel.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Makefil=
e.compiler | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adif=
f --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler=0Aindex 875=
89a7ba27f..bf44d7422dd2 100644=0A--- a/scripts/Makefile.compiler=0A+++ b/sc=
ripts/Makefile.compiler=0A@@ -38,7 +38,7 @@ as-option =3D $(call try-run,\=
=0A # Usage: aflags-y +=3D $(call as-instr,instr,option1,option2)=0A =0A as=
-instr =3D $(call try-run,\=0A-	printf "%b\n" "$(1)" | $(CC) -Werror $(KBUI=
LD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))=0A+	printf "%b\=
n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-w=
ith-cpp -o "$$TMP" -,$(2),$(3))=0A =0A # __cc-option=0A # Usage: MY_CFLAGS =
+=3D $(call __cc-option,$(CC),$(MY_CFLAGS),-march=3Dwinchip-c6,-march=3Di58=
6)=0A-- =0A2.49.0=0A=0A=0AFrom bd5c7eb183af3620b258db8b37b35fe5877069ae Mon=
 Sep 17 00:00:00 2001=0AFrom: Masahiro Yamada <masahiroy@kernel.org>=0ADate=
: Sun, 9 Apr 2023 23:53:57 +0900=0ASubject: [PATCH 6.1 4/5] kbuild: add $(C=
LANG_FLAGS) to KBUILD_CPPFLAGS=0A=0Acommit feb843a469fb0ab00d2d23cfb9bcc379=
791011bb upstream.=0A=0AWhen preprocessing arch/*/kernel/vmlinux.lds.S, the=
 target triple is=0Anot passed to $(CPP) because we add it only to KBUILD_{=
C,A}FLAGS.=0A=0AAs a result, the linker script is preprocessed with predefi=
ned macros=0Afor the build host instead of the target.=0A=0AAssuming you us=
e an x86 build machine, compare the following:=0A=0A $ clang -dM -E -x c /d=
ev/null=0A $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu=0A=0AThe=
re is no actual problem presumably because our linker scripts do not=0Arely=
 on such predefined macros, but it is better to define correct ones.=0A=0AM=
ove $(CLANG_FLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S=0Awill=
 be processed with the proper target triple.=0A=0A[Note]=0AAfter the patch =
submission, we got an actual problem that needs this=0Acommit. (CBL issue 1=
859)=0A=0ALink: https://github.com/ClangBuiltLinux/linux/issues/1859=0ARepo=
rted-by: Tom Rini <trini@konsulko.com>=0ASigned-off-by: Masahiro Yamada <ma=
sahiroy@kernel.org>=0AReviewed-by: Nathan Chancellor <nathan@kernel.org>=0A=
Tested-by: Nathan Chancellor <nathan@kernel.org>=0ASigned-off-by: Nathan Ch=
ancellor <nathan@kernel.org>=0A---=0A scripts/Makefile.clang | 3 +--=0A 1 f=
ile changed, 1 insertion(+), 2 deletions(-)=0A=0Adiff --git a/scripts/Makef=
ile.clang b/scripts/Makefile.clang=0Aindex 87285b76adb2..49c7a01cc865 10064=
4=0A--- a/scripts/Makefile.clang=0A+++ b/scripts/Makefile.clang=0A@@ -36,6 =
+36,5 @@ endif=0A # so they can be implemented or wrapped in cc-option.=0A =
CLANG_FLAGS	+=3D -Werror=3Dunknown-warning-option=0A CLANG_FLAGS	+=3D -Werr=
or=3Dignored-optimization-argument=0A-KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)=0A-=
KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)=0A+KBUILD_CPPFLAGS	+=3D $(CLANG_FLAGS)=0A=
 export CLANG_FLAGS=0A-- =0A2.49.0=0A=0A=0AFrom ecf28b98af1725b673156b702b4=
f731246b4fd0e Mon Sep 17 00:00:00 2001=0AFrom: Nathan Chancellor <nathan@ke=
rnel.org>=0ADate: Tue, 6 Jun 2023 15:40:35 -0700=0ASubject: [PATCH 6.1 5/5]=
 kbuild: Add KBUILD_CPPFLAGS to as-option invocation=0A=0Acommit 43fc0a9990=
6e04792786edf8534d8d58d1e9de0c upstream.=0A=0AAfter commit feb843a469fb ("k=
build: add $(CLANG_FLAGS) to=0AKBUILD_CPPFLAGS"), there is an error while b=
uilding certain PowerPC=0Aassembly files with clang:=0A=0A  arch/powerpc/li=
b/copypage_power7.S: Assembler messages:=0A  arch/powerpc/lib/copypage_powe=
r7.S:34: Error: junk at end of line: `0b01000'=0A  arch/powerpc/lib/copypag=
e_power7.S:35: Error: junk at end of line: `0b01010'=0A  arch/powerpc/lib/c=
opypage_power7.S:37: Error: junk at end of line: `0b01000'=0A  arch/powerpc=
/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010'=0A  arch/p=
owerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b01010'=0A  =
clang: error: assembler command failed with exit code 1 (use -v to see invo=
cation)=0A=0Aas-option only uses KBUILD_AFLAGS, so after removing CLANG_FLA=
GS from=0AKBUILD_AFLAGS, there is no more '--target=3D' or '--prefix=3D' fl=
ags. As a=0Aresult of those missing flags, the host target=0Awill be tested=
 during as-option calls and likely fail, meaning necessary=0Aflags may not =
get added when building assembly files, resulting in=0Aerrors like seen abo=
ve.=0A=0AAdd KBUILD_CPPFLAGS to as-option invocations to clear up the error=
s.=0AThis should have been done in commit d5c8d6e0fa61 ("kbuild: Update=0Aa=
ssembler calls to use proper flags and language target"), which=0Aswitched =
=66rom using the assembler target to the assembler-with-cpp=0Atarget, so fl=
ags that affect preprocessing are passed along in all=0Arelevant tests. as-=
option now mirrors cc-option.=0A=0AFixes: feb843a469fb ("kbuild: add $(CLAN=
G_FLAGS) to KBUILD_CPPFLAGS")=0AReported-by: Linux Kernel Functional Testin=
g <lkft@linaro.org>=0ACloses: https://lore.kernel.org/CA+G9fYs=3DkoW9WardsT=
tora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com/=0ASigned-off-by: Nathan Ch=
ancellor <nathan@kernel.org>=0ATested-by: Naresh Kamboju <naresh.kamboju@li=
naro.org>=0ASigned-off-by: Masahiro Yamada <masahiroy@kernel.org>=0ASigned-=
off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A scripts/Makefile.com=
piler | 2 +-=0A 1 file changed, 1 insertion(+), 1 deletion(-)=0A=0Adiff --g=
it a/scripts/Makefile.compiler b/scripts/Makefile.compiler=0Aindex bf44d742=
2dd2..980fead7e0eb 100644=0A--- a/scripts/Makefile.compiler=0A+++ b/scripts=
/Makefile.compiler=0A@@ -32,7 +32,7 @@ try-run =3D $(shell set -e;		\=0A # =
Usage: aflags-y +=3D $(call as-option,-Wa$(comma)-isa=3Dfoo,)=0A =0A as-opt=
ion =3D $(call try-run,\=0A-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x asse=
mbler-with-cpp /dev/null -o "$$TMP",$(1),$(2))=0A+	$(CC) -Werror $(KBUILD_C=
PPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP=
",$(1),$(2))=0A =0A # as-instr=0A # Usage: aflags-y +=3D $(call as-instr,in=
str,option1,option2)=0A-- =0A2.49.0=0A=0A
--KPhBTdCXAv1onrYE--

