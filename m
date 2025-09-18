Return-Path: <stable+bounces-176560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CFB39342
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532DC462F03
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 05:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB322777E3;
	Thu, 28 Aug 2025 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gbkt2BFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947213DDAA;
	Thu, 28 Aug 2025 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359995; cv=none; b=QQrv8m2V2zEDaktsfhULwmnDhvwMC+uHprsypKGDvvCy5XosH9afKLo/Rlz62ZJib4LH2jBhbrlm337tbhZb0ysDqGf1fj2fe5wqBEilS+cyS1qIGTtWlaCxxfvLb+tjBUHUdhLUZx+mxt856H7N+F/aHYeKF3K6xHkJoy3M1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359995; c=relaxed/simple;
	bh=RZCsWplQlse6xLWWz7EhRraSgkEGHdLgaFt8ReYymOU=;
	h=Date:To:From:Subject:Message-Id; b=ZeYWNrGpFl39NYuHTMA0NchdZe02g/PN0jT5EfkknJPnlMePy/BSJHk+T1Zr28kDmsus5wco+bmBzvbLOQH8pPRcePnykn2JgV673YDW8y2bSBvRUlq14m+SmVhRnZNq012AeKSmq+QpvA2qDuAnLnSL9qo/6LPXTl8FxHb7eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gbkt2BFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA76C4CEEB;
	Thu, 28 Aug 2025 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756359994;
	bh=RZCsWplQlse6xLWWz7EhRraSgkEGHdLgaFt8ReYymOU=;
	h=Date:To:From:Subject:From;
	b=Gbkt2BFRq0G4U6Kbx/UQYyIpesbH9yic6FTOieiWMJdSiX5xcjf5dv/c4nJGz7Qve
	 pOrLbYRhppdna8mLVhSHsB60OkEysDLHYw7hOs8SbolxWn4DLoGg/yInBoNU7SzLyW
	 qMCi53p4fa+6D7A8dWFMURpMNGXP43NscIpZu9UM=
Date: Wed, 27 Aug 2025 22:46:34 -0700
To: mm-commits@vger.kernel.org,zhengqi.arch@bytedance.com,vincenzo.frascino@arm.com,vbabka@suse.cz,urezki@gmail.com,tj@kernel.org,thuth@redhat.com,tglx@linutronix.de,surenb@google.com,stable@vger.kernel.org,ryan.roberts@arm.com,ryabinin.a.a@gmail.com,rppt@kernel.org,peterz@infradead.org,peterx@redhat.com,osalvador@suse.de,mingo@redhat.com,mhocko@suse.com,maobibo@loongson.cn,luto@kernel.org,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,kevin.brodsky@arm.com,kas@kernel.org,joro@8bytes.org,joao.m.martins@oracle.com,jhubbard@nvidia.com,jane.chu@oracle.com,glider@google.com,dvyukov@google.com,dev.jain@arm.com,dennis@kernel.org,david@redhat.com,dave.hansen@linux.intel.com,cl@gentwo.org,bp@alien8.de,arnd@arndb.de,ardb@kernel.org,apopple@nvidia.com,anshuman.khandual@arm.com,aneesh.kumar@linux.ibm.com,andreyknvl@gmail.com,harry.yoo@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] x86-mm-64-define-arch_page_table_sync_mask-and-arch_sync_kernel_mappings.patch removed from -mm tree
Message-Id: <20250828054634.9DA76C4CEEB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
has been removed from the -mm tree.  Its filename was
     x86-mm-64-define-arch_page_table_sync_mask-and-arch_sync_kernel_mappings.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Harry Yoo <harry.yoo@oracle.com>
Subject: x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
Date: Mon, 18 Aug 2025 11:02:06 +0900

Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
page tables are properly synchronized when calling p*d_populate_kernel().

For 5-level paging, synchronization is performed via
pgd_populate_kernel().  In 4-level paging, pgd_populate() is a no-op, so
synchronization is instead performed at the P4D level via
p4d_populate_kernel().

This fixes intermittent boot failures on systems using 4-level paging and
a large amount of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
before sync_global_pgds() [1]:

  BUG: unable to handle page fault for address: ffffeb3ff1200000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
  Tainted: [W]=WARN
  RIP: 0010:vmemmap_set_pmd+0xff/0x230
   <TASK>
   vmemmap_populate_hugepages+0x176/0x180
   vmemmap_populate+0x34/0x80
   __populate_section_memmap+0x41/0x90
   sparse_add_section+0x121/0x3e0
   __add_pages+0xba/0x150
   add_pages+0x1d/0x70
   memremap_pages+0x3dc/0x810
   devm_memremap_pages+0x1c/0x60
   xe_devm_add+0x8b/0x100 [xe]
   xe_tile_init_noalloc+0x6a/0x70 [xe]
   xe_device_probe+0x48c/0x740 [xe]
   [... snip ...]

Link: https://lkml.kernel.org/r/20250818020206.4517-4-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bibo mao <maobibo@loongson.cn>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Huth <thuth@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/include/asm/pgtable_64_types.h |    3 +++
 arch/x86/mm/init_64.c                   |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

--- a/arch/x86/include/asm/pgtable_64_types.h~x86-mm-64-define-arch_page_table_sync_mask-and-arch_sync_kernel_mappings
+++ a/arch/x86/include/asm/pgtable_64_types.h
@@ -36,6 +36,9 @@ static inline bool pgtable_l5_enabled(vo
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
--- a/arch/x86/mm/init_64.c~x86-mm-64-define-arch_page_table_sync_mask-and-arch_sync_kernel_mappings
+++ a/arch/x86/mm/init_64.c
@@ -224,6 +224,24 @@ static void sync_global_pgds(unsigned lo
 }
 
 /*
+ * Make kernel mappings visible in all page tables in the system.
+ * This is necessary except when the init task populates kernel mappings
+ * during the boot process. In that case, all processes originating from
+ * the init task copies the kernel mappings, so there is no issue.
+ * Otherwise, missing synchronization could lead to kernel crashes due
+ * to missing page table entries for certain kernel mappings.
+ *
+ * Synchronization is performed at the top level, which is the PGD in
+ * 5-level paging systems. But in 4-level paging systems, however,
+ * pgd_populate() is a no-op, so synchronization is done at the P4D level.
+ * sync_global_pgds() handles this difference between paging levels.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
+/*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
  */
_

Patches currently in -mm which might be from harry.yoo@oracle.com are



