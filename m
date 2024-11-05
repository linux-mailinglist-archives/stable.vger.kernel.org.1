Return-Path: <stable+bounces-89884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036239BD280
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8703D1F230CE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A117BED0;
	Tue,  5 Nov 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUKP11RS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F081D90A4
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824649; cv=none; b=m9L8/pnCDqX6uSgKSnNt9QU9xDdbfjhC31rxKReCWcquvJetOVSkNq267tFlpKUFIJRUuKoAuAaXwI64yAsqCIo8WBrVZYxOiyWoOaP/U3eSCVZW7V2drp34jnWgAXEW1HHUNJIIY697mfSGOzqBJoL4B6Z8dCopJYii36gatuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824649; c=relaxed/simple;
	bh=+ZqMtK2pkIMiwyCn/8W3iJ8mHD2L/+8JWi1OSjDdcx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e5p0QNpxV08SDHci+Q3OTDLQRD5d4Eq9gjKi5JT72YvAR9LF6Wqy01FZkHwkQ4bxg2WaY4fBXk0B/as3En7FBgTJCVDwuixa+5fYi7AfSQPFU0WPqLhHgMQk8yYiDBgBo/MnKO2VjUB5iCtuWgSlHGjCS8NuaKJPZdC76fVDipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUKP11RS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF0DC4CECF;
	Tue,  5 Nov 2024 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824648;
	bh=+ZqMtK2pkIMiwyCn/8W3iJ8mHD2L/+8JWi1OSjDdcx8=;
	h=Subject:To:Cc:From:Date:From;
	b=OUKP11RSub4y+hNJKFx/XDk2lvHlNoaEk1uqAwHbbhSTwrM1MGoDphPxsMk46bnbl
	 82b5RySnGM9sPNwWPs6olsnsOFvIlnfL0pwTTWPvCbNTSYXlgVt1WpdNTlfxhiJnmx
	 6VWuYSWRKnDkNrH4SZYHIjvIP93VWoBxu9h1fQeo=
Subject: FAILED: patch "[PATCH] mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()" failed to apply to 6.6-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,axelrasmussen@google.com,dmatlack@google.com,jthoughton@google.com,lkp@intel.com,oliver.upton@linux.dev,pbonzini@redhat.com,rientjes@google.com,seanjc@google.com,stable@vger.kernel.org,stevensd@google.com,weixugc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:37:09 +0100
Message-ID: <2024110509-doable-blemish-19d2@gregkh>
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
git cherry-pick -x 1d4832becdc2cdb2cffe2a6050c9d9fd8ff1c58c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110509-doable-blemish-19d2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1d4832becdc2cdb2cffe2a6050c9d9fd8ff1c58c Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 19 Oct 2024 01:29:39 +0000
Subject: [PATCH] mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()

When the MM_WALK capability is enabled, memory that is mostly accessed by
a VM appears younger than it really is, therefore this memory will be less
likely to be evicted.  Therefore, the presence of a running VM can
significantly increase swap-outs for non-VM memory, regressing the
performance for the rest of the system.

Fix this regression by always calling {ptep,pmdp}_clear_young_notify()
whenever we clear the young bits on PMDs/PTEs.

[jthoughton@google.com: fix link-time error]
Link: https://lkml.kernel.org/r/20241019012940.3656292-3-jthoughton@google.com
Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
Reported-by: David Stevens <stevensd@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Matlack <dmatlack@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: <stable@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9342e5692dab..5b1c984daf45 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -555,7 +555,7 @@ struct lru_gen_memcg {
 
 void lru_gen_init_pgdat(struct pglist_data *pgdat);
 void lru_gen_init_lruvec(struct lruvec *lruvec);
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
@@ -574,8 +574,9 @@ static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
 
-static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+static inline bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
+	return false;
 }
 
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
diff --git a/mm/rmap.c b/mm/rmap.c
index a8797d1b3d49..73d5998677d4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -885,13 +885,10 @@ static bool folio_referenced_one(struct folio *folio,
 			return false;
 		}
 
-		if (pvmw.pte) {
-			if (lru_gen_enabled() &&
-			    pte_young(ptep_get(pvmw.pte))) {
-				lru_gen_look_around(&pvmw);
+		if (lru_gen_enabled() && pvmw.pte) {
+			if (lru_gen_look_around(&pvmw))
 				referenced++;
-			}
-
+		} else if (pvmw.pte) {
 			if (ptep_clear_flush_young_notify(vma, address,
 						pvmw.pte))
 				referenced++;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f1d33e4b360..ddaaff67642e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/mmu_notifier.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -3294,7 +3295,8 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
 	return false;
 }
 
-static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned long addr)
+static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned long addr,
+				 struct pglist_data *pgdat)
 {
 	unsigned long pfn = pte_pfn(pte);
 
@@ -3306,13 +3308,20 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
 		return -1;
 
+	if (!pte_young(pte) && !mm_has_notifiers(vma->vm_mm))
+		return -1;
+
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
+	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
+		return -1;
+
 	return pfn;
 }
 
