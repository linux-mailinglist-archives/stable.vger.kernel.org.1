Return-Path: <stable+bounces-155183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D18AE2409
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01DE16E9B1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B9230BDB;
	Fri, 20 Jun 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olY+gsrK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F95223DDE
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455094; cv=none; b=ZZx9XN14ZiFEt9t4ESUInNpIlchxjOdf5FUEzLPcG7AZntPRAjYRXho0D/g3owJ9RvLlwi/aLalqpUC5fWi8/L0l9gaxtKtnIBqLJRKrsjX5yyijbP0SAJKGY9BzCQr4fjERYtoXNDQ+kLbVjDTJcVMBUpJzY2uQIwBUepGu5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455094; c=relaxed/simple;
	bh=XwnDkIFWGdvmDeM2l7AXZUNfMCVbiDT+cUsDdjzYjKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR9AP8T9oO8zqfqFquNWw6V+VD46UJs+zYFxLAaqHmCapNoxGSk89scGkRybz8RnUNdAxShL60n5L77oGL4BWJQ4rdWXy2EvkrCEw3VGm8ns0clu4UMjsuMJguGJu7LLxvzr1SyPCONmesUwTSIqyBG5MLeOf80frhkGI73VVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olY+gsrK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so25165e9.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455091; x=1751059891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiPvxWzkSaSj0bHthyjbzJ49ZS0D0kZP53rp6c1zMxs=;
        b=olY+gsrKTB4HkFYuPaybXAOf0tq8MzJw4mqDXO3TBFgk2fPYwVJpJyKdlkImPB+WY2
         Oq8eEowBE11LElQaU9In3X6SWG6vpQbJROhfWYQk9hI9NcbJndzaEDHudT+0Oyi5affv
         id7DPaD6/xmgkDedrjLGGVcuW4qyoVduBxlvdJWOC4m08qdBaXLq+JWOMWXMpxK7mZEl
         Pwi3PsyHJJJ/6sfYB5VhmZ0GPGh1Mrc6l1HSmVgC8gNfC/xU2YmiOubeRZKoPl8SWfaI
         F/5lhJY+j0YcBsahZgOxm/Nt3amsgqTASpOXM+PbF6nUFPExe3BEtIPKh7FdoTo1hjLI
         gNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455091; x=1751059891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiPvxWzkSaSj0bHthyjbzJ49ZS0D0kZP53rp6c1zMxs=;
        b=TJe0vfn+UrkmGARMpkVLPxwxBRTEMR7nZxZTcyPniNFCarG1Lfq9hMaGQ0Mi17oxQW
         n/W+o3Gxfr41tn81PiIBKRGra2iSSQM0X31sEZxI6QIN3Jc7lOiPL1D2ezfh9kolBZ32
         Zs9cv1HqAmufX8aRK8lKqSMdIKn+iluCLhYoW3HvlLJbaeVilEA7z/cEv8lK/U2raLub
         Gi7Xg16nUz64yHB/BuSDu9ehfl2H3MiQCv1/RWL9WhpjSRlus926yuVCnwafPlOkJnms
         59Od0sHY8nPCmAlGSGl1ac+VEIgcKISJns+5vz1avU9JxoTSl8la6s6n8k3MwVm/qhrR
         TGtg==
X-Gm-Message-State: AOJu0YzCHGjYCHyQemb3L+2NHEFcIBN23IQXlKbG0q7HwpIxAmo7vd6D
	WBaFMKiZ0UtlTDuUxTAiM3VZ9VQmqZGuWbMoZdRWySSIoYE+UZ3z5MNpKdCc+x+wVU577uYxbK5
	b8WbfKiWD
X-Gm-Gg: ASbGncvgnxFrX4Bv/rNsjaByd1uFpxjFzDhpQTuN1LxpRdgjIufg5KYHSc3UZg1UI34
	43dujcwJ3iW+XUfj3VJjZJirUmYiF6UIbXHudRoEfFN76iNSjZM0qY2auqbuhHDieRSsFQ1lwbU
	/hDSFJrhsYXyiLbfAzdq/4+B4WMXhlIA+jT7Qgo3S/uQ9qtARIostx0OHThhpXb+bcoLtgbv1o4
	ZnEzqW3hZZJBshZNuBNIdVrzA1FBidalmhufrMMyKHW4f4FO1pGmMUEZ2QqsmpzU+ejQ08Elfec
	7iLFLvL8+thiksc6V3mQCb+u6s0u2Z2Zg/oKI63RcWuGGy1nKA==
X-Google-Smtp-Source: AGHT+IFgI/HYyyUherV/3YAfPPVEWIH2TpBU/nYXNiwBzAI0bvMKqVBiKmZ65icE7WKysZwEaAcTIA==
X-Received: by 2002:a05:600c:44d4:b0:453:672b:5b64 with SMTP id 5b1f17b1804b1-4536ac1f1famr232305e9.2.1750455090612;
        Fri, 20 Jun 2025 14:31:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4536466596asm37590755e9.0.2025.06.20.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:31:30 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] mm/hugetlb: unshare page tables during VMA split, not before
