Return-Path: <stable+bounces-147904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A8AC5F9E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89C64C2FD7
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC043147;
	Wed, 28 May 2025 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ISo2mLCY"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7FEE567;
	Wed, 28 May 2025 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399764; cv=none; b=kXmeUlOAMy+FOcNAn3CBZmliftmXMFOuFXrffwLOtK9f/qAY1rIXWQpma0vqTVyl8Prh0nLk65pb+BtLEO8e0h89kGW0t2wRp4Jho532oeqJi9/95RMlEe2FyCpo211NPhY8DTVlhFMIbCSiNr+MmEJgMdxaJaz0389t6iuPU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399764; c=relaxed/simple;
	bh=41R474C98atLcyw+gNjpZAZvD6TZuPEzSD2Qh8KTop4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ix1AxCWNgdpVIW/rcVRbXs8YNjGEqTpmY9NO98iWBSo7GMUOklY8RZoV4ynbMEEjUJc+UOS4Dlv9uU7ShAt8bwKSIA8JtoY8xmZy4hVyrgyqddhFIag6lbohVO91s4sCDww77Pn5mpdd1F6ZlfHz/Fi1QCSuG7N+RzPHHMyAbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ISo2mLCY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xBWi4IQ15ST0BjHUIRly0HLO0C7dG6iOMz8SBird500=; b=ISo2mLCY5l8NfKQwVEgxdP2xrS
	bDKg5aOBL2CCRULeKp+OxcgQDj5MalphkaKxkBuAAl7/AeENs/948I+/Ne8jYhu05n6jirozuwTv/
	1Q0sVCxWm+gAjk6fo/wCTkW4sZtwpuzE+RAp2FXuYh8IJAZBWnat/X+ZGsHdoqIGMIR5yYXGIrC1U
	1KykLT5IgIAETFGZAi/hzbHJJ0I/4A+FR9spcVe1TJ+UFVrgLI1xtn7MMDnDtNlXZVdSZ04nhG3xM
	Wjb8PR1grcReH5HaQvfUuixufvpO5a98cUg0FAXtkfY0tbZco7TK1OjEk6U4jUSC75JUVaCcHQNvB
	NxuKRHbQ==;
Received: from 114-44-251-207.dynamic-ip.hinet.net ([114.44.251.207] helo=gavin-HP-Z840-Workstation..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uK6e3-00E25A-2X; Wed, 28 May 2025 04:35:55 +0200
From: Gavin Guo <gavinguo@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	mike.kravetz@oracle.com,
	kernel-dev@igalia.com,
	Gavin Guo <gavinguo@igalia.com>,
	stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and hugetlb_fault_mutex_table
Date: Wed, 28 May 2025 10:33:26 +0800
Message-ID: <20250528023326.3499204-1-gavinguo@igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is ABBA dead locking scenario happening between hugetlb_fault()
and hugetlb_wp() on the pagecache folio's lock and hugetlb global mutex,
which is reproducible with syzkaller [1]. As below stack traces reveal,
process-1 tries to take the hugetlb global mutex (A3), but with the
pagecache folio's lock hold. Process-2 took the hugetlb global mutex but
tries to take the pagecache folio's lock.

Process-1                               Process-2
=========                               =========
hugetlb_fault
   mutex_lock                  (A1)
   filemap_lock_hugetlb_folio  (B1)
   hugetlb_wp
     alloc_hugetlb_folio       #error
       mutex_unlock            (A2)
                                        hugetlb_fault
                                          mutex_lock                  (A4)
                                          filemap_lock_hugetlb_folio  (B4)
       unmap_ref_private
       mutex_lock              (A3)

Fix it by releasing the pagecache folio's lock at (A2) of process-1 so
that pagecache folio's lock is available to process-2 at (B4), to avoid
the deadlock. In process-1, a new variable is added to track if the
pagecache folio's lock has been released by its child function
hugetlb_wp() to avoid double releases on the lock in hugetlb_fault().
The similar changes are applied to hugetlb_no_page().

Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Cc: <stable@vger.kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Florent Revest <revest@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
---
V1 -> V2
Suggested-by Oscar Salvador:
  - Use folio_test_locked to replace the unnecessary parameter passing.
V2 -> V3
- Dropped the approach suggested by Oscar.
- Refine the code and git commit suggested by Gavin Shan.

 mm/hugetlb.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6a3cf7935c14..560b9b35262a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6137,7 +6137,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
 static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
-		       struct vm_fault *vmf)
+		       struct vm_fault *vmf,
+		       bool *pagecache_folio_locked)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct mm_struct *mm = vma->vm_mm;
@@ -6234,6 +6235,18 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 			u32 hash;
 
 			folio_put(old_folio);
+			/*
+			 * The pagecache_folio has to be unlocked to avoid
+			 * deadlock and we won't re-lock it in hugetlb_wp(). The
+			 * pagecache_folio could be truncated after being
+			 * unlocked. So its state should not be reliable
+			 * subsequently.
+			 */
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				if (pagecache_folio_locked)
+					*pagecache_folio_locked = false;
+			}
 			/*
 			 * Drop hugetlb_fault_mutex and vma_lock before
 			 * unmapping.  unmapping needs to hold vma_lock
@@ -6588,7 +6601,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_wp(folio, vmf);
+		ret = hugetlb_wp(folio, vmf, NULL);
 	}
 
 	spin_unlock(vmf->ptl);
@@ -6660,6 +6673,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
+	bool pagecache_folio_locked = true;
 	struct vm_fault vmf = {
 		.vma = vma,
 		.address = address & huge_page_mask(h),
@@ -6814,7 +6828,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			ret = hugetlb_wp(pagecache_folio, &vmf);
+			ret = hugetlb_wp(pagecache_folio, &vmf,
+					&pagecache_folio_locked);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
 			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
@@ -6832,7 +6847,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(vmf.ptl);
 
 	if (pagecache_folio) {
-		folio_unlock(pagecache_folio);
+		if (pagecache_folio_locked)
+			folio_unlock(pagecache_folio);
+
 		folio_put(pagecache_folio);
 	}
 out_mutex:

base-commit: 914873bc7df913db988284876c16257e6ab772c6
-- 
2.43.0


