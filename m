Return-Path: <stable+bounces-109552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E798DA16ED8
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093B57A418C
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30591E47BE;
	Mon, 20 Jan 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQgceKkq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C351E47B4
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384695; cv=none; b=Lq5kaGap4JyIEM1ws93z9lI2vapBw/fYBp9ZaatRek2oSXpOU/GHWgkOAY2bTswf26HbEEMXtioLSroNSCKBUqJiALZ2vrLyXmcv7/QFw2jvTvV54A5vK4J9RgaCy/vjoKuC4RXsKYh6+uSlGTlByE7/aiFwEFhqt0FWc22PD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384695; c=relaxed/simple;
	bh=k+Ji2zeOL2em3dGyVB6p8WfAx9Z40Tf8U/WrwVjBV2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PFZ+xSNI0248JNbkCl9dLrU8IgJ6rGufxgKk7PwStwDChdl9For1TkGXKd6AMsb/9eMNhjf9yr7FQvwxPwZvF28VuiNZv+dh1qwXLWVsvmjbie9Wvz4C2GZvNnBmFyCildIztEphDA/9l3zbFhO6mJoYFFsi8uJg+f/5kkIOx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQgceKkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F38C4CEDD;
	Mon, 20 Jan 2025 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737384695;
	bh=k+Ji2zeOL2em3dGyVB6p8WfAx9Z40Tf8U/WrwVjBV2s=;
	h=Subject:To:Cc:From:Date:From;
	b=eQgceKkqTgrNYV4a0A6W3Mvn41mcdTYpG2gIU6CsK4tertOlhtJp8EexSN4e+BEgt
	 dtj+nfUxXrh4UDLg7c6aZAaqThX/i1eJcfv8KiCsjVTFzUhgSSATizRu4NwnK24Edg
	 +DZ6l4dCLcH8+OcmOfZdeIUFv1aL4aKvQyRfAZuo=
Subject: FAILED: patch "[PATCH] mm: clear uffd-wp PTE/PMD state on mremap()" failed to apply to 6.6-stable tree
To: ryan.roberts@arm.com,Liam.Howlett@Oracle.com,akpm@linux-foundation.org,david@redhat.com,jannh@google.com,lorenzo.stoakes@oracle.com,mark.rutland@arm.com,miko.lenczewski@arm.com,muchun.song@linux.dev,peterx@redhat.com,shuah@kernel.org,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 15:51:32 +0100
Message-ID: <2025012032-buffoon-cabbie-1e42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0cef0bb836e3cfe00f08f9606c72abd72fe78ca3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012032-buffoon-cabbie-1e42@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cef0bb836e3cfe00f08f9606c72abd72fe78ca3 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Tue, 7 Jan 2025 14:47:52 +0000
Subject: [PATCH] mm: clear uffd-wp PTE/PMD state on mremap()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When mremap()ing a memory region previously registered with userfaultfd as
write-protected but without UFFD_FEATURE_EVENT_REMAP, an inconsistency in
flag clearing leads to a mismatch between the vma flags (which have
uffd-wp cleared) and the pte/pmd flags (which do not have uffd-wp
cleared).  This mismatch causes a subsequent mprotect(PROT_WRITE) to
trigger a warning in page_table_check_pte_flags() due to setting the pte
to writable while uffd-wp is still set.

Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
such mremap() so that the values are consistent with the existing clearing
of VM_UFFD_WP.  Be careful to clear the logical flag regardless of its
physical form; a PTE bit, a swap PTE bit, or a PTE marker.  Cover PTE,
huge PMD and hugetlb paths.

Link: https://lkml.kernel.org/r/20250107144755.1871363-2-ryan.roberts@arm.com
Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index cb40f1a1d081..75342022d144 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -247,6 +247,13 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	    vma_is_shmem(vma);
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	return uffd_ctx && (uffd_ctx->features & UFFD_FEATURE_EVENT_REMAP) == 0;
+}
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 void dup_userfaultfd_fail(struct list_head *);
@@ -402,6 +409,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e53d83b3e5cf..db64116a4f84 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2206,6 +2206,16 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 	return pmd;
 }
 
+static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
+{
+	if (pmd_present(pmd))
+		pmd = pmd_clear_uffd_wp(pmd);
+	else if (is_swap_pmd(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+
+	return pmd;
+}
+
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
@@ -2244,6 +2254,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		pmd = move_soft_dirty_pmd(pmd);
+		if (vma_has_uffd_without_event_remap(vma))
+			pmd = clear_uffd_wp_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
 		if (force_flush)
 			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c498874a7170..eaaec19caa7c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5402,6 +5402,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
 			  unsigned long sz)
 {
+	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
@@ -5418,7 +5419,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
+
+	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+		huge_pte_clear(mm, new_addr, dst_pte, sz);
+	else {
+		if (need_clear_uffd_wp) {
+			if (pte_present(pte))
+				pte = huge_pte_clear_uffd_wp(pte);
+			else if (is_swap_pte(pte))
+				pte = pte_swp_clear_uffd_wp(pte);
+		}
+		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
+	}
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
diff --git a/mm/mremap.c b/mm/mremap.c
index 60473413836b..cff7f552f909 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -138,6 +138,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		struct vm_area_struct *new_vma, pmd_t *new_pmd,
 		unsigned long new_addr, bool need_rmap_locks)
 {
+	bool need_clear_uffd_wp = vma_has_uffd_without_event_remap(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	pmd_t dummy_pmdval;
@@ -216,7 +217,18 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 			force_flush = true;
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
-		set_pte_at(mm, new_addr, new_pte, pte);
+
+		if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+			pte_clear(mm, new_addr, new_pte);
+		else {
+			if (need_clear_uffd_wp) {
+				if (pte_present(pte))
+					pte = pte_clear_uffd_wp(pte);
+				else if (is_swap_pte(pte))
+					pte = pte_swp_clear_uffd_wp(pte);
+			}
+			set_pte_at(mm, new_addr, new_pte, pte);
+		}
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -278,6 +290,15 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
 		return false;
 
+	/* If this pmd belongs to a uffd vma with remap events disabled, we need
+	 * to ensure that the uffd-wp state is cleared from all pgtables. This
+	 * means recursing into lower page tables in move_page_tables(), and we
+	 * can reuse the existing code if we simply treat the entry as "not
+	 * moved".
+	 */
+	if (vma_has_uffd_without_event_remap(vma))
+		return false;
+
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
@@ -333,6 +354,15 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
+	/* If this pud belongs to a uffd vma with remap events disabled, we need
+	 * to ensure that the uffd-wp state is cleared from all pgtables. This
+	 * means recursing into lower page tables in move_page_tables(), and we
+	 * can reuse the existing code if we simply treat the entry as "not
+	 * moved".
+	 */
+	if (vma_has_uffd_without_event_remap(vma))
+		return false;
+
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.


