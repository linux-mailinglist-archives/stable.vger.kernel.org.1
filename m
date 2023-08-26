Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E4B7898F2
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHZUMA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHZULe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9401AD
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7D460DFD
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D48C433C8;
        Sat, 26 Aug 2023 20:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693080689;
        bh=2j5+i7zjg4/VW4hy6+39D7xMhluSSNmwBVTqOdJMXdw=;
        h=Subject:To:Cc:From:Date:From;
        b=k5uTh/RX1/wXX5Q1NcKtX6rxzvS2wl8HChofgddyQ+tKfvbNihwYfx78N44WKaew/
         eBXlqrmk2CVAAmqH+O99Fuv5Bk1OUOonzGz9tUfxliIo9KJRhvPC2Q+w4dApbd3n+1
         FpcDhFwPTHNy+0HfeJ27EDpYxbTOF+D7DVoxWCu4=
Subject: FAILED: patch "[PATCH] mm: enable page walking API to lock vmas during the walk" failed to apply to 6.1-stable tree
To:     surenb@google.com, akpm@linux-foundation.org, dave@stgolabs.net,
        david@redhat.com, hannes@cmpxchg.org, hughd@google.com,
        jannh@google.com, ldufour@linux.ibm.com, liam.howlett@oracle.com,
        mhocko@suse.com, michel@lespinasse.org, peterx@redhat.com,
        stable@vger.kernel.org, torvalds@linuxfoundation.org,
        vbabka@suse.cz, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:11:26 +0200
Message-ID: <2023082625-monotone-traps-6498@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 49b0638502da097c15d46cd4e871dbaa022caf7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082625-monotone-traps-6498@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

