Return-Path: <stable+bounces-171854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A3B2CFD3
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 01:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C478B3AF2FE
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC52512DE;
	Tue, 19 Aug 2025 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FHi33dGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB835334C;
	Tue, 19 Aug 2025 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645706; cv=none; b=gZTkXE9hsMatKqpnkfwgHoq62sjHTunP6ZpPHgsYx9lWD+FKGwGG8TaL81uu2ztMECJNwDC9o3h5u6fqgAqtSzCsTTqlI4woq8SL7v1TkR9xlfP05X39bDe3/OiZgk9m2rwKAN3pxQN1rkSQQ+rNojfbM1wlSkM5oe9VaDS8pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645706; c=relaxed/simple;
	bh=BnXTUl8dvD+HzyhrEiSRw4V1B6LviVlpLw+GCkWqWGY=;
	h=Date:To:From:Subject:Message-Id; b=RatkHyPK+D4wOpeHHv2Yhh5RRJWfXuHx8iADxdIi5kxBsnslW6+Ym83sgSAdb/XHIbL1JvuAlrWJrCb1rh8IbibLa6S8XCW/HVFCiEK6rSMh5gIQmvQC2d9m5GULAMwXKQwzbnucz8JoagUiYJdWRtHZZajlsPsKSYeHPbWBCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FHi33dGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14167C4CEF1;
	Tue, 19 Aug 2025 23:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755645706;
	bh=BnXTUl8dvD+HzyhrEiSRw4V1B6LviVlpLw+GCkWqWGY=;
	h=Date:To:From:Subject:From;
	b=FHi33dGyM5485Vfe2lykEbdSPt5Vga6eHnbwn5YCQC52sRszcnH4icF2d0Hl3LFaE
	 2chj7Pr04iOt+t/Wh3wtMExSJ8L47FGd7lqHZomKpGXLk8EeMBguH/2Q0A1wtXrzLd
	 M//chh4kNjs4Vqv68o1fU0/XBVpJzRZAF+Gp2UQY=
Date: Tue, 19 Aug 2025 16:21:45 -0700
To: mm-commits@vger.kernel.org,zhengqi.arch@bytedance.com,vincenzo.frascino@arm.com,vbabka@suse.cz,urezki@gmail.com,tj@kernel.org,thuth@redhat.com,tglx@linutronix.de,surenb@google.com,stable@vger.kernel.org,ryan.roberts@arm.com,ryabinin.a.a@gmail.com,rppt@kernel.org,peterz@infradead.org,peterx@redhat.com,osalvador@suse.de,mingo@redhat.com,mhocko@suse.com,maobibo@loongson.cn,luto@kernel.org,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,kevin.brodsky@arm.com,kas@kernel.org,joro@8bytes.org,joao.m.martins@oracle.com,jhubbard@nvidia.com,jane.chu@oracle.com,gwan-gyeong.mun@intel.com,glider@google.com,dvyukov@google.com,dev.jain@arm.com,dennis@kernel.org,david@redhat.com,dave.hansen@linux.intel.com,cl@gentwo.org,bp@alien8.de,arnd@arndb.de,ardb@kernel.org,apopple@nvidia.com,anshuman.khandual@arm.com,aneesh.kumar@linux.ibm.com,andreyknvl@gmail.com,harry.yoo@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-introduce-and-use-pgdp4d_populate_kernel.patch added to mm-hotfixes-unstable branch
Message-Id: <20250819232146.14167C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: introduce and use {pgd,p4d}_populate_kernel()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-introduce-and-use-pgdp4d_populate_kernel.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-introduce-and-use-pgdp4d_populate_kernel.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Harry Yoo <harry.yoo@oracle.com>
Subject: mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon, 18 Aug 2025 11:02:05 +0900

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.  These
helpers ensure proper synchronization of page tables when updating the
kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.  For
example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.  These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common
code.

They reuse existing infrastructure for vmalloc and ioremap. 
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by
arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced.  Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by other
architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
we introduce a PMD level helper.

Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
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
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/pgalloc.h |   24 ++++++++++++++++++++++++
 include/linux/pgtable.h |   13 +++++++------
 mm/kasan/init.c         |   12 ++++++------
 mm/percpu.c             |    6 +++---
 mm/sparse-vmemmap.c     |    6 +++---
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/linux/pgalloc.h a/include/linux/pgalloc.h
new file mode 100644
--- /dev/null
+++ a/include/linux/pgalloc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
+				       p4d_t *p4d)
+{
+	pgd_populate(&init_mm, pgd, p4d);
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
+static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
+				       pud_t *pud)
+{
+	p4d_populate(&init_mm, p4d, pud);
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
+#endif /* _LINUX_PGALLOC_H */
--- a/include/linux/pgtable.h~mm-introduce-and-use-pgdp4d_populate_kernel
+++ a/include/linux/pgtable.h
@@ -1469,8 +1469,8 @@ static inline void modify_prot_commit_pt
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1954,10 +1954,11 @@ static inline bool arch_has_pfn_modify_c
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
--- a/mm/kasan/init.c~mm-introduce-and-use-pgdp4d_populate_kernel
+++ a/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(co
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(co
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
--- a/mm/percpu.c~mm-introduce-and-use-pgdp4d_populate_kernel
+++ a/mm/percpu.c
@@ -3108,7 +3108,7 @@ out_free:
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(uns
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
--- a/mm/sparse-vmemmap.c~mm-introduce-and-use-pgdp4d_populate_kernel
+++ a/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 #include "hugetlb_vmemmap.h"
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(p
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(u
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
_

Patches currently in -mm which might be from harry.yoo@oracle.com are

mm-move-page-table-sync-declarations-to-linux-pgtableh.patch
mm-introduce-and-use-pgdp4d_populate_kernel.patch
x86-mm-64-define-arch_page_table_sync_mask-and-arch_sync_kernel_mappings.patch


