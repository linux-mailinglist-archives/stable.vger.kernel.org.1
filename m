Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C684B78AA5C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjH1KVp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjH1KVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B0194
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A02863896
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D01EC433C7;
        Mon, 28 Aug 2023 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218016;
        bh=QEFSRpu4w5owLulQjBYXKN8fR3QL2pfwuXmLcKRwk0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMIpSk4K6d7YJOz5gciUU3QHERvAJ+M1jiZgG5tqHUHfkrc8mL1uNlQsbfaq33WPt
         X4CxN595p4oUOQnJ5dAtc3kqg/p8STTWjufOSr3bejghALpPJRr0QQJG/mA+Espjoi
         eY1UZb9gol3iHqvdDYZ7dlrM4Thr6AwPVlZLFfXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 064/129] mm: enable page walking API to lock vmas during the walk
Date:   Mon, 28 Aug 2023 12:12:23 +0200
Message-ID: <20230828101159.485425389@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suren Baghdasaryan <surenb@google.com>

commit 49b0638502da097c15d46cd4e871dbaa022caf7c upstream.

walk_page_range() and friends often operate under write-locked mmap_lock.
With introduction of vma locks, the vmas have to be locked as well during
such walks to prevent concurrent page faults in these areas.  Add an
additional member to mm_walk_ops to indicate locking requirements for the
walk.

The change ensures that page walks which prevent concurrent page faults
by write-locking mmap_lock, operate correctly after introduction of
per-vma locks.  With per-vma locks page faults can be handled under vma
lock without taking mmap_lock at all, so write locking mmap_lock would
not stop them.  The change ensures vmas are properly locked during such
walks.

A sample issue this solves is do_mbind() performing queue_pages_range()
to queue pages for migration.  Without this change a concurrent page
can be faulted into the area and be left out of migration.

Link: https://lkml.kernel.org/r/20230804152724.3090321-2-surenb@google.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Suggested-by: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michel Lespinasse <michel@lespinasse.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/book3s64/subpage_prot.c |    1 
 arch/riscv/mm/pageattr.c                |    1 
 arch/s390/mm/gmap.c                     |    5 ++++
 fs/proc/task_mmu.c                      |    5 ++++
 include/linux/pagewalk.h                |   11 +++++++++
 mm/damon/vaddr.c                        |    2 +
 mm/hmm.c                                |    1 
 mm/ksm.c                                |   25 ++++++++++++++--------
 mm/madvise.c                            |    3 ++
 mm/memcontrol.c                         |    2 +
 mm/memory-failure.c                     |    1 
 mm/mempolicy.c                          |   22 ++++++++++++-------
 mm/migrate_device.c                     |    1 
 mm/mincore.c                            |    1 
 mm/mlock.c                              |    1 
 mm/mprotect.c                           |    1 
 mm/pagewalk.c                           |   36 +++++++++++++++++++++++++++++---
 mm/vmscan.c                             |    1 
 18 files changed, 100 insertions(+), 20 deletions(-)