49b0638502da ("mm: enable page walking API to lock vmas during the walk")
6c21e066f925 ("mm/mempolicy: Take VMA lock before replacing policy")
24139c07f413 ("mm/ksm: unmerge and clear VM_MERGEABLE when setting PR_SET_MEMORY_MERGE=0")
d7597f59d1d3 ("mm: add new api to enable ksm per process")
ddc65971bb67 ("prctl: add PR_GET_AUXV to copy auxv to userspace")
b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
d7c0e68dab98 ("mm/ksm: convert break_ksm() to use walk_page_range_vma()")
e07cda5f232f ("mm/pagewalk: add walk_page_range_vma()")
58f595c66591 ("mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE")
c31783eeae7b ("mm/pagewalk: don't trigger test_walk() in walk_page_vma()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49b0638502da097c15d46cd4e871dbaa022caf7c Mon Sep 17 00:00:00 2001
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 4 Aug 2023 08:27:19 -0700
Subject: [PATCH] mm: enable page walking API to lock vmas during the walk

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

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 0dc85556dec5..ec98e526167e 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -145,6 +145,7 @@ static int subpage_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops subpage_walk_ops = {
 	.pmd_entry	= subpage_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ea3d61de065b..161d0b34c2cb 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -102,6 +102,7 @@ static const struct mm_walk_ops pageattr_ops = {
 	.pmd_entry = pageattr_pmd_entry,
 	.pte_entry = pageattr_pte_entry,
 	.pte_hole = pageattr_pte_hole,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9c8af31be970..906a7bfc2a78 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2514,6 +2514,7 @@ static int thp_split_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops thp_split_walk_ops = {
 	.pmd_entry	= thp_split_walk_pmd_entry,
+	.walk_lock	= PGWALK_WRLOCK_VERIFY,
 };
 
 static inline void thp_split_mm(struct mm_struct *mm)
@@ -2565,6 +2566,7 @@ static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
 
 static const struct mm_walk_ops zap_zero_walk_ops = {
 	.pmd_entry	= __zap_zero_pages,
+	.walk_lock	= PGWALK_WRLOCK,
 };
 
 /*
@@ -2655,6 +2657,7 @@ static const struct mm_walk_ops enable_skey_walk_ops = {
 	.hugetlb_entry		= __s390_enable_skey_hugetlb,
 	.pte_entry		= __s390_enable_skey_pte,
 	.pmd_entry		= __s390_enable_skey_pmd,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int s390_enable_skey(void)
@@ -2692,6 +2695,7 @@ static int __s390_reset_cmma(pte_t *pte, unsigned long addr,
 
 static const struct mm_walk_ops reset_cmma_walk_ops = {
 	.pte_entry		= __s390_reset_cmma,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 void s390_reset_cmma(struct mm_struct *mm)
@@ -2728,6 +2732,7 @@ static int s390_gather_pages(pte_t *ptep, unsigned long addr,
 
 static const struct mm_walk_ops gather_pages_ops = {
 	.pte_entry = s390_gather_pages,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc744964816e..fafff1bd34cd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -757,12 +757,14 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
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
@@ -1244,6 +1246,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 static const struct mm_walk_ops clear_refs_walk_ops = {
 	.pmd_entry		= clear_refs_pte_range,
 	.test_walk		= clear_refs_test_walk,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 static ssize_t clear_refs_write(struct file *file, const char __user *buf,
@@ -1621,6 +1624,7 @@ static const struct mm_walk_ops pagemap_ops = {
 	.pmd_entry	= pagemap_pmd_range,
 	.pte_hole	= pagemap_pte_hole,
 	.hugetlb_entry	= pagemap_hugetlb_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /*
@@ -1934,6 +1938,7 @@ static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops show_numa_ops = {
 	.hugetlb_entry = gather_hugetlb_stats,
 	.pmd_entry = gather_pte_stats,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 27a6df448ee5..27cd1e59ccf7 100644
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
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2fcc9731528a..e0e59d420fca 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -386,6 +386,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops damon_mkold_ops = {
 	.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
@@ -525,6 +526,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 static const struct mm_walk_ops damon_young_ops = {
 	.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
diff --git a/mm/hmm.c b/mm/hmm.c
index 855e25e59d8f..277ddcab4947 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -562,6 +562,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
 	.pte_hole	= hmm_vma_walk_hole,
 	.hugetlb_entry	= hmm_vma_walk_hugetlb_entry,
 	.test_walk	= hmm_vma_walk_test,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 /**
diff --git a/mm/ksm.c b/mm/ksm.c
index d20d7662419b..d7b5b95e936e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -455,6 +455,12 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 
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
@@ -470,16 +476,17 @@ static const struct mm_walk_ops break_ksm_ops = {
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
@@ -565,7 +572,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr);
+		break_ksm(vma, addr, false);
 	mmap_read_unlock(mm);
 }
 
@@ -871,7 +878,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
  * in cmp_and_merge_page on one of the rmap_items we would be removing.
  */
 static int unmerge_ksm_pages(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end)
+			     unsigned long start, unsigned long end, bool lock_vma)
 {
 	unsigned long addr;
 	int err = 0;
@@ -882,7 +889,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 		if (signal_pending(current))
 			err = -ERESTARTSYS;
 		else
-			err = break_ksm(vma, addr);
+			err = break_ksm(vma, addr, lock_vma);
 	}
 	return err;
 }
@@ -1029,7 +1036,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
-						vma->vm_start, vma->vm_end);
+						vma->vm_start, vma->vm_end, false);
 			if (err)
 				goto error;
 		}
@@ -2530,7 +2537,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 		return 0;
 
 	if (vma->anon_vma) {
-		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
+		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
 	}
@@ -2668,7 +2675,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 			return 0;		/* just ignore the advice */
 
 		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
+			err = unmerge_ksm_pages(vma, start, end, true);
 			if (err)
 				return err;
 		}
