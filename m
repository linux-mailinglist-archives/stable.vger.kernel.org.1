Return-Path: <stable+bounces-187674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349EBEAF39
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC926E7CB2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E082EB86A;
	Fri, 17 Oct 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3rjlwc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F92EB5BF;
	Fri, 17 Oct 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720033; cv=none; b=YsNV99AdiS6Oolm2udCOLnRGjSmXv74Hpxm8xz6k+21BI4N4wskHa5wK/J4aMXc6lG3aS0P6FD+KCWVQL3rRCGusBG2HxWzO3k8lS0LKKmg8nNEMqiOfOwN80OifwAE6YFgcOQjljKdpolTVf2aJmoogRyjVjaVCyDeAm8hdb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720033; c=relaxed/simple;
	bh=xrkeJwXM+i8qR4svwajAcLC0hPsg40Cv44lw5sc9AZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oF2Af2OFqc2oYzGiCnEBuKZT0ey4gXwvr21j/TVmtKUE2529mZRTkraHAwUwZNjJQvXhVDK8Of1/B3s1FAnNpn2SpB2kjyTDba97byc6OxUvdjh0S74hf55OTqs6CVUFNGfSHzUb6EhIWM+6uAG/T3IqeTtNGSTjj+NDpuZhiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3rjlwc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CC1C4CEE7;
	Fri, 17 Oct 2025 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720033;
	bh=xrkeJwXM+i8qR4svwajAcLC0hPsg40Cv44lw5sc9AZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n3rjlwc7lvIUVWHU6e8XGCl07SUtnBvQJfGI1luxMfLtNVUOiinNu5BCn1eXJh8rZ
	 FPmzsEye3/LHZA9pUDurcN6rSbUM9dMfdfUqPdvCiW/XRS8+mtHY3Q3dObyWFtrumw
	 zS+d0+yevcoSpnyyVfspPFJSz3iPhlws75d1CueXz+lsDX/JoCJ52XXqqHPMOyjssw
	 CZXj2C9JCGHDM+Uzgun+2EYEIxFY44xXdXXBKAfvUWzt8HwzvN5KJUl5eX07K4HKBb
	 J14lhc4QMBHVFRAKlmYsm/ADsc14atKvuwo9qeUkV4GnAOay1JAmwnDE/jrKMpDt54
	 OXVqJlyfFlmFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:53:26 +0200
Subject: [PATCH 5.10.y 2/3] arch: back to -std=gnu89 in < v5.18
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-10-gcc-15-v1-2-cdbbfe1a2100@kernel.org>
References: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
In-Reply-To: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xrkeJwXM+i8qR4svwajAcLC0hPsg40Cv44lw5sc9AZM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+lczYwJnhffG91vRAfonulisemuWxc/zKBAoEqrrPJ
 ZaKlrzqKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEi0FCPDhYjJ/fcO3SmaGmL9
 W/TVgZ8ntn4/6d+f5B5brHP3z87eZYwMDf42F75qGJ6QfNe+7+vN5HU/rzxXN0ndZLvy+b1qi46
 fPAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recent fixes have been backported to < v5.18 to fix build issues with
GCC 5.15. They all force -std=gnu11 in the CFLAGS, "because [the kernel]
requests the gnu11 standard via '-std=' in the main Makefile".

This is true for >= 5.18 versions, but not before. This switch to
-std=gnu11 has been done in commit e8c07082a810 ("Kbuild: move to
-std=gnu11").

For a question of uniformity, force -std=gnu89, similar to what is done
in the main Makefile.

Note: the fixes tags below refers to upstream commits, but this fix is
only for kernels not having commit e8c07082a810 ("Kbuild: move to
-std=gnu11").

Fixes: 7cbb015e2d3d ("parisc: fix building with gcc-15")
Fixes: 3b8b80e99376 ("s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS")
Fixes: b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")
Fixes: ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
Fixes: 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note:
  An alternative is to backport commit e8c07082a810 ("Kbuild: move to
  -std=gnu11"), but I guess we might not want to do that for stable, as
  it might introduce new warnings.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/s390/Makefile                    | 2 +-
 arch/s390/purgatory/Makefile          | 2 +-
 arch/x86/Makefile                     | 2 +-
 arch/x86/boot/compressed/Makefile     | 2 +-
 drivers/firmware/efi/libstub/Makefile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 4e5aecc263a2..f2efd55a0c81 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -22,7 +22,7 @@ KBUILD_CFLAGS += -fno-PIE -mno-space-regs -mdisable-fpregs -Os
 ifndef CONFIG_64BIT
 KBUILD_CFLAGS += -mfast-indirect-calls
 endif
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu89
 
 OBJECTS += $(obj)/head.o $(obj)/real2.o $(obj)/firmware.o $(obj)/misc.o $(obj)/piggy.o
 
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 92f2426d8797..9680c6c9a710 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu89
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 955f113cf320..e03f234fcfbe 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -20,7 +20,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu89 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f584d07095f1..9c08f2cd399f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,7 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu89 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e1a750baf036..6dd03543235a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -33,7 +33,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu89
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d7bcfe0d50d1..d719134e2d3a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -7,7 +7,7 @@
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu89 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \

-- 
2.51.0


