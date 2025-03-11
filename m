Return-Path: <stable+bounces-123198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2AA5BF8D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B16176791
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE11DE8A0;
	Tue, 11 Mar 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3TVOZK3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52F1E51FA;
	Tue, 11 Mar 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693548; cv=none; b=RAham3T9a4e8TMyIzb/L+/GCgat3LlMeQWFLHJNAF15v6IeHFCWlCcQcZcoM1a1ACpgibSfE4fYS792lTcwNzBOL1IFs+i2XAbZ/+2VfM86OF046kb7PHlmf5wZ2oHuz4ByoqRZiDNA5/+ZvFnEA71VIvsIQbB5IOM0NQ/ts2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693548; c=relaxed/simple;
	bh=dU6hjB1PF+o+lnasPqtnq1GrqOJwBEzsDu8qkMojrOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDNTAQSzSzDS9EvkqrT7BfyoPu2VWLLSmjCGSKW4Zocu16YPJhIhywmjzHW/xeg2HxsKdjAicgNsle6nvG/L7N2gq5rBAG4B7CxX2te3k7WtTl91p02jiy3X0T5gdgeZnv6az+zzK3aqq0Nbk62t6ZCKsMDqk3dJ4TLHFnd2EvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3TVOZK3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741693546; x=1773229546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dU6hjB1PF+o+lnasPqtnq1GrqOJwBEzsDu8qkMojrOI=;
  b=Y3TVOZK3iJah6O9iikifWUYezg8/aEfzemHHKMzI2zRfwyZ3m3yv4AEM
   EJEjoHSfgZGLt8e+kT0a5/frQTLqkwneKbRS18KH1rIwNj8gpB7bDThK+
   pY28zoEUD54DUlASg6n08X+w9JqcQlXISj38VXi34MHg4gj3z9uZrCXg9
   kVxKtfjgrgEV8K2U4LqiwC9ryWLQcovxzNzJsV6fDol7rJXqMX+tqBvgN
   zW6l17dRzRVXL0N3mYg/s9MqyC7Ig/+gehWBPP542tuMKHL400+mLXkxX
   NbGSC8rVZvKzJTiZqoXfCB3Cv5dUnss5VE/f70sy/co/AkJ01FeN6sMJL
   Q==;
X-CSE-ConnectionGUID: /48xe8wUSeqAMlnTK3KyJQ==
X-CSE-MsgGUID: fGuwK/ICSvy+ZbNqDnPCGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53352955"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="53352955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 04:45:46 -0700
X-CSE-ConnectionGUID: aH7hx+SAS+ilfAeEoxdU/w==
X-CSE-MsgGUID: 9cx4Rm2OQ6WLVcbz74gkwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120255888"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO rapter.intel.com) ([10.245.246.169])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 04:45:41 -0700
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To: linux-kernel@vger.kernel.org
Cc: osalvador@suse.de,
	42.hyeyoo@gmail.com,
	byungchul@sk.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	max.byungchul.park@sk.com,
	max.byungchul.park@gmail.com
Subject: [PATCH] mm: introduce include/linux/pgalloc.h
Date: Tue, 11 Mar 2025 13:44:20 +0200
Message-ID: <20250311114420.240341-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include/linux/pgalloc.h is going to be the home of generic page table
population functions. Start with including asm/pgalloc.h to
include/linux/pgalloc.h and adding functions that if an architecture needs
to synchronize global pgds when populating the init_mm's pgd.

The newly introduced p4d_populate_kernel() and pgd_populate_kernel()
functions synchronize global pgds after populating init_mm's p4d/pgd.

If the architecture requires to synchronize global pgds,
add ARCH_USE_SYNC_GLOBAL_PGDS to the Kconfig of the required architecture
and implement arch_sync_global_p4ds() and arch_sync_global_pgds() to the
architecture.
And this patch adds an implementation to the x86 architecture.

Through using new introduced p4d_populate_kernel() and
pgd_populate_kernel() functions, it addresses an Oops issues when
performing test of loading XE GPU driver module after applying the GPU SVM
and Xe SVM patch series[1] and the Dept patch series[2].

The issue occurs when loading the xe driver via modprobe [3], which adds
a struct page for device memory via devm_memremap_pages().
When a process leads the addition of a struct page to vmemmap
(e.g. hot-plug), the page table update for the newly added vmemmap-based
virtual address is updated first in init_mm's page table and then
synchronized later.
If the vmemmap-based virtual address is accessed through the process's
page table before this sync, a page fault will occur.
This addresses the issue by synchronizing with the global pgds immediately
after populating the init_mm's pgd.