diff --git a/mm/madvise.c b/mm/madvise.c
index 886f06066622..bfe0e06427bd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -233,6 +233,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 
 static const struct mm_walk_ops swapin_walk_ops = {
 	.pmd_entry		= swapin_walk_pmd_entry,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static void shmem_swapin_range(struct vm_area_struct *vma,
@@ -534,6 +535,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops cold_walk_ops = {
 	.pmd_entry = madvise_cold_or_pageout_pte_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 static void madvise_cold_page_range(struct mmu_gather *tlb,
@@ -757,6 +759,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 
 static const struct mm_walk_ops madvise_free_walk_ops = {
 	.pmd_entry		= madvise_free_pte_range,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 static int madvise_free_single_vma(struct vm_area_struct *vma,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..315fd5f45e3c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6024,6 +6024,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops precharge_walk_ops = {
 	.pmd_entry	= mem_cgroup_count_precharge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static unsigned long mem_cgroup_count_precharge(struct mm_struct *mm)
@@ -6303,6 +6304,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 
 static const struct mm_walk_ops charge_walk_ops = {
 	.pmd_entry	= mem_cgroup_move_charge_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
 };
 
 static void mem_cgroup_move_charge(void)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9a285038d765..139b31fdb678 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -831,6 +831,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 static const struct mm_walk_ops hwp_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.walk_lock = PGWALK_RDLOCK,
 };
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c53f8beeb507..ec2eaceffd74 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -718,6 +718,14 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
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
@@ -738,7 +746,7 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
 static int
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		struct list_head *pagelist, bool lock_vma)
 {
 	int err;
 	struct queue_pages qp = {
@@ -749,8 +757,10 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.end = end,
 		.first = NULL,
 	};
+	const struct mm_walk_ops *ops = lock_vma ?
+			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
-	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+	err = walk_page_range(mm, start, end, ops, &qp);
 
 	if (!qp.first)
 		/* whole range in hole */
@@ -1078,7 +1088,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
-			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+			flags | MPOL_MF_DISCONTIG_OK, &pagelist, false);
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
@@ -1321,12 +1331,8 @@ static long do_mbind(unsigned long start, unsigned long len,
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
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8365158460ed..d5f492356e3e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -279,6 +279,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 static const struct mm_walk_ops migrate_vma_walk_ops = {
 	.pmd_entry		= migrate_vma_collect_pmd,
 	.pte_hole		= migrate_vma_collect_hole,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
diff --git a/mm/mincore.c b/mm/mincore.c
index b7f7a516b26c..dad3622cc963 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -176,6 +176,7 @@ static const struct mm_walk_ops mincore_walk_ops = {
 	.pmd_entry		= mincore_pte_range,
 	.pte_hole		= mincore_unmapped_range,
 	.hugetlb_entry		= mincore_hugetlb,
+	.walk_lock		= PGWALK_RDLOCK,
 };
 
 /*
diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c21..479e09d0994c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -371,6 +371,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 {
 	static const struct mm_walk_ops mlock_walk_ops = {
 		.pmd_entry = mlock_pte_range,
+		.walk_lock = PGWALK_WRLOCK_VERIFY,
 	};
 
 	/*
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6f658d483704..3aef1340533a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -568,6 +568,7 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 	.pte_entry		= prot_none_pte_entry,
 	.hugetlb_entry		= prot_none_hugetlb_entry,
 	.test_walk		= prot_none_test,
+	.walk_lock		= PGWALK_WRLOCK,
 };
 
 int
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2022333805d3..9b2d23fbf4d3 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -400,6 +400,33 @@ static int __walk_page_range(unsigned long start, unsigned long end,
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
@@ -459,7 +486,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -474,6 +501,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
+			process_vma_walk_lock(vma, ops->walk_lock);
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -549,7 +577,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -566,7 +595,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	mmap_assert_locked(walk.mm);
+	process_mm_walk_lock(walk.mm, ops->walk_lock);
+	process_vma_walk_lock(vma, ops->walk_lock);
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..3555927df9b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4284,6 +4284,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	static const struct mm_walk_ops mm_walk_ops = {
 		.test_walk = should_skip_vma,
 		.p4d_entry = walk_pud_range,
+		.walk_lock = PGWALK_RDLOCK,
 	};
 
 	int err;