-static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned long addr)
+static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned long addr,
+				 struct pglist_data *pgdat)
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
@@ -3324,9 +3333,15 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (WARN_ON_ONCE(pmd_devmap(pmd)))
 		return -1;
 
+	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
+		return -1;
+
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
+	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
+		return -1;
+
 	return pfn;
 }
 
@@ -3335,10 +3350,6 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 {
 	struct folio *folio;
 
-	/* try to avoid unnecessary memory loads */
-	if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
-		return NULL;
-
 	folio = pfn_folio(pfn);
 	if (folio_nid(folio) != pgdat->node_id)
 		return NULL;
@@ -3394,20 +3405,16 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		total++;
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
-		pfn = get_pte_pfn(ptent, args->vma, addr);
+		pfn = get_pte_pfn(ptent, args->vma, addr, pgdat);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent)) {
-			continue;
-		}
-
 		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		if (!ptep_clear_young_notify(args->vma, addr, pte + i))
+			continue;
 
 		young++;
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -3473,21 +3480,25 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 		/* don't round down the first address */
 		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
 
-		pfn = get_pmd_pfn(pmd[i], vma, addr);
-		if (pfn == -1)
+		if (!pmd_present(pmd[i]))
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (!walk->force_scan && should_clear_pmd_young())
+			if (!walk->force_scan && should_clear_pmd_young() &&
+			    !mm_has_notifiers(args->mm))
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
 
+		pfn = get_pmd_pfn(pmd[i], vma, addr, pgdat);
+		if (pfn == -1)
+			goto next;
+
 		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
 		if (!folio)
 			goto next;
 
-		if (!pmdp_test_and_clear_young(vma, addr, pmd + i))
+		if (!pmdp_clear_young_notify(vma, addr, pmd + i))
 			goto next;
 
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -3545,24 +3556,18 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 		}
 
 		if (pmd_trans_huge(val)) {
-			unsigned long pfn = pmd_pfn(val);
 			struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
+			unsigned long pfn = get_pmd_pfn(val, vma, addr, pgdat);
 
 			walk->mm_stats[MM_LEAF_TOTAL]++;
 
-			if (!pmd_young(val)) {
-				continue;
-			}
-
-			/* try to avoid unnecessary memory loads */
-			if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
-				continue;
-
-			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
+			if (pfn != -1)
+				walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 			continue;
 		}
 
-		if (!walk->force_scan && should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young() &&
+		    !mm_has_notifiers(args->mm)) {
 			if (!pmd_young(val))
 				continue;
 
@@ -4036,13 +4041,13 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
  * the PTE table to the Bloom filter. This forms a feedback loop between the
  * eviction and the aging.
  */
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 	int i;
 	unsigned long start;
 	unsigned long end;
 	struct lru_gen_mm_walk *walk;
-	int young = 0;
+	int young = 1;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
 	struct vm_area_struct *vma = pvmw->vma;
@@ -4058,12 +4063,15 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	lockdep_assert_held(pvmw->ptl);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
 
+	if (!ptep_clear_young_notify(vma, addr, pte))
+		return false;
+
 	if (spin_is_contended(pvmw->ptl))
-		return;
+		return true;
 
 	/* exclude special VMAs containing anon pages from COW */
 	if (vma->vm_flags & VM_SPECIAL)
-		return;
+		return true;
 
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
@@ -4071,6 +4079,9 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	start = max(addr & PMD_MASK, vma->vm_start);
 	end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
 
+	if (end - start == PAGE_SIZE)
+		return true;
+
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			end = start + MIN_LRU_BATCH * PAGE_SIZE;
@@ -4084,7 +4095,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	/* folio_update_gen() requires stable folio_memcg() */
 	if (!mem_cgroup_trylock_pages(memcg))
-		return;
+		return true;
 
 	arch_enter_lazy_mmu_mode();
 
@@ -4094,19 +4105,16 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		unsigned long pfn;
 		pte_t ptent = ptep_get(pte + i);
 
-		pfn = get_pte_pfn(ptent, vma, addr);
+		pfn = get_pte_pfn(ptent, vma, addr, pgdat);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent))
-			continue;
-
 		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		if (!ptep_clear_young_notify(vma, addr, pte + i))
+			continue;
 
 		young++;
 
@@ -4136,6 +4144,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	/* feedback from rmap walkers to page table walkers */
 	if (mm_state && suitable_to_scan(i, young))
 		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
+
+	return true;
 }
 
 /******************************************************************************


