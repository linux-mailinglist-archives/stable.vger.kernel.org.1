Return-Path: <stable+bounces-176558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7672B39340
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 07:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C8846313F
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A87275846;
	Thu, 28 Aug 2025 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zjd5vA8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177F13DDAA;
	Thu, 28 Aug 2025 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359989; cv=none; b=ZkP9v6tFJG+XpMpuAluytftoHio3ejoDnV+6uX9dU3F9T5iqC1Z5BPdfyICBT7xKmBXgGI1wxCLVlPcB7lt+es9mrry9X0JlGOHVuegSGnOdz802YglLfTUwFjhHlp6Wx8hmZd6+hzWPvWPiOBYPK6ydLHqj5Me0OspX+Gi+XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359989; c=relaxed/simple;
	bh=m3EMZVr66rBz0VOwRRmqMShtzeVztVqPlxDBew0cOhQ=;
	h=Date:To:From:Subject:Message-Id; b=qRoYmGhpslPxkNRh9c8YvwQK/YVXV9fUcaeTs4CpsCxF2TMP2LJ0IDSuqIr9Wr8T/7RdHbxnpwfxCCEhodKoDL5R6Uw3zgIdA/X3H/QKIfj4MgZCtOymL6c5/UKj4N9KJLw27j3ItDBulXbghALSDtTEj2r3O9r3UaXHsUOMzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zjd5vA8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32458C4CEEB;
	Thu, 28 Aug 2025 05:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756359989;
	bh=m3EMZVr66rBz0VOwRRmqMShtzeVztVqPlxDBew0cOhQ=;
	h=Date:To:From:Subject:From;
	b=Zjd5vA8GFsjTE9mSiKzES8NDrXcpXxc7u8MvdDlexkAujhN+/tr1tWBUH3O8Jaisj
	 FHS5D2nzo/vsR7s2Ry1dRC7iGigjxkv76MqkdQwywD+6+5422WbaKbbqCjsX7QJ35v
	 ADlntA+xuHaHYYCk/1LTvmrzRxvb7tJQUSfvqyBo=
Date: Wed, 27 Aug 2025 22:46:28 -0700
To: mm-commits@vger.kernel.org,zhengqi.arch@bytedance.com,vincenzo.frascino@arm.com,vbabka@suse.cz,urezki@gmail.com,tj@kernel.org,thuth@redhat.com,tglx@linutronix.de,surenb@google.com,stable@vger.kernel.org,ryan.roberts@arm.com,ryabinin.a.a@gmail.com,rppt@kernel.org,peterz@infradead.org,peterx@redhat.com,osalvador@suse.de,mingo@redhat.com,mhocko@suse.com,maobibo@loongson.cn,luto@kernel.org,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,kevin.brodsky@arm.com,kas@kernel.org,joro@8bytes.org,joao.m.martins@oracle.com,jhubbard@nvidia.com,jane.chu@oracle.com,gwan-gyeong.mun@intel.com,glider@google.com,dvyukov@google.com,dev.jain@arm.com,dennis@kernel.org,david@redhat.com,dave.hansen@linux.intel.com,cl@gentwo.org,bp@alien8.de,arnd@arndb.de,ardb@kernel.org,apopple@nvidia.com,anshuman.khandual@arm.com,aneesh.kumar@linux.ibm.com,andreyknvl@gmail.com,harry.yoo@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-move-page-table-sync-declarations-to-linux-pgtableh.patch removed from -mm tree
Message-Id: <20250828054629.32458C4CEEB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: move page table sync declarations to linux/pgtable.h
has been removed from the -mm tree.  Its filename was
     mm-move-page-table-sync-declarations-to-linux-pgtableh.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Harry Yoo <harry.yoo@oracle.com>
Subject: mm: move page table sync declarations to linux/pgtable.h
Date: Mon, 18 Aug 2025 11:02:04 +0900

