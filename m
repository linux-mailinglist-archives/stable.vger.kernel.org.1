Return-Path: <stable+bounces-118376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A1BA3D175
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 07:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B078E16B24A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8631DE4EF;
	Thu, 20 Feb 2025 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfAYeoht"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEFE18C322;
	Thu, 20 Feb 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033734; cv=none; b=LOR1jVXyWrDYoipRned+MsnOyQkQehnQ0yTI8M+8FonNtvXvu96gU3DJis74uslIA6V4eKH5JOmK0eBdW1/5+unjVM8J0ze6skhudpTTFQl9sbJKI+Q7YBqq++XBzW24fbGK6AY3oHL1A7LE8EfJkfOTBjhxVJaOT1lHa/boO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033734; c=relaxed/simple;
	bh=th1Iij4qU7EufXY1Pgb9UpaJm7FC/zeMs332QGc1r0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsxhBMsyR/9B8+gY5f6YisF5jlCTju+kf2y5jcUzVs+kW18l9fARfAMi3SceVdoV75Fzb7qZg0QWSYL7PtTsf97wZL9Av7qttoryWBN5CtCgGafSiKVuPBMptF6RTzSjORbWvwTlECW7qt1N/ItAMbgsyHMpbjT39j8X2ulei04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfAYeoht; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740033732; x=1771569732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=th1Iij4qU7EufXY1Pgb9UpaJm7FC/zeMs332QGc1r0Y=;
  b=JfAYeoht+/q5JPrc/3GEzEnjOZeT2LgJhS9XBsfXKn5Td4nKG7zMmloJ
   2lKV1Iccof2ZkHc95Btxvv2fs8ZROnD39XHdeJWkd4TA9E9GxVbDyYbEh
   Gl8sWZZi2zaDQ+LRAzqJt5/5ZJtRG3kqP0pdXgJDqhDYYcYngf9/9shnp
   Rpme+UMIVhhVQ2uV1q3MNAe0tEh3wbk3IXFwkBCmlbPoBJkwUoSuz+Ea2
   5SYvTUZRwlNfFwHj/kUIOHAUhx72bB3ryJskdB9CUcVG7/v+4GGWETZ7h
   MXBcAiLFE1S3IYMWX6QOECK9alvBTf59P9XC2uRtZ3ZlDHwroncvk3egJ
   A==;
X-CSE-ConnectionGUID: votMqbebQg6xRyTIyshi7g==
X-CSE-MsgGUID: ZGbeMmKfSFSGK85EKlrOgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40721507"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40721507"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:42:11 -0800
X-CSE-ConnectionGUID: OIFXXWHYToaslwltoZaXsA==
X-CSE-MsgGUID: WV5MotSoRZGUMyTuVplfQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115150121"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO rapter.intel.com) ([10.245.246.182])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:42:07 -0800
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
Subject: [PATCH] x86/vmemmap: Synchronize with global pgds if populating init_mm's pgd
Date: Thu, 20 Feb 2025 08:41:05 +0200
Message-ID: <20250220064105.808339-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address an Oops issues when performing test of loading XE GPU driver
module after applying the GPU SVM and Xe SVM patch series[1] and the Dept
patch series[2].

The issue occurs when loading the xe driver via modprobe [3], which adds a
struct page for device memory via devm_memremap_pages().  When a process
leads the addition of a struct page to vmemmap (e.g.  hot-plug), the page
table update for the newly added vmemmap-based virtual address is updated
first in init_mm's page table and then synchronized later.

If the vmemmap-based virtual address is accessed through the process's
page table before this sync, a page fault will occur.

This addresses the issue by synchronizing with the global pgds immediately
after populating the init_mm's pgd. On platforms other than the
x86 platform, there is currently no case of accessing the address before
synchronizing the pgd, so applying the weak symbol to existing
vmemmap_pgd_populate() and vmemmap_pgd_populate(), and adding a strong-
symbol function to x86 so that only the x86 platform have this behavior.

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
 arch/x86/mm/init_64.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 mm/sparse-vmemmap.c   |  4 ++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..7935859bcc21 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1498,6 +1498,54 @@ static long __meminitdata addr_start, addr_end;
 static void __meminitdata *p_start, *p_end;
 static int __meminitdata node_start;
 
+static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
+{
+	void *p = vmemmap_alloc_block(size, node);
+
+	if (!p)
+		return NULL;
+	memset(p, 0, size);
+
+	return p;
+}
+
+p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
+{
+	p4d_t *p4d = p4d_offset(pgd, addr);
+
+	if (p4d_none(*p4d)) {
+		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+
+		pud_init(p);
+		p4d_populate(&init_mm, p4d, p);
+
+		if (!pgtable_l5_enabled())
+			sync_global_pgds(addr, addr);
+	}
+
+	return p4d;
+}
+
+pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+
+	if (pgd_none(*pgd)) {
+		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+
+		if (!p)
+			return NULL;
+
+		pgd_populate(&init_mm, pgd, p);
+		sync_global_pgds(addr, addr);
+	}
+
+	return pgd;
+}
+
 void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 			       unsigned long addr, unsigned long next)
 {
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3287ebadd167..c0a803046db0 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -211,7 +211,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 	return pud;
 }
 
-p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
+p4d_t * __weak __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
@@ -224,7 +224,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 	return p4d;
 }
 
-pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
+pgd_t * __weak __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-- 
2.48.1