Date: Fri, 20 Jun 2025 23:31:27 +0200
Message-ID: <20250620213127.157399-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <2025062040-detection-sufferer-7865@gregkh>
References: <2025062040-detection-sufferer-7865@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, __split_vma() triggers hugetlb page table unsharing through
vm_ops->may_split().  This happens before the VMA lock and rmap locks are
taken - which is too early, it allows racing VMA-locked page faults in our
process and racing rmap walks from other processes to cause page tables to
be shared again before we actually perform the split.

Fix it by explicitly calling into the hugetlb unshare logic from
__split_vma() in the same place where THP splitting also happens.  At that
point, both the VMA and the rmap(s) are write-locked.

An annoying detail is that we can now call into the helper
hugetlb_unshare_pmds() from two different locking contexts:

1. from hugetlb_split(), holding:
    - mmap lock (exclusively)
    - VMA lock
    - file rmap lock (exclusively)
2. hugetlb_unshare_all_pmds(), which I think is designed to be able to
   call us with only the mmap lock held (in shared mode), but currently
   only runs while holding mmap lock (exclusively) and VMA lock

Backporting note:
This commit fixes a racy protection that was introduced in commit
b30c14cd6102 ("hugetlb: unshare some PMDs when splitting VMAs"); that
commit claimed to fix an issue introduced in 5.13, but it should actually
also go all the way back.

[jannh@google.com: v2]
  Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-1-1329349bad1a@google.com
Link: https://lkml.kernel.org/r/20250528-hugetlb-fixes-splitrace-v2-0-1329349bad1a@google.com
Link: https://lkml.kernel.org/r/20250527-hugetlb-fixes-splitrace-v1-1-f4136f5ec58a@google.com
Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>	[b30c14cd6102: hugetlb: unshare some PMDs when splitting VMAs]
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[stable backport: code got moved from mmap.c to vma.c]
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 60 ++++++++++++++++++++++++++++++-----------
 mm/mmap.c               |  6 +++++
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index fc2023d07f69..8b051b8c4034 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -281,6 +281,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -491,6 +492,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c196b754071..255bc6a1d6b0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -96,7 +96,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -4903,26 +4903,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
 		return -EINVAL;
+	return 0;
+}
 
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr)
+{
 	/*
 	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
 	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
 	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
+	 * This function is called in the middle of a VMA split operation, with
+	 * MM, VMA and rmap all write-locked to prevent concurrent page table
+	 * walks (except hardware and gup_fast()).
 	 */
+	vma_assert_write_locked(vma);
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
 	if (addr & ~PUD_MASK) {
-		/*
-		 * hugetlb_vm_op_split is called right before we attempt to
-		 * split the VMA. We will need to unshare PMDs in the old and
-		 * new VMAs, so let's unshare before we split.
-		 */
 		unsigned long floor = addr & PUD_MASK;
 		unsigned long ceil = floor + PUD_SIZE;
 
-		if (floor >= vma->vm_start && ceil <= vma->vm_end)
-			hugetlb_unshare_pmds(vma, floor, ceil);
+		if (floor >= vma->vm_start && ceil <= vma->vm_end) {
+			/*
+			 * Locking:
+			 * Use take_locks=false here.
+			 * The file rmap lock is already held.
+			 * The hugetlb VMA lock can't be taken when we already
+			 * hold the file rmap lock, and we don't need it because
+			 * its purpose is to synchronize against concurrent page
+			 * table walks, which are not possible thanks to the
+			 * locks held by our caller.
+			 */
+			hugetlb_unshare_pmds(vma, floor, ceil, /* take_locks = */ false);
+		}
 	}
-
-	return 0;
 }
 
 static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
@@ -7298,9 +7312,16 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 	}
 }
 
+/*
+ * If @take_locks is false, the caller must ensure that no concurrent page table
+ * access can happen (except for gup_fast() and hardware page walks).
+ * If @take_locks is true, we take the hugetlb VMA lock (to lock out things like
+ * concurrent page fault handling) and the file rmap lock.
+ */
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 				   unsigned long start,
-				   unsigned long end)
+				   unsigned long end,
+				   bool take_locks)
 {
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
@@ -7324,8 +7345,12 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
-	hugetlb_vma_lock_write(vma);
-	i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (take_locks) {
+		hugetlb_vma_lock_write(vma);
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	} else {
+		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	}
 	for (address = start; address < end; address += PUD_SIZE) {
 		ptep = hugetlb_walk(vma, address, sz);
 		if (!ptep)
@@ -7335,8 +7360,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
-	hugetlb_vma_unlock_write(vma);
+	if (take_locks) {
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+		hugetlb_vma_unlock_write(vma);
+	}
 	/*
 	 * No need to call mmu_notifier_arch_invalidate_secondary_tlbs(), see
 	 * Documentation/mm/mmu_notifier.rst.
@@ -7351,7 +7378,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 {
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
-			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
+			/* take_locks = */ true);
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/mmap.c b/mm/mmap.c
index 03a24cb3951d..a9c70001e456 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2402,7 +2402,13 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
 	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_split(vma, addr);
 
 	if (new_below) {
 		vma->vm_start = addr;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


