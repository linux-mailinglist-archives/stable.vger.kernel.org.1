Return-Path: <stable+bounces-59738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A3932B83
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EDA1C23231
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0C17C9E9;
	Tue, 16 Jul 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgB7JEFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE927733;
	Tue, 16 Jul 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144760; cv=none; b=bGiXO3qgdIKjNE5IA7Yv3WBo3TvWh9UY4VbDTOQ3dnD2q7x+Qc6xRLSepGis+v4tNWboiPdH2FV1UsqjUc8CQobVyqcle08JONaXdL+278q7Q2sjuN9YQdOmZ9geCZfYwr4piWrVA8NWECs2ljYmDRe9wkl9C2LAVx4O8vIoHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144760; c=relaxed/simple;
	bh=h+cYKHsJTvKDol8dN6YF53ZYzak+Bw4zZpDud52tnW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2os/d3wshxxMHoxCJ1mIZiZSsocIlKKxcqTfJ4JT1Q89oVuciuEMIj//9vjmVy+dU7Rge5BMNzTmocizcYmNL9AUVSMFcILMcrVcxi/uB6hV5pj+5riswLj1M7dVbDFsVc8rZPVXgrsIxQW/4FsjevQPhXkh2po57T1AeSNxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgB7JEFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C7C4AF0B;
	Tue, 16 Jul 2024 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144759;
	bh=h+cYKHsJTvKDol8dN6YF53ZYzak+Bw4zZpDud52tnW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgB7JEFBP5fwH2Y2LH3944QHCfVr7BEX/vFRHrs8CB7AtnB6JHEd9cgqSibi+qAww
	 Q7rAG7qBf31hvyM3VDBaQG/oFyJbgRCxQ9rh1K9TH/xMJ23f+1aMNsQxVBOS/Ugbnm
	 Jaa7P+4SAxNWezF1GspPpYN0/nSK+6S7mWdPMV+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frank Scheiner <frank.scheiner@web.de>
Subject: [PATCH 5.10 095/108] efi: ia64: move IA64-only declarations to new asm/efi.h header
Date: Tue, 16 Jul 2024 17:31:50 +0200
Message-ID: <20240716152749.637909264@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit 8ff059b8531f3b98e14f0461859fc7cdd95823e4 upstream.

Move some EFI related declarations that are only referenced on IA64 to
a new asm/efi.h arch header.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Frank Scheiner <frank.scheiner@web.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/include/asm/efi.h      |   13 +++++++++++++
 arch/ia64/kernel/efi.c           |    1 +
 arch/ia64/kernel/machine_kexec.c |    1 +
 arch/ia64/kernel/mca.c           |    1 +
 arch/ia64/kernel/smpboot.c       |    1 +
 arch/ia64/kernel/time.c          |    1 +
 arch/ia64/kernel/uncached.c      |    4 +---
 arch/ia64/mm/contig.c            |    1 +
 arch/ia64/mm/discontig.c         |    1 +
 arch/ia64/mm/init.c              |    1 +
 include/linux/efi.h              |    6 ------
 11 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 arch/ia64/include/asm/efi.h

--- /dev/null
+++ b/arch/ia64/include/asm/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
+
+void *efi_get_pal_addr(void);
+void efi_map_pal_code(void);
+void efi_memmap_walk(efi_freemem_callback_t, void *);
+void efi_memmap_walk_uc(efi_freemem_callback_t, void *);
+void efi_gettimeofday(struct timespec64 *ts);
+
+#endif
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -34,6 +34,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/kregs.h>
 #include <asm/meminit.h>
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -16,6 +16,7 @@
 #include <linux/numa.h>
 #include <linux/mmzone.h>
 
+#include <asm/efi.h>
 #include <asm/numa.h>
 #include <asm/mmu_context.h>
 #include <asm/setup.h>
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -91,6 +91,7 @@
 #include <linux/gfp.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -45,6 +45,7 @@
 #include <asm/cache.h>
 #include <asm/current.h>
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mca.h>
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -26,6 +26,7 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/hw_irq.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -20,14 +20,12 @@
 #include <linux/genalloc.h>
 #include <linux/gfp.h>
 #include <linux/pgtable.h>
+#include <asm/efi.h>
 #include <asm/page.h>
 #include <asm/pal.h>
 #include <linux/atomic.h>
 #include <asm/tlbflush.h>
 
-
-extern void __init efi_memmap_walk_uc(efi_freemem_callback_t, void *);
-
 struct uncached_pool {
 	struct gen_pool *pool;
 	struct mutex add_chunk_mutex;	/* serialize adding a converted chunk */
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -20,6 +20,7 @@
 #include <linux/nmi.h>
 #include <linux/swap.h>
 
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -24,6 +24,7 @@
 #include <linux/efi.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
+#include <asm/efi.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -27,6 +27,7 @@
 #include <linux/swiotlb.h>
 
 #include <asm/dma.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/patch.h>
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -171,8 +171,6 @@ int efi_capsule_setup_info(struct capsul
                            size_t hdr_bytes);
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
-typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
-
 /*
  * Types and defines for Time Services
  */
@@ -609,10 +607,6 @@ efi_guid_to_str(efi_guid_t *guid, char *
 }
 
 extern void efi_init (void);
-extern void *efi_get_pal_addr (void);
-extern void efi_map_pal_code (void);
-extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
-extern void efi_gettimeofday (struct timespec64 *ts);
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else



