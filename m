Return-Path: <stable+bounces-27576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7833C87A60F
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A96282CA1
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092FA3D39F;
	Wed, 13 Mar 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Rk3GEJpx"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B031383BD
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326608; cv=none; b=PWMqGHF8vQzo5+AokTjGUoCXvlp1MiycQoD1Ek9gD7mQr8OuVA1madppS2BgvHOVhmppjs22AfgabPgR9gBn98dwYL6HrjDCtrIYwSUsYNaeXM86F3cURgXUSl7yBs/63O3iP5cUeNw7+e8lqt9an5iiSL3T77KqSKey1+8/Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326608; c=relaxed/simple;
	bh=XFp7RtxGl/sGq57NvnmgfXbkRCP/qlDk9srF8ubUiPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZe7ZFrVKG0Me/Wnq8/oClptdRDFDy33/YNn8+cSkVd25WnbI+siVO34Yyj3L+nkGMppjLDUkNSeVi5OvaNr/Lfo6d4tL4E5iXUInPGMhtZX+E7siSf3v4KuFd+lJIqSIlSoOMLQ3fahxaT4P1KsCSE016MBLRbGniQQMaPmUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Rk3GEJpx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zY6Th75NfhomTafeljfRZHRZFNkhvgTTPZ7HDw6UgI0=; b=Rk3GEJpxABVuvaEVQmhtVchBv4
	el/UviWbKUr0yro65mf0P1mtbLQEnQEm4j3GDdjqcWa+MAYB8ugC5RJUC0ygjcV9BR1OuhBrWvIfD
	xTOAK9ewUPijCFHk1nm0qSPrYzcQFSNM7AeK380uP9xlivisYAHxA+k4P29jnBXDRMSLeoKv+GqC9
	mxvWq+t36x+R05xWS46r/fR4V0A1imm+qoV+j6vwtTQw196UmOv67e/RH4DghZUeN77us3KH+BLv8
	EXiBxF4iHrgLj0TnTWBvpXZgJrqfx8WaEBkA8eD/lPAPOiP4Mu+QyoDYJVgpXIUunmik4e9l+wiD+
	EzZDU1BQ==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkM4w-009uZG-6z; Wed, 13 Mar 2024 11:43:22 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 1/5] arch: Introduce CONFIG_FUNCTION_ALIGNMENT
Date: Wed, 13 Mar 2024 07:42:51 -0300
Message-Id: <20240313104255.1083365-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313104255.1083365-1-cascardo@igalia.com>
References: <20240313104255.1083365-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

commit d49a0626216b95cd4bf696f6acf55f39a16ab0bb upstream.

Generic function-alignment infrastructure.

Architectures can select FUNCTION_ALIGNMENT_xxB symbols; the
FUNCTION_ALIGNMENT symbol is then set to the largest such selected
size, 0 otherwise.

From this the -falign-functions compiler argument and __ALIGN macro
are set.

This incorporates the DEBUG_FORCE_FUNCTION_ALIGN_64B knob and future
alignment requirements for x86_64 (later in this series) into a single
place.

NOTE: also removes the 0x90 filler byte from the generic __ALIGN
      primitive, that value makes no sense outside of x86.

NOTE: .balign 0 reverts to a no-op.

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Change-Id: I053b3c408d56988381feb8c8bdb5e27ea221755f
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.719248727@infradead.org
[cascardo: adjust context at arch/x86/Kconfig]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 Makefile                           |  4 ++--
 arch/Kconfig                       | 24 ++++++++++++++++++++++++
 arch/ia64/Kconfig                  |  1 +
 arch/ia64/Makefile                 |  2 +-
 arch/x86/Kconfig                   |  2 ++
 arch/x86/boot/compressed/head_64.S |  8 ++++++++
 arch/x86/include/asm/linkage.h     |  4 +---
 include/asm-generic/vmlinux.lds.h  |  4 ++--
 include/linux/linkage.h            |  4 ++--
 lib/Kconfig.debug                  |  1 +
 10 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index bb73dba0e505..16f3838838d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,8 +1000,8 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
-ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
-KBUILD_CFLAGS += -falign-functions=64
+ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
diff --git a/arch/Kconfig b/arch/Kconfig
index 2e2dc0975ab4..a541ce263865 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1303,4 +1303,28 @@ source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
+config FUNCTION_ALIGNMENT_4B
+	bool
+
+config FUNCTION_ALIGNMENT_8B
+	bool
+
+config FUNCTION_ALIGNMENT_16B
+	bool
+
+config FUNCTION_ALIGNMENT_32B
+	bool
+
+config FUNCTION_ALIGNMENT_64B
+	bool
+
+config FUNCTION_ALIGNMENT
+	int
+	default 64 if FUNCTION_ALIGNMENT_64B
+	default 32 if FUNCTION_ALIGNMENT_32B
+	default 16 if FUNCTION_ALIGNMENT_16B
+	default 8 if FUNCTION_ALIGNMENT_8B
+	default 4 if FUNCTION_ALIGNMENT_4B
+	default 0
+
 endmenu
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 89869aff8ca2..8902d1517894 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -63,6 +63,7 @@ config IA64
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select SET_FS
 	select ZONE_DMA32
+	select FUNCTION_ALIGNMENT_32B
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 7e548c654a29..43cde968da88 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -23,7 +23,7 @@ KBUILD_AFLAGS_KERNEL := -mconstant-gp
 EXTRA		:=
 
 cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -mfixed-range=f12-f15,f32-f127 \
-		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
+		   -frename-registers -fno-optimize-sibling-calls
 KBUILD_CFLAGS_KERNEL := -mconstant-gp
 
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cfb1edd25437..65b2cff3c93b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -267,6 +267,8 @@ config X86
 	select HAVE_ARCH_KCSAN			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
+	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c3d427c817c7..e189a16ae40a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -37,6 +37,14 @@
 #include <asm/trapnr.h>
 #include "pgtable.h"
 
+/*
+ * Fix alignment at 16 bytes. Following CONFIG_FUNCTION_ALIGNMENT will result
+ * in assembly errors due to trying to move .org backward due to the excessive
+ * alignment.
+ */
+#undef __ALIGN
+#define __ALIGN		.balign	16, 0x90
+
 /*
  * Locally defined symbols should be marked hidden:
  */
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 5000cf59bdf5..3d7293d52950 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,10 +13,8 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
-#endif
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8471717c5085..dd9ea351bc02 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -81,8 +81,8 @@
 #define RO_EXCEPTION_TABLE
 #endif
 
-/* Align . to a 8 byte boundary equals to maximum function alignment. */
-#define ALIGN_FUNCTION()  . = ALIGN(8)
+/* Align . function alignment. */
+#define ALIGN_FUNCTION()  . = ALIGN(CONFIG_FUNCTION_ALIGNMENT)
 
 /*
  * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..fc81e51330b2 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -69,8 +69,8 @@
 #endif
 
 #ifndef __ALIGN
-#define __ALIGN		.align 4,0x90
-#define __ALIGN_STR	".align 4,0x90"
+#define __ALIGN			.balign CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
 #ifdef __ASSEMBLY__
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64d6292cf686..28faea9b5da6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -424,6 +424,7 @@ config SECTION_MISMATCH_WARN_ONLY
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned"
 	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
+	select FUNCTION_ALIGNMENT_64B
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
-- 
2.34.1


