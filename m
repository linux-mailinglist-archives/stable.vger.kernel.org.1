Return-Path: <stable+bounces-155182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739BAE2406
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F226D3B18BE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67D20102C;
	Fri, 20 Jun 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nqfxZhC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920533E7
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455053; cv=none; b=CmAQDYtHb2oP+miduV+mckbKIkr/RuJmj1P5zrs9Fq1paslvW0wOADFsqBdmoCxJMXe5kG4WKHbcK0e5jAOzZpyHAb+WihKwQP1+jfaeytl8+bPD5zfMSwF4zA+XZj1hOikOpYsbxYgkoBerTMgltWQRXE7ZMB+vl/4q6ylNyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455053; c=relaxed/simple;
	bh=vWQvtkHDLt6On6Jy0rkfyeoBrkEj3JgjtG/BJmID0YQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K24YujN7Jo8SXUwicpb+gZy/QIPXDqeNF1RthR821QV9g3qPirWe9fKCJng1nIWASrYRwyb16s6EhDm1HQ3ZjeH+nXqWFN6A9kSYqkm2LsgfigCIC0x76l4Y+DJA22oOwfgNs8O2bYVdELyXWIQdChNR+J6/b1nqG9OxwMqj7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nqfxZhC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7295e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455050; x=1751059850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j3yePhsYN/edlpUwejz+0k9xUNOtlB16HsojbYcdZA=;
        b=0nqfxZhCf/zN6vQiuje0ZmbsdbnXZzBU3QMoVbCrsQHRZDKfeixvNrHP/9yWENMpXL
         zwL5FEnSXO5hwIP6Z+f055kvLfOZ+ySgb0jl6xvdn/i/JyfbI+auzX2Zhx79LoW7HIcJ
         ge3lCu9CTwNKu82JDI6UkQBk/L8XVoMtFOIjDyLKKXuMtw2mQjQK9B2Ge43UYF4N9jmF
         KXMjL97mtSt8Cx3Veg5lA56rCiQik94QftCS05bA0c9DPXP+pDR5VYLTVJjNAprdyCEq
         n2oLmLzodcYnY0HRoA3Aih5892N8nzusxkcURZHtQfrMG3vhjJXgpudXeykArLL+bvd7
         EY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455050; x=1751059850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j3yePhsYN/edlpUwejz+0k9xUNOtlB16HsojbYcdZA=;
        b=brkdz+DC7cSLg/yNu870pwJBxo2EqxAaK256Qx6C4bc2ZNQNgcgZA5UnZvAuSiq3/O
         QLT54Pz59lNoFiYtI1eSEfOM0OpYMsISbAAf2DFATmFIgXCZBfZx1eTk5CR3dXSrywU+
         /rq1sobiQfNibCnM2ITcBpUqKzdGCybmAyiBkYH/mpO+bNTsjiKTHQziCUYtEPlK7w45
         feljEcFUVIvxbYsBtj66nDMTL0IdkjkWi5gHJaV+yx7VOfYCbnSPh/bEbzLguCWxo5at
         HsBQ1aNs4izF/WNAc6buZ/NOCYbniAxLFpwnTIUjYj9VX3nDVyPGnF2iuIOwDLpGAGVq
         cmqg==
X-Gm-Message-State: AOJu0YwZQG5CLUJpycMQ3N/hJicaWuS4NkseaO+i/7j9CDe+Ucn4dao4
	EgZaqBhtVu8i7WMCKQsLxER4ncDcMtRYp4iTbVO7Tbc2R2hf42JZk8DA1scmkg5xFCt0YcGl8+L
	1+ijgbqEI
X-Gm-Gg: ASbGncszJjYpV/C63qDJFLhnlaGWYTQBnJjY6gh7XROhw64N3qiMq6W+vt9TrLJI9LS
	lnhDsKqmdajrJaYBgvAovTdLz2FvbugyMu8x+LexMDOT6t1NAck/m/sgaJ/SMU4UBGR7NvDUQFQ
	SumRGyup8DXTG3+UIHyLGhp2+2mvdQu5yy4N429vqfeAN4ixK3Um9btLM6D6c9Ah0lD+jGAZcK6
	+RLlytBJTAZ/ORyZxwxQQbsGcCJjelBRuJMyHlETVuaenCzIcD9tkFLyUTqEn1AJzwuJw4hy2HS
	JPIkJhJi33Gv59Y/qYbthebrrKy7qXuwob58h+gZjOm5qbRIJFBwvC6VCP7O
X-Google-Smtp-Source: AGHT+IFb418JJfOR9G6i0Gg/Gc8Jt4iW6cppzIjJV8z2+NOebyoRgX2QyY/UFJEpw/1K1jeO5DTJkw==
X-Received: by 2002:a05:600c:c04c:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-4536ab32a7bmr155285e9.0.1750455049331;
        Fri, 20 Jun 2025 14:30:49 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6d117e520sm3030426f8f.56.2025.06.20.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:30:48 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] mm/hugetlb: unshare page tables during VMA split, not before
Date: Fri, 20 Jun 2025 23:30:43 +0200
Message-ID: <20250620213043.156894-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <2025062039-jet-eskimo-201a@gregkh>
References: <2025062039-jet-eskimo-201a@gregkh>
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
[stable backport: added missing include]
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/hugetlb.h          |  3 ++
 mm/hugetlb.c                     | 60 +++++++++++++++++++++++---------
 mm/vma.c                         |  7 ++++
 mm/vma_internal.h                |  1 +
 tools/testing/vma/vma_internal.h |  2 ++
 5 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 12f7a7b9c06e..3897f4492e1f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -272,6 +272,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -465,6 +466,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ad646fe6688a..05f5bf27f600 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -87,7 +87,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static void hugetlb_free_folio(struct folio *folio)
@@ -5071,26 +5071,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
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
@@ -7484,9 +7498,16 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
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
@@ -7510,8 +7531,12 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
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
@@ -7521,8 +7546,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
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
@@ -7537,7 +7564,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 {
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
-			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
+			/* take_locks = */ true);
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/vma.c b/mm/vma.c
index 9b4517944901..1d82ec4ee7bb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -416,7 +416,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
+
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
 	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	if (is_vm_hugetlb_page(vma))
+		hugetlb_split(vma, addr);
 
 	if (new_below) {
 		vma->vm_start = addr;
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index b930ab12a587..1dd119f266e6 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/huge_mm.h>
+#include <linux/hugetlb.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/kernel.h>
 #include <linux/khugepaged.h>
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..1d5bbc8464f1 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -735,6 +735,8 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	(void)adjust_next;
 }
 
+static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
+
 static inline void vma_iter_free(struct vma_iterator *vmi)
 {
 	mas_destroy(&vmi->mas);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


