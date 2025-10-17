Return-Path: <stable+bounces-187665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB59BEAD4C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20905859C1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32629D280;
	Fri, 17 Oct 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWwVLuqX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B32258ECF;
	Fri, 17 Oct 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718259; cv=none; b=d7BoBik1hvs8npnGcYyT/X1IAXBiMwN5IJsgPBfZVnL3e95W/jivybfXNhPJHl910YK5HyX2G1f+wQIDH2Zuktx3k6jZZr7dz8plWSY50mT2gjyMlQVwLp7CPHLy1Xg1v3vZek/AA3ABChjtY/NZbULJ94PwKGJbZGGmYJId1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718259; c=relaxed/simple;
	bh=FxvTbdVj+Xc9M5Quj9RApL3wcxBNyj+xn6OtKDDwpMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlY5KyqVubvcccA4hp8PvxX4YAUabwa0prKuCo0/zrosafOMqfgbC4s1+rIZ63Yy79DXsWBn3eUm/mD1+0a9VJYd0BzLj22mhla288PQwKnhSg5gQMiJsMgUQpu1aeAXSaVhJaYkdY6T5uKy0TOSZCH0hlIajEItB40IzWME4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWwVLuqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88158C4CEE7;
	Fri, 17 Oct 2025 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718259;
	bh=FxvTbdVj+Xc9M5Quj9RApL3wcxBNyj+xn6OtKDDwpMI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MWwVLuqXcl5OGyovfss2av1vl9fd13QOjmeM7jfyFNtgTm1rmXc2gHVyalqNN7SpO
	 h0Bd+IVmAcK3MK882pa+GU1LiAJfAgq5zQE3R58UDTIwnj0a/swN3zR2mdwyHsVo/d
	 ypL3gSx0STpn15+NxLBVWPSjnCE6k7H8cPerEvj3hh4YAixLdAfLGovcOCPdcz/dTg
	 xD5eCFkRLGZzTo2tv4Bbtw1tHU0skTcCPr3/gNIzjE0t2f/E621IN6DtDN/03pYatm
	 KIPS3yRRKjRoAiZvQI9v/yAaZQJhBOkfOTDSo3yPst+yMSeOF4oQxNVIpQ9uUkzJoS
	 5xgu2O0/rMrjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:24:01 +0200
Subject: [PATCH 5.15.y 2/3] arch: back to -std=gnu89 in < v5.18
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-15-gcc-15-v1-2-da6c065049d7@kernel.org>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
In-Reply-To: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FxvTbdVj+Xc9M5Quj9RApL3wcxBNyj+xn6OtKDDwpMI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+5a78sygj+unSZQvqFma0a87nsL8qwWdyu3DZ7f/Rv
 etkAw+86yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIaSGG/yFvN4U6i7gyavyb
 9C2p9+Rxxm+RJ2reevN/OxT9inP+jnBGhgm7z1ee2byzu17pj6AIyw6L57cnCzRNfqsfc2PyvO+
 H0jkB
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
index 839a13a59f53..3eba999a2eb7 100644
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
index c8071eb82e2e..40265863ed36 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -23,7 +23,7 @@ endif
 aflags_dwarf	:= -Wa,-gdwarf-2
 KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
-KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu11
+KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -std=gnu89
 KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 677cbb654024..414ba87e038b 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -21,7 +21,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 KCSAN_SANITIZE := n
 
-KBUILD_CFLAGS := -std=gnu11 -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS := -std=gnu89 -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d5ee0b920dc0..16267e85c5ad 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,7 +24,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu89 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f82b2cb24360..f54fa1579dcd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -33,7 +33,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
-KBUILD_CFLAGS += -std=gnu11
+KBUILD_CFLAGS += -std=gnu89
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index f1a4f0154540..1195c9fb84de 100644
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