[1] https://lore.kernel.org/dri-devel/20250213021112.1228481-1-matthew.brost@intel.com/
[2] https://lore.kernel.org/lkml/20240508094726.35754-1-byungchul@sk.com/
[3]
[   49.103630] xe 0000:00:04.0: [drm] Available VRAM: 0x0000000800000000, 0x00000002fb800000
[   49.116710] BUG: unable to handle page fault for address: ffffeb3ff1200000
[   49.117175] #PF: supervisor write access in kernel mode
[   49.117511] #PF: error_code(0x0002) - not-present page
[   49.117835] PGD 0 P4D 0
[   49.118015] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[   49.118366] CPU: 3 UID: 0 PID: 302 Comm: modprobe Tainted: G        W          6.13.0-drm-tip-test+ #62
[   49.118976] Tainted: [W]=WARN
[   49.119179] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   49.119710] RIP: 0010:vmemmap_set_pmd+0xff/0x230
[   49.120011] Code: 77 22 02 a9 ff ff 1f 00 74 58 48 8b 3d 62 77 22 02 48 85 ff 0f 85 9a 00 00 00 48 8d 7d 08 48 89 e9 31 c0 48 89 ea 48 83 e7 f8 <48> c7 45 00 00 00 00 00 48 29 f9 48 c7 45 48 00 00 00 00 83 c1 50
[   49.121158] RSP: 0018:ffffc900016d37a8 EFLAGS: 00010282
[   49.121502] RAX: 0000000000000000 RBX: ffff888164000000 RCX: ffffeb3ff1200000
[   49.121966] RDX: ffffeb3ff1200000 RSI: 80000000000001e3 RDI: ffffeb3ff1200008
[   49.122499] RBP: ffffeb3ff1200000 R08: ffffeb3ff1280000 R09: 0000000000000000
[   49.123032] R10: ffff88817b94dc48 R11: 0000000000000003 R12: ffffeb3ff1280000
[   49.123566] R13: 0000000000000000 R14: ffff88817b94dc48 R15: 8000000163e001e3
[   49.124096] FS:  00007f53ae71d740(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
[   49.124698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.125129] CR2: ffffeb3ff1200000 CR3: 000000017c7d2000 CR4: 0000000000750ef0
[   49.125662] PKRU: 55555554
[   49.125880] Call Trace:
[   49.126078]  <TASK>
[   49.126252]  ? __die_body.cold+0x19/0x26
[   49.126509]  ? page_fault_oops+0xa2/0x240
[   49.126736]  ? preempt_count_add+0x47/0xa0
[   49.126968]  ? search_module_extables+0x4a/0x80
[   49.127224]  ? exc_page_fault+0x206/0x230
[   49.127454]  ? asm_exc_page_fault+0x22/0x30
[   49.127691]  ? vmemmap_set_pmd+0xff/0x230
[   49.127919]  vmemmap_populate_hugepages+0x176/0x180
[   49.128194]  vmemmap_populate+0x34/0x80
[   49.128416]  __populate_section_memmap+0x41/0x90
[   49.128676]  sparse_add_section+0x121/0x3e0
[   49.128914]  __add_pages+0xba/0x150
[   49.129116]  add_pages+0x1d/0x70
[   49.129305]  memremap_pages+0x3dc/0x810
[   49.129529]  devm_memremap_pages+0x1c/0x60
[   49.129762]  xe_devm_add+0x8b/0x100 [xe]
[   49.130072]  xe_tile_init_noalloc+0x6a/0x70 [xe]
[   49.130408]  xe_device_probe+0x48c/0x740 [xe]
[   49.130714]  ? __pfx___drmm_mutex_release+0x10/0x10
[   49.130982]  ? __drmm_add_action+0x85/0xd0
[   49.131208]  ? __pfx___drmm_mutex_release+0x10/0x10
[   49.131478]  xe_pci_probe+0x7ef/0xd90 [xe]
[   49.131777]  ? _raw_spin_unlock_irqrestore+0x66/0x90
[   49.132049]  ? lockdep_hardirqs_on+0xba/0x140
[   49.132290]  pci_device_probe+0x99/0x110
[   49.132510]  really_probe+0xdb/0x340
[   49.132710]  ? pm_runtime_barrier+0x50/0x90
[   49.132941]  ? __pfx___driver_attach+0x10/0x10
[   49.133190]  __driver_probe_device+0x78/0x110
[   49.133433]  driver_probe_device+0x1f/0xa0
[   49.133661]  __driver_attach+0xba/0x1c0
[   49.133874]  bus_for_each_dev+0x7a/0xd0
[   49.134089]  bus_add_driver+0x114/0x200
[   49.134302]  driver_register+0x6e/0xc0
[   49.134515]  xe_init+0x1e/0x50 [xe]
[   49.134827]  ? __pfx_xe_init+0x10/0x10 [xe]
[   49.134926] xe 0000:00:04.0: [drm:process_one_work] GT1: GuC CT safe-mode canceled
[   49.135112]  do_one_initcall+0x5b/0x2b0
[   49.135734]  ? rcu_is_watching+0xd/0x40
[   49.135995]  ? __kmalloc_cache_noprof+0x231/0x310
[   49.136315]  do_init_module+0x60/0x210
[   49.136572]  init_module_from_file+0x86/0xc0
[   49.136863]  idempotent_init_module+0x12b/0x340
[   49.137156]  __x64_sys_finit_module+0x61/0xc0
[   49.137437]  do_syscall_64+0x69/0x140
[   49.137681]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   49.137953] RIP: 0033:0x7f53ae1261fd
[   49.138153] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 fa 0c 00 f7 d8 64 89 01 48
[   49.139117] RSP: 002b:00007ffd0e9021e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   49.139525] RAX: ffffffffffffffda RBX: 000055c02951ee50 RCX: 00007f53ae1261fd
[   49.139905] RDX: 0000000000000000 RSI: 000055bfff125478 RDI: 0000000000000010
[   49.140282] RBP: 000055bfff125478 R08: 00007f53ae1f6b20 R09: 00007ffd0e902230
[   49.140663] R10: 000055c029522000 R11: 0000000000000246 R12: 0000000000040000
[   49.141040] R13: 000055c02951ef80 R14: 0000000000000000 R15: 000055c029521fc0
[   49.141424]  </TASK>
[   49.141552] Modules linked in: xe(+) drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec drm_gpusvm i2c_algo_bit drm_buddy video wmi ttm drm_display_helper drm_kms_helper crct10dif_pclmul crc32_pclmul i2c_piix4 e1000 ghash_clmulni_intel i2c_smbus fuse
[   49.142824] CR2: ffffeb3ff1200000
[   49.143010] ---[ end trace 0000000000000000 ]---
[   49.143268] RIP: 0010:vmemmap_set_pmd+0xff/0x230
[   49.143523] Code: 77 22 02 a9 ff ff 1f 00 74 58 48 8b 3d 62 77 22 02 48 85 ff 0f 85 9a 00 00 00 48 8d 7d 08 48 89 e9 31 c0 48 89 ea 48 83 e7 f8 <48> c7 45 00 00 00 00 00 48 29 f9 48 c7 45 48 00 00 00 00 83 c1 50
[   49.144489] RSP: 0018:ffffc900016d37a8 EFLAGS: 00010282
[   49.144775] RAX: 0000000000000000 RBX: ffff888164000000 RCX: ffffeb3ff1200000
[   49.145154] RDX: ffffeb3ff1200000 RSI: 80000000000001e3 RDI: ffffeb3ff1200008
[   49.145536] RBP: ffffeb3ff1200000 R08: ffffeb3ff1280000 R09: 0000000000000000
[   49.145914] R10: ffff88817b94dc48 R11: 0000000000000003 R12: ffffeb3ff1280000
[   49.146292] R13: 0000000000000000 R14: ffff88817b94dc48 R15: 8000000163e001e3
[   49.146671] FS:  00007f53ae71d740(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
[   49.147097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.147407] CR2: ffffeb3ff1200000 CR3: 000000017c7d2000 CR4: 0000000000750ef0
[   49.147786] PKRU: 55555554
[   49.147941] note: modprobe[302] exited with irqs disabled

Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Cc: <linux-mm@kvack.org>
---
 arch/x86/Kconfig        |  4 ++++
 arch/x86/mm/init_64.c   | 23 ++++++++++++++++++++++-
 include/linux/pgalloc.h | 26 ++++++++++++++++++++++++++
 mm/sparse-vmemmap.c     |  6 +++---
 4 files changed, 55 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d581634c6a59..0e0606cc9d4f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -427,6 +427,10 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config ARCH_USE_SYNC_GLOBAL_PGDS
+	def_bool y
+	depends on X86_64 && (PGTABLE_LEVELS > 3)
+
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..d7d93f98f931 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -38,7 +38,7 @@
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 #include <asm/dma.h>
 #include <asm/fixmap.h>
 #include <asm/e820/api.h>
@@ -223,6 +223,27 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+#ifdef CONFIG_ARCH_USE_SYNC_GLOBAL_PGDS
+#if CONFIG_PGTABLE_LEVELS > 3
+void arch_sync_global_p4ds(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
+void arch_sync_global_pgds(unsigned long start, unsigned long end) {}
+
+#if CONFIG_PGTABLE_LEVELS > 4
+void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
+
+void arch_sync_global_pgds(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
+#endif	/* CONFIG_PGTABLE_LEVELS > 4 */
+#endif	/* CONFIG_PGTABLE_LEVELS > 3 */
+#endif	/* CONFIG_ARCH_USE_SYNC_GLOBAL_PGDS */
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..072cca766245
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+#include <asm/pgalloc.h>
+
+#ifdef CONFIG_ARCH_USE_SYNC_GLOBAL_PGDS
+void arch_sync_global_p4ds(unsigned long start, unsigned long end);
+void arch_sync_global_pgds(unsigned long start, unsigned long end);
+#else
+static inline void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
+static inline void arch_sync_global_pgds(unsigned long start, unsigned long end) {}
+#endif
+
+static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d, pud_t *pud)
+{
+	p4d_populate(&init_mm, p4d, pud);
+	arch_sync_global_p4ds(addr, addr);
+}
+
+static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd, p4d_t *p4d)
+{
+	pgd_populate(&init_mm, pgd, p4d);
+	arch_sync_global_pgds(addr, addr);
+}
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3287ebadd167..2c54bade3fa4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -23,13 +23,13 @@
 #include <linux/memblock.h>
 #include <linux/memremap.h>
 #include <linux/highmem.h>
+#include <linux/pgalloc.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 #include "internal.h"
 
@@ -219,7 +219,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -231,7 +231,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.48.1


