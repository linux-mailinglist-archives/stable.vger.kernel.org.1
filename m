Return-Path: <stable+bounces-157285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71951AE5344
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003264A7773
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926AE218AC1;
	Mon, 23 Jun 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yC3L2CIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50875223DF0;
	Mon, 23 Jun 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715494; cv=none; b=iKMto3shDUCMY+TajP9rHFWGqFzdlYILzhqJS3YPm1mCGz/8gDJHLdUk7AYQrtqFErzjlNHR38Z02Vo2bRER7wU0xpPm5EIYknRIB4pvyj/LaUqRJutvEHN4VSK1DHzhq1JhTPBML+ibJni/zrBi6gO5NfwaSPhR8qblTq4eRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715494; c=relaxed/simple;
	bh=dsR9ICI3hstsPZlxUfkJ5NfXRuTTWRW30giIOwd0Jpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7379TgNc4rVsnZygtAOothiOK0VKWRsirtkowQrKLvtQkCINJoPpF48Z+3/1/20WgBpXYdZOxf/sctwzEurH8M5l3JClOpRusC/gKd7cbDB/0SR9emhVNlQMmHE+UL3GqGe8eQAeN/me21Ccs5VHypxtiGUx3ms3nxYnv0nEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yC3L2CIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF0C4CEF9;
	Mon, 23 Jun 2025 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715494;
	bh=dsR9ICI3hstsPZlxUfkJ5NfXRuTTWRW30giIOwd0Jpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yC3L2CIGZw03sE1gB2bw7msICpyBq1pCXn6Hkf2eZ/OUv4UGMV+ZugfmiHx/Vri/p
	 udTfg3n44FiDDjQsN+gULcwQbeOJ/0r4BbRxGM9T15oa2oR+OKJUTC1R47Xopogjtm
	 uAdPlOlSCtnDngwhdZUWbRnc3HfqGom3nFXZMa5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Shixin <liushixin2@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ken Chen <kenneth.w.chen@intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 5.10 299/355] mm: hugetlb: independent PMD page table shared count
Date: Mon, 23 Jun 2025 15:08:20 +0200
Message-ID: <20250623130635.769163319@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Liu Shixin <liushixin2@huawei.com>

commit 59d9094df3d79443937add8700b2ef1a866b1081 upstream.

The folio refcount may be increased unexpectly through try_get_folio() by
caller such as split_huge_pages.  In huge_pmd_unshare(), we use refcount
to check whether a pmd page table is shared.  The check is incorrect if
the refcount is increased by the above caller, and this can cause the page
table leaked:

 BUG: Bad page state in process sh  pfn:109324
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
 flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
 page_type: f2(table)
 raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
 raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
 page dumped because: nonzero mapcount
 ...
 CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
 Tainted: [B]=BAD_PAGE
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x80/0xf8
  dump_stack+0x18/0x28
  bad_page+0x8c/0x130
  free_page_is_bad_report+0xa4/0xb0
  free_unref_page+0x3cc/0x620
  __folio_put+0xf4/0x158
  split_huge_pages_all+0x1e0/0x3e8
  split_huge_pages_write+0x25c/0x2d8
  full_proxy_write+0x64/0xd8
  vfs_write+0xcc/0x280
  ksys_write+0x70/0x110
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x34/0x128
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x190/0x198

The issue may be triggered by damon, offline_page, page_idle, etc, which
will increase the refcount of page table.

1. The page table itself will be discarded after reporting the
   "nonzero mapcount".

2. The HugeTLB page mapped by the page table miss freeing since we
   treat the page table as shared and a shared page table will not be
   unmapped.

Fix it by introducing independent PMD page table shared count.  As
described by comment, pt_index/pt_mm/pt_frag_refcount are used for s390
gmap, x86 pgds and powerpc, pt_share_count is used for x86/arm64/riscv
pmds, so we can reuse the field as pt_share_count.

Link: https://lkml.kernel.org/r/20241216071147.3984217-1-liushixin2@huawei.com
Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Ken Chen <kenneth.w.chen@intel.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[backport note: struct ptdesc did not exist yet, stuff it equivalently
into struct page instead]
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h       |    3 +++
 include/linux/mm_types.h |    3 +++
 mm/hugetlb.c             |   18 ++++++++----------
 3 files changed, 14 insertions(+), 10 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2318,6 +2318,9 @@ static inline bool pgtable_pmd_page_ctor
 	if (!pmd_ptlock_init(page))
 		return false;
 	__SetPageTable(page);
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	atomic_set(&page->pt_share_count, 0);
+#endif
 	inc_zone_page_state(page, NR_PAGETABLE);
 	return true;
 }
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -151,6 +151,9 @@ struct page {
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+				atomic_t pt_share_count;
+#endif
 			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5442,7 +5442,7 @@ pte_t *huge_pmd_share(struct mm_struct *
 			spte = huge_pte_offset(svma->vm_mm, saddr,
 					       vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				atomic_inc(&virt_to_page(spte)->pt_share_count);
 				break;
 			}
 		}
@@ -5457,7 +5457,7 @@ pte_t *huge_pmd_share(struct mm_struct *
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		atomic_dec(&virt_to_page(spte)->pt_share_count);
 	}
 	spin_unlock(ptl);
 out:
@@ -5468,11 +5468,7 @@ out:
 /*
  * unmap huge page backed by shared pte.
  *
- * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
- * indicated by page_count > 1, unmap is achieved by clearing pud and
- * decrementing the ref count. If count == 1, the pte page is not shared.
- *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
@@ -5480,17 +5476,19 @@ out:
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 					unsigned long *addr, pte_t *ptep)
 {
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 	pgd_t *pgd = pgd_offset(mm, *addr);
 	p4d_t *p4d = p4d_offset(pgd, *addr);
 	pud_t *pud = pud_offset(p4d, *addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	BUG_ON(page_count(virt_to_page(ptep)) == 0);
-	if (page_count(virt_to_page(ptep)) == 1)
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!atomic_read(&virt_to_page(ptep)->pt_share_count))
 		return 0;
 
 	pud_clear(pud);
-	put_page(virt_to_page(ptep));
+	atomic_dec(&virt_to_page(ptep)->pt_share_count);
 	mm_dec_nr_pmds(mm);
 	/*
 	 * This update of passed address optimizes loops sequentially



