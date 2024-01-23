Return-Path: <stable+bounces-14573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AC838173
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5906A286109
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A21420DD;
	Tue, 23 Jan 2024 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMpgpq4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDC7F4;
	Tue, 23 Jan 2024 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972138; cv=none; b=cV/LOZEbBHvolXYngCPlh8RfIX0BXJoKQCBD9fTNojRbYx3a+sYypNQjbY5HLPqNcIbR6mMGYhPOASteGV9fcNsR4RW32WSkcNstJZ9ay1MkA6I+0oNx8s3xoWWJ1CHyFykzEjDdmI9QO2s4EdnhIzeHxiMI6TEnU7LJtcycD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972138; c=relaxed/simple;
	bh=1bHV/rnTE+n6arVxuanytWXKJVqqJMgwsztHT6lIi3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuHEuhRp6jAztq7W8HHvCq7amb/aYER7pVTMK3zA+OHy719CdiU/KEABWJq4f7295FV8NXLggPpaDeZSC8mVHu+a5oadCM0Ke2+NYmsTdEk2+qaIjUKmo1XkvHvPTrtFY8+HV1t8puOGA3om5DIJeVVtPqQ9c/hMenrNsZrZpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMpgpq4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC0C433C7;
	Tue, 23 Jan 2024 01:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972138;
	bh=1bHV/rnTE+n6arVxuanytWXKJVqqJMgwsztHT6lIi3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMpgpq4QnUpXE9+8pxoqWwFQGd5J1ZdUyBMfnihAm2R579fP2vO33RYyKxFraYIkv
	 1657g63wIXDpWRrEoBk5nY05cqT1bOoiNt2MWoPx1HwmYMvWh202mIvc6DGbSbUAhC
	 l0kPF8YWK5oIvs2CVXjSYHOi4K6RpxRn9bF9LLQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Modra <amodra@au1.ibm.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 068/374] powerpc/toc: Future proof kernel toc
Date: Mon, 22 Jan 2024 15:55:24 -0800
Message-ID: <20240122235746.980007102@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Modra <amodra@au1.ibm.com>

[ Upstream commit a3ad84da076009c94969fa97f604257667e2980f ]

This patch future-proofs the kernel against linker changes that might
put the toc pointer at some location other than .got+0x8000, by
replacing __toc_start+0x8000 with .TOC. throughout.  If the kernel's
idea of the toc pointer doesn't agree with the linker, bad things
happen.

prom_init.c code relocating its toc is also changed so that a symbolic
__prom_init_toc_start toc-pointer relative address is calculated
rather than assuming that it is always at toc-pointer - 0x8000.  The
length calculations loading values from the toc are also avoided.
It's a little incestuous to do that with unreloc_toc picking up
adjusted values (which is fine in practice, they both adjust by the
same amount if all goes well).

I've also changed the way .got is aligned in vmlinux.lds and
zImage.lds, mostly so that dumping out section info by objdump or
readelf plainly shows the alignment is 256.  This linker script
feature was added 2005-09-27, available in FSF binutils releases from
2.17 onwards.  Should be safe to use in the kernel, I think.

Finally, put *(.got) before the prom_init.o entry which only needs
*(.toc), so that the GOT header goes in the correct place.  I don't
believe this makes any difference for the kernel as it would for
dynamic objects being loaded by ld.so.  That change is just to stop
lusers who blindly copy kernel scripts being led astray.  Of course,
this change needs the prom_init.c changes.

Some notes on .toc and .got.

.toc is a compiler generated section of addresses.  .got is a linker
generated section of addresses, generally built when the linker sees
R_*_*GOT* relocations.  In the case of powerpc64 ld.bfd, there are
multiple generated .got sections, one per input object file.  So you
can somewhat reasonably write in a linker script an input section
statement like *prom_init.o(.got .toc) to mean "the .got and .toc
section for files matching *prom_init.o".  On other architectures that
doesn't make sense, because the linker generally has just one .got
section.  Even on powerpc64, note well that the GOT entries for
prom_init.o may be merged with GOT entries from other objects.  That
means that if prom_init.o references, say, _end via some GOT
relocation, and some other object also references _end via a GOT
relocation, the GOT entry for _end may be in the range
__prom_init_toc_start to __prom_init_toc_end and if the kernel does
something special to GOT/TOC entries in that range then the value of
_end as seen by objects other than prom_init.o will be affected.  On
the other hand the GOT entry for _end may not be in the range
__prom_init_toc_start to __prom_init_toc_end.  Which way it turns out
is deterministic but a detail of linker operation that should not be
relied on.

