Return-Path: <stable+bounces-106826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BFA023F5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EC77A030A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95691DB95E;
	Mon,  6 Jan 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Li909b+N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFE1D86ED
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161643; cv=none; b=hF42qo9juuD/s0CruQZwDJTmHAKYQchuzIJl/ty7U5sSF1+IeK+io97ScXPBz1FBSnGU5kMeTkFTLXLLvzhQyos9jhmkxYcEwyIEjJ+VkS+uSBuwuW++fve1+rWV5JdokfaiVHQmM8Nrda7xd/157fPcc1SQYlSFRwsV8CWvEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161643; c=relaxed/simple;
	bh=3l0KJ8rtat7NYqRGkBO/WFkZsABWG+lJgeLPhmOUkoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MfhkzU3kY1qyyuzya/6GGZy4qGLp6PsOK8b9S6DLBXMDsUrzrikoS4aL4j7mht/oV0o5l4XwBmBuib/RH5czlcfwJdRUqzGBSPpd0oVhBkNfII2gJwGoi4sorVrXuGqxKtAIh6lylDLLFoYMVAWr78C6ji9h5MbQcUMmuWc04uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Li909b+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF138C4CEDD;
	Mon,  6 Jan 2025 11:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736161643;
	bh=3l0KJ8rtat7NYqRGkBO/WFkZsABWG+lJgeLPhmOUkoM=;
	h=Subject:To:Cc:From:Date:From;
	b=Li909b+NadAV6HyuPtQdJVKkJ4rZfmqJFxPVSbAjj93sfu8WYtxIWGALA+GmketxY
	 PjUhGgj2eEwYrSfReJJu7f2Ba/CEhK+xPZ9lxBnD30IDPOHqGKawinhpgxFNr2hI2F
	 PDhcrySqV4H1PsobeBQP6PjBPwPiShJwzT47Smm4=
Subject: FAILED: patch "[PATCH] mm: hugetlb: independent PMD page table shared count" failed to apply to 6.6-stable tree
To: liushixin2@huawei.com,akpm@linux-foundation.org,jane.chu@oracle.com,kenneth.w.chen@intel.com,muchun.song@linux.dev,stable@vger.kernel.org,sunnanyong@huawei.com,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 12:07:20 +0100
Message-ID: <2025010620-lethargic-backspin-e75d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 59d9094df3d79443937add8700b2ef1a866b1081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010620-lethargic-backspin-e75d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59d9094df3d79443937add8700b2ef1a866b1081 Mon Sep 17 00:00:00 2001
From: Liu Shixin <liushixin2@huawei.com>
Date: Mon, 16 Dec 2024 15:11:47 +0800
Subject: [PATCH] mm: hugetlb: independent PMD page table shared count

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

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb397918c43d..b1c3db9cf355 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3125,6 +3125,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
 	if (!pmd_ptlock_init(ptdesc))
 		return false;
 	__folio_set_pgtable(folio);
+	ptdesc_pmd_pts_init(ptdesc);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..332cee285662 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
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
@@ -516,6 +520,32 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cec4b121193f..c498874a7170 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7211,7 +7211,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 			spte = hugetlb_walk(svma, saddr,
 					    vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
 				break;
 			}
 		}
@@ -7226,7 +7226,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
 	}
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -7238,10 +7238,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -7250,18 +7246,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
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