--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -143,6 +143,7 @@ static int subpage_walk_pmd_entry(pmd_t
 
 static const struct mm_walk_ops subpage_walk_ops = {
 	.pmd_entry	= subpage_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -102,6 +102,7 @@ static const struct mm_walk_ops pageattr
 	.pmd_entry = pageattr_pmd_entry,
 	.pte_entry = pageattr_pte_entry,
 	.pte_hole = pageattr_pte_hole,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2514,6 +2514,7 @@ static int thp_split_walk_pmd_entry(pmd_
 
 static const struct mm_walk_ops thp_split_walk_ops = {
 	.pmd_entry	= thp_split_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static inline void thp_split_mm(struct mm_struct *mm)
@@ -2558,6 +2559,7 @@ static int __zap_zero_pages(pmd_t *pmd,
 
 static const struct mm_walk_ops zap_zero_walk_ops = {
 	.pmd_entry	= __zap_zero_pages,
+	.walk_lock	= PGWALK_WRLOCK,
 };
 
 /*
@@ -2648,6 +2650,7 @@ static const struct mm_walk_ops enable_s
 	.hugetlb_entry		= __s390_enable_skey_hugetlb,
 	.pte_entry		= __s390_enable_skey_pte,
 	.pmd_entry		= __s390_enable_skey_pmd,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int s390_enable_skey(void)
@@ -2685,6 +2688,7 @@ static int __s390_reset_cmma(pte_t *pte,
 
 static const struct mm_walk_ops reset_cmma_walk_ops = {
 	.pte_entry		= __s390_reset_cmma,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 void s390_reset_cmma(struct mm_struct *mm)
@@ -2721,6 +2725,7 @@ static int s390_gather_pages(pte_t *ptep
 
 static const struct mm_walk_ops gather_pages_ops = {
 	.pte_entry = s390_gather_pages,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -759,12 +759,14 @@ static int smaps_hugetlb_range(pte_t *pt
 static const struct mm_walk_ops smaps_walk_ops = {
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static const struct mm_walk_ops smaps_shmem_walk_ops = {
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 	.pte_hole		= smaps_pte_hole,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
@@ -1245,6 +1247,7 @@ static int clear_refs_test_walk(unsigned
 static const struct mm_walk_ops clear_refs_walk_ops = {
 	.pmd_entry		= clear_refs_pte_range,
 	.test_walk		= clear_refs_test_walk,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 static ssize_t clear_refs_write(struct file *file, const char __user *buf,
@@ -1621,6 +1624,7 @@ static const struct mm_walk_ops pagemap_
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /*
@@ -1932,6 +1936,7 @@ static int gather_hugetlb_stats(pte_t *p
 static const struct mm_walk_ops show_numa_ops = {
 	.hugetlb_entry = gather_hugetlb_stats,
 	.pmd_entry = gather_pte_stats,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -6,6 +6,16 @@
 
 struct mm_walk;
 
+/* Locking requirement during a page walk. */
+enum page_walk_lock {
+	/* mmap_lock should be locked for read to stabilize the vma tree */
+	PGWALK_RDLOCK = 0,
+	/* vma will be write-locked during the walk */
+	PGWALK_WRLOCK = 1,
+	/* vma is expected to be already write-locked during the walk */
+	PGWALK_WRLOCK_VERIFY = 2,
+};
+
 /**
  * struct mm_walk_ops - callbacks for walk_page_range
  * @pgd_entry:		if set, called for each non-empty PGD (top-level) entry
@@ -66,6 +76,7 @@ struct mm_walk_ops {
 	int (*pre_vma)(unsigned long start, unsigned long end,
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
+	enum page_walk_lock walk_lock;
 };
 
 /*
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -384,6 +384,7 @@ out:
 static const struct mm_walk_ops damon_mkold_ops = {
 	.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
@@ -519,6 +520,7 @@ out:
 static const struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -560,6 +560,7 @@ static const struct mm_walk_ops hmm_walk
 	.pte_hole	= hmm_vma_walk_hole,
 	.hugetlb_entry	= hmm_vma_walk_hugetlb_entry,
 	.test_walk	= hmm_vma_walk_test,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /**
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -454,6 +454,12 @@ static int break_ksm_pmd_entry(pmd_t *pm
 
 static const struct mm_walk_ops break_ksm_ops = {
 	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+static const struct mm_walk_ops break_ksm_lock_vma_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+	.walk_lock = PGWALK_WRLOCK,
 };
 
 /*
@@ -469,16 +475,17 @@ static const struct mm_walk_ops break_ks
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
 {
 	vm_fault_t ret = 0;
+	const struct mm_walk_ops *ops = lock_vma ?
+				&break_ksm_lock_vma_ops : &break_ksm_ops;
 
 	do {
 		int ksm_page;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
-					       &break_ksm_ops, NULL);
+		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
 		if (WARN_ON_ONCE(ksm_page < 0))
 			return ksm_page;
 		if (!ksm_page)
@@ -564,7 +571,7 @@ static void break_cow(struct ksm_rmap_it
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr);
+		break_ksm(vma, addr, false);
 	mmap_read_unlock(mm);
 }
 
@@ -870,7 +877,7 @@ static void remove_trailing_rmap_items(s
  * in cmp_and_merge_page on one of the rmap_items we would be removing.
  */
 static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end)
+			     unsigned long start, unsigned long end, bool lock_vma)
 {
 	unsigned long addr;
 	int err = 0;
@@ -881,7 +888,7 @@ static int unmerge_ksm_pages(struct vm_a
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, lock_vma);
 	}
 	return err;
 }
@@ -1028,7 +1035,7 @@ static int unmerge_and_remove_all_rmap_i
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end);
+						vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2528,7 +2535,7 @@ static int __ksm_del_vma(struct vm_area_
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
+		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -2666,7 +2673,7 @@ int ksm_madvise(struct vm_area_struct *v
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
+			err = unmerge_ksm_pages(vma, start, end, true);
 			if (err)
 				return err;
 		}
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -227,6 +227,7 @@ static int swapin_walk_pmd_entry(pmd_t *
 
 static const struct mm_walk_ops swapin_walk_ops = {
 	.pmd_entry		= swapin_walk_pmd_entry,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static void force_shm_swapin_readahead(struct vm_area_struct *vma,
@@ -521,6 +522,7 @@ regular_folio:
 
 static const struct mm_walk_ops cold_walk_ops = {
 	.pmd_entry = madvise_cold_or_pageout_pte_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void madvise_cold_page_range(struct mmu_gather *tlb,
@@ -741,6 +743,7 @@ next:
 
 static const struct mm_walk_ops madvise_free_walk_ops = {
 	.pmd_entry		= madvise_free_pte_range,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static int madvise_free_single_vma(struct vm_area_struct *vma,
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6072,6 +6072,7 @@ static int mem_cgroup_count_precharge_pt
 
 static const struct mm_walk_ops precharge_walk_ops = {
 	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
@@ -6351,6 +6352,7 @@ put:			/* get_mctgt_type() gets & locks
 
 static const struct mm_walk_ops charge_walk_ops = {
 	.pmd_entry	= mem_cgroup_move_charge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static void mem_cgroup_move_charge(void)
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -836,6 +836,7 @@ static int hwpoison_hugetlb_range(pte_t
 static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -715,6 +715,14 @@ static const struct mm_walk_ops queue_pa
 	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
+	.hugetlb_entry		= queue_folios_hugetlb,
+	.pmd_entry		= queue_folios_pte_range,
+	.test_walk		= queue_pages_test_walk,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 /*
@@ -735,7 +743,7 @@ static const struct mm_walk_ops queue_pa
 static int
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		struct list_head *pagelist, bool lock_vma)
 {
 	int err;
 	struct queue_pages qp = {
@@ -746,8 +754,10 @@ queue_pages_range(struct mm_struct *mm,
 		.end = end,
 		.first = NULL,
 	};
+	const struct mm_walk_ops *ops = lock_vma ?
+			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
-	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+	err = walk_page_range(mm, start, end, ops, &qp);
 
 	if (!qp.first)
 		/* whole range in hole */
@@ -1075,7 +1085,7 @@ static int migrate_to_node(struct mm_str
 	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1321,12 +1331,8 @@ static long do_mbind(unsigned long start
 	 * Lock the VMAs before scanning for pages to migrate, to ensure we don't
 	 * miss a concurrently inserted page.
 	 */
-	vma_iter_init(&vmi, mm, start);
-	for_each_vma_range(vmi, vma, end)
-		vma_start_write(vma);
-
 	ret = queue_pages_range(mm, start, end, nmask,
-			  flags | MPOL_MF_INVERT, &pagelist);
+			  flags | MPOL_MF_INVERT, &pagelist, true);
 
 	if (ret < 0) {
 		err = ret;
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -286,6 +286,7 @@ next:
 static const struct mm_walk_ops migrate_vma_walk_ops = {
 	.pmd_entry		= migrate_vma_collect_pmd,
 	.pte_hole		= migrate_vma_collect_hole,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -177,6 +177,7 @@ static const struct mm_walk_ops mincore_
 	.pmd_entry		= mincore_pte_range,
 	.pte_hole		= mincore_unmapped_range,
 	.hugetlb_entry		= mincore_hugetlb,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -365,6 +365,7 @@ static void mlock_vma_pages_range(struct
 {
 	static const struct mm_walk_ops mlock_walk_ops = {
 		.pmd_entry = mlock_pte_range,
+		.walk_lock = PGWALK_WRLOCK_VERIFY,
 	};
 
 	/*
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -611,6 +611,7 @@ static const struct mm_walk_ops prot_non
 	.pte_entry		= prot_none_pte_entry,
 	.hugetlb_entry		= prot_none_hugetlb_entry,
 	.test_walk		= prot_none_test,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -384,6 +384,33 @@ static int __walk_page_range(unsigned lo
 	return err;
 }
 
+static inline void process_mm_walk_lock(struct mm_struct *mm,
+					enum page_walk_lock walk_lock)
+{
+	if (walk_lock == PGWALK_RDLOCK)
+		mmap_assert_locked(mm);
+	else
+		mmap_assert_write_locked(mm);
+}
+
+static inline void process_vma_walk_lock(struct vm_area_struct *vma,
+					 enum page_walk_lock walk_lock)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	switch (walk_lock) {
+	case PGWALK_WRLOCK:
+		vma_start_write(vma);
+		break;
+	case PGWALK_WRLOCK_VERIFY:
+		vma_assert_write_locked(vma);
+		break;
+	case PGWALK_RDLOCK:
+		/* PGWALK_RDLOCK is handled by process_mm_walk_lock */
+		break;
+	}
+#endif
+}
+
 /**
  * walk_page_range - walk page table with caller specific callbacks
  * @mm:		mm_struct representing the target process of page table walk
@@ -443,7 +470,7 @@ int walk_page_range(struct mm_struct *mm
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -458,6 +485,7 @@ int walk_page_range(struct mm_struct *mm
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
+			process_vma_walk_lock(vma, ops->walk_lock);
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -533,7 +561,8 @@ int walk_page_range_vma(struct vm_area_s
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -550,7 +579,8 @@ int walk_page_vma(struct vm_area_struct
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4249,6 +4249,7 @@ static void walk_mm(struct lruvec *lruve
 	static const struct mm_walk_ops mm_walk_ops = {
 		.test_walk = should_skip_vma,
 		.p4d_entry = walk_pud_range,
+		.walk_lock = PGWALK_RDLOCK,
 	};
 
 	int err;