During our internal testing, we started observing intermittent boot
failures when the machine uses 4-level paging and has a large amount of
persistent memory:

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

It turns out that the kernel panics while initializing vmemmap (struct
page array) when the vmemmap region spans two PGD entries, because the new
PGD entry is only installed in init_mm.pgd, but not in the page tables of
other tasks.

And looking at __populate_section_memmap():
  if (vmemmap_can_optimize(altmap, pgmap))                                
          // does not sync top level page tables
          r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
  else                                                                    
          // sync top level page tables in x86
          r = vmemmap_populate(start, end, nid, altmap);

In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
synchronizes the top level page table (See commit 9b861528a801 ("x86-64,
mem: Update all PGDs for direct mapping and vmemmap mapping changes")) so
that all tasks in the system can see the new vmemmap area.

However, when vmemmap_can_optimize() returns true, the optimized path
skips synchronization of top-level page tables.  This is because
vmemmap_populate_compound_pages() is implemented in core MM code, which
does not handle synchronization of the top-level page tables.  Instead,
the core MM has historically relied on each architecture to perform this
synchronization manually.

We're not the first party to encounter a crash caused by not-sync'd top
level page tables: earlier this year, Gwan-gyeong Mun attempted to address
the issue [1] [2] after hitting a kernel panic when x86 code accessed the
vmemmap area before the corresponding top-level entries were synced.  At
that time, the issue was believed to be triggered only when struct page
was enlarged for debugging purposes, and the patch did not get further
updates.

It turns out that current approach of relying on each arch to handle the
page table sync manually is fragile because 1) it's easy to forget to sync
the top level page table, and 2) it's also easy to overlook that the
kernel should not access the vmemmap and direct mapping areas before the
sync.

# The solution: Make page table sync more code robust and harder to miss

To address this, Dave Hansen suggested [3] [4] introducing
{pgd,p4d}_populate_kernel() for updating kernel portion of the page tables
and allow each architecture to explicitly perform synchronization when
installing top-level entries.  With this approach, we no longer need to
worry about missing the sync step, reducing the risk of future
regressions.

The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
vmalloc and ioremap to synchronize page tables.

pgd_populate_kernel() looks like this:
static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
                                       p4d_t *p4d)
{
        pgd_populate(&init_mm, pgd, p4d);
        if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
                arch_sync_kernel_mappings(addr, addr);
}

It is worth noting that vmalloc() and apply_to_range() carefully
synchronizes page tables by calling p*d_alloc_track() and
arch_sync_kernel_mappings(), and thus they are not affected by this patch
series.

This series was hugely inspired by Dave Hansen's suggestion and hence
added Suggested-by: Dave Hansen.

Cc stable because lack of this series opens the door to intermittent
boot failures.


This patch (of 3):

Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
linux/pgtable.h so that they can be used outside of vmalloc and ioremap.

Link: https://lkml.kernel.org/r/20250818020206.4517-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250818020206.4517-2-harry.yoo@oracle.com
Link: https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com [1] 
Link: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [2] 
Link: https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com [3] 
Link: https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com  [4] 
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
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
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/pgtable.h |   16 ++++++++++++++++
 include/linux/vmalloc.h |   16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

--- a/include/linux/pgtable.h~mm-move-page-table-sync-declarations-to-linux-pgtableh
+++ a/include/linux/pgtable.h
@@ -1467,6 +1467,22 @@ static inline void modify_prot_commit_pt
 }
 #endif
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
--- a/include/linux/vmalloc.h~mm-move-page-table-sync-declarations-to-linux-pgtableh
+++ a/include/linux/vmalloc.h
@@ -220,22 +220,6 @@ int vmap_pages_range(unsigned long addr,
 		     struct page **pages, unsigned int page_shift);
 
 /*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
-/*
  *	Lowlevel-APIs (not for driver use!)
  */
 
_

Patches currently in -mm which might be from harry.yoo@oracle.com are