A feature of ld.bfd is that input .toc (and .got) sections matching
one linker input section statement may be sorted, to put entries used
by small-model code first, near the toc base.  This is why scripts for
powerpc64 normally use *(.got .toc) rather than *(.got) *(.toc), since
the first form allows more freedom to sort.

Another feature of ld.bfd is that indirect addressing sequences using
the GOT/TOC may be edited by the linker to relative addressing.  In
many cases relative addressing would be emitted by gcc for
-mcmodel=medium if you appropriately decorate variable declarations
with non-default visibility.

The original patch is here:
https://lore.kernel.org/linuxppc-dev/20210310034813.GM6042@bubble.grove.modra.org/

Signed-off-by: Alan Modra <amodra@au1.ibm.com>
[aik: removed non-relocatable which is gone in 24d33ac5b8ffb]
[aik: added <=2.24 check]
[aik: because of llvm-as, kernel_toc_addr() uses "mr" instead of global register variable]
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20211221055904.555763-2-aik@ozlabs.ru
Stable-dep-of: 1b1e38002648 ("powerpc: add crtsavres.o to always-y instead of extra-y")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile               |  5 +++--
 arch/powerpc/boot/crt0.S            |  2 +-
 arch/powerpc/boot/zImage.lds.S      |  7 ++-----
 arch/powerpc/include/asm/sections.h | 16 ++++++++--------
 arch/powerpc/kernel/head_64.S       |  2 +-
 arch/powerpc/kernel/vmlinux.lds.S   |  8 +++-----
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3dc75040a756..41604a37b385 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -437,10 +437,11 @@ PHONY += checkbin
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
 checkbin:
-	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" = "xy" \
-	    && $(LD) --version | head -1 | grep ' 2\.24$$' >/dev/null ; then \
+	@if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
+		"x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
 		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
 		echo 'in some circumstances.' ; \
+		echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index e8f10a599659..feadee18e271 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -28,7 +28,7 @@ p_etext:	.8byte	_etext
 p_bss_start:	.8byte	__bss_start
 p_end:		.8byte	_end
 
-p_toc:		.8byte	__toc_start + 0x8000 - p_base
+p_toc:		.8byte	.TOC. - p_base
 p_dyn:		.8byte	__dynamic_start - p_base
 p_rela:		.8byte	__rela_dyn_start - p_base
 p_prom:		.8byte	0
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index d6f072865627..d65cd55a6f38 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -36,12 +36,9 @@ SECTIONS
   }
 
 #ifdef CONFIG_PPC64_BOOT_WRAPPER
-  . = ALIGN(256);
-  .got :
+  .got : ALIGN(256)
   {
-    __toc_start = .;
-    *(.got)
-    *(.toc)
+    *(.got .toc)
   }
 #endif
 
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index e92d39c0cd1d..34d82ae1774c 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -26,16 +26,16 @@ extern char start_virt_trampolines[];
 extern char end_virt_trampolines[];
 #endif
 
+/*
+ * This assumes the kernel is never compiled -mcmodel=small or
+ * the total .toc is always less than 64k.
+ */
 static inline unsigned long kernel_toc_addr(void)
 {
-	/* Defined by the linker, see vmlinux.lds.S */
-	extern unsigned long __toc_start;
-
-	/*
-	 * The TOC register (r2) points 32kB into the TOC, so that 64kB of
-	 * the TOC can be addressed using a single machine instruction.
-	 */
-	return (unsigned long)(&__toc_start) + 0x8000UL;
+	unsigned long toc_ptr;
+
+	asm volatile("mr %0, 2" : "=r" (toc_ptr));
+	return toc_ptr;
 }
 
 static inline int overlaps_interrupt_vector_text(unsigned long start,
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f17ae2083733..a08c050ff645 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -904,7 +904,7 @@ _GLOBAL(relative_toc)
 	blr
 
 .balign 8
-p_toc:	.8byte	__toc_start + 0x8000 - 0b
+p_toc:	.8byte	.TOC. - 0b
 
 /*
  * This is where the main kernel code starts.
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index d8301ce7c675..70bf67ed87b5 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -352,15 +352,13 @@ SECTIONS
 		*(.branch_lt)
 	}
 
-	. = ALIGN(256);
-	.got : AT(ADDR(.got) - LOAD_OFFSET) {
-		__toc_start = .;
+	.got : AT(ADDR(.got) - LOAD_OFFSET) ALIGN(256) {
+		*(.got)
 #ifndef CONFIG_RELOCATABLE
 		__prom_init_toc_start = .;
-		arch/powerpc/kernel/prom_init.o*(.toc .got)
+		arch/powerpc/kernel/prom_init.o*(.toc)
 		__prom_init_toc_end = .;
 #endif
-		*(.got)
 		*(.toc)
 	}
 #endif
-- 
2.43.0




