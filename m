Return-Path: <stable+bounces-104383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BAC9F36FC
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B097E164292
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470A1F706A;
	Mon, 16 Dec 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A5e9G68W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDF126BF7;
	Mon, 16 Dec 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368801; cv=none; b=ZqTQLgCWfzofNsfwrj5sa2PqmRHUxjz86mzEdU57RG+82gU/JXO+O2mGtvQ0BM60GHFl7au6Qc/iGKgQz54uPPhpG/g6c6yqVvusxRzNmzG25+S9la66xfMDkfYd2otR7WgDKWHm/l+YdtTer40TIOMfDb9v5mpmAvVescHt+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368801; c=relaxed/simple;
	bh=6rLbqDpq132Fc2qmsHPS4g5GfEjn6kctkcgMIJMbVGA=;
	h=Date:To:From:Subject:Message-Id; b=mRRKSGiOvCvVCeNDjDYPq0nJq5XjGia59qxQur45s9WYZEUd9YbzKum8H7UxUhdQoNhVLC8lYlXChmmyuSzXDZLw88WzP+cneEq9O9TrE0crGW6mnuvWypO0XKJ5oUWiaYqBL/B+EWoAKLGzWmOmapFceuMAGjiFQIEdRVIx8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A5e9G68W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A50C4CED0;
	Mon, 16 Dec 2024 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734368801;
	bh=6rLbqDpq132Fc2qmsHPS4g5GfEjn6kctkcgMIJMbVGA=;
	h=Date:To:From:Subject:From;
	b=A5e9G68W5HLQLKv/GDU2NyS9EBnoBhdknNRBkzu9WfG2/y++7uJS9udGfJ6evoBKx
	 hN/aii36Z67VMP7z/gOqEDmZY1DwXG3weMbiw0hqR9W4LJCWu1ChyzZl3d1YDVzyEf
	 EAJwVanDa4c71r56FcTfX6xouONmBO4WTsWm79wQ=
Date: Mon, 16 Dec 2024 09:06:40 -0800
To: mm-commits@vger.kernel.org,wangkefeng.wang@huawei.com,sunnanyong@huawei.com,stable@vger.kernel.org,muchun.song@linux.dev,kenneth.w.chen@intel.com,liushixin2@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-hugetlb-independent-pmd-page-table-shared-count.patch added to mm-hotfixes-unstable branch
Message-Id: <20241216170641.37A50C4CED0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: hugetlb: independent PMD page table shared count
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-hugetlb-independent-pmd-page-table-shared-count.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-independent-pmd-page-table-shared-count.patch

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
From: Liu Shixin <liushixin2@huawei.com>
Subject: mm: hugetlb: independent PMD page table shared count
Date: Mon, 16 Dec 2024 15:11:47 +0800

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mm.h       |    1 +
 include/linux/mm_types.h |   30 ++++++++++++++++++++++++++++++
 mm/hugetlb.c             |   16 +++++++---------
 3 files changed, 38 insertions(+), 9 deletions(-)

--- a/include/linux/mm.h~mm-hugetlb-independent-pmd-page-table-shared-count
+++ a/include/linux/mm.h
@@ -3125,6 +3125,7 @@ static inline bool pagetable_pmd_ctor(st
 	if (!pmd_ptlock_init(ptdesc))
 		return false;
 	__folio_set_pgtable(folio);
+	ptdesc_pmd_pts_init(ptdesc);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
--- a/include/linux/mm_types.h~mm-hugetlb-independent-pmd-page-table-shared-count
+++ a/include/linux/mm_types.h
@@ -445,6 +445,7 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @pt_index:         Used for s390 gmap.
  * @pt_mm:            Used for x86 pgds.
  * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
+ * @pt_share_count:   Used for HugeTLB PMD page table share count.
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
@@ -471,6 +472,9 @@ struct ptdesc {
 		pgoff_t pt_index;
 		struct mm_struct *pt_mm;
 		atomic_t pt_frag_refcount;
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+		atomic_t pt_share_count;
+#endif
 	};
 
 	union {
@@ -516,6 +520,32 @@ static_assert(sizeof(struct ptdesc) <= s
 	const struct page *:		(const struct ptdesc *)(p),	\
 	struct page *:			(struct ptdesc *)(p)))
 
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
+{
+	atomic_set(&ptdesc->pt_share_count, 0);
+}
+
+static inline void ptdesc_pmd_pts_inc(struct ptdesc *ptdesc)
+{
+	atomic_inc(&ptdesc->pt_share_count);
+}
+
+static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
+{
+	atomic_dec(&ptdesc->pt_share_count);
+}
+
+static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+{
+	return atomic_read(&ptdesc->pt_share_count);
+}
+#else
+static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
+{
+}
+#endif
+
 /*
  * Used for sizing the vmemmap region on some architectures
  */
--- a/mm/hugetlb.c~mm-hugetlb-independent-pmd-page-table-shared-count
+++ a/mm/hugetlb.c
@@ -7211,7 +7211,7 @@ pte_t *huge_pmd_share(struct mm_struct *
 			spte = hugetlb_walk(svma, saddr,
 					    vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
 				break;
 			}
 		}
@@ -7226,7 +7226,7 @@ pte_t *huge_pmd_share(struct mm_struct *
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
 	}
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -7238,10 +7238,6 @@ out:
 /*
  * unmap huge page backed by shared pte.
  *
- * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
- * indicated by page_count > 1, unmap is achieved by clearing pud and
- * decrementing the ref count. If count == 1, the pte page is not shared.
- *
  * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
@@ -7250,18 +7246,20 @@ out:
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 	pgd_t *pgd = pgd_offset(mm, addr);
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	hugetlb_vma_assert_locked(vma);
-	BUG_ON(page_count(virt_to_page(ptep)) == 0);
-	if (page_count(virt_to_page(ptep)) == 1)
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
 		return 0;
 
 	pud_clear(pud);
-	put_page(virt_to_page(ptep));
+	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
 	mm_dec_nr_pmds(mm);
 	return 1;
 }
_

Patches currently in -mm which might be from liushixin2@huawei.com are

mm-hugetlb-independent-pmd-page-table-shared-count.patch


