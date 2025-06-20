Return-Path: <stable+bounces-155184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C58AE240B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F25A6480
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B637225390;
	Fri, 20 Jun 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emn+j6lx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9D30E859
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455222; cv=none; b=geXv2ikhgPSL6fZ31L6B3aNmFRZEUH2AFOgfCh8rlfGqZMj27hAVhGwAVN5DyUFVqoOqGJDODj4sa0GRzJe8zIBLrjNFA3euTwoUmitlO/PTWXmxojArdIUcHNyW5VDYqCd2wbEtraQDLW1zQiAiNWFM25FOBZyH85WgH4q9H5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455222; c=relaxed/simple;
	bh=DBJ3PmBQMQQFEYZK/AYVlopYcgFr1nxXeI4wnLdZDu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t847nIy2cWSFbf0WVGVkK/Xqt85l7qrVJqe3iiGXiYkUjme9tnYFW5pYTHNFrMhS4I730IxaIFZcQV9yNgFCtSTxV9uo2CdfmUaJ1tMjYu4D1dVXSL31oNomMjf9EUsZixcii5WD6acyd143WN1nvhfUwRP6sGzCoul8fZnGw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emn+j6lx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7365e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455218; x=1751060018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ghn6D06TNzCC825VD43BfhgjGR1h5O1ti3uiGRUIr/E=;
        b=emn+j6lx3m5RV4IT1KZd2d7Rd88s8LrXnuWo2LXqgkAIc/5jZ6tHG1snVvMiYnfXhp
         TZL/a8F6SwK5SETfFoiDmrR7smAUCS2S+DJq/kHiU9oeno/V9mxChLoKtQlSCOIfdOO2
         kVlNejOCFoyBWd4r2c0N8xoHpU4GiBXaYaPH4cQyUVlWqegVXgbCQOK7JmobGFGqESuj
         d3Y6a4VoSB62vSTaUz+Kc9zqbWPjddraw4FDdsOiU0EqYEB9Jf7TLxwQaRng/Q1wtWuR
         +dr+YU6vjb493O/AqhoSxgFBGHOjIH0TC8+cHJvSrJwvXS4DcyCTv4mB8aOj+DcBageo
         NVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455218; x=1751060018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghn6D06TNzCC825VD43BfhgjGR1h5O1ti3uiGRUIr/E=;
        b=WMxIn6u4CWvKIuozVLfGR92GHeJ3UHJh0r/ZF01lRq3kRRoxbYjBzF7Ty/sYH0Lt7i
         zOPew2laNVsGMW2T3OvvAOzhqxEg8tVqWkAQtgjKXgJE4ulXU9uowpH8ck02GFhmrNqK
         scScuMCJAvi0USmtILqf4DxFwrckFiXaz3qW0eugwxNoYG6drzxg2gDY0mINp7PVlEtk
         CIavt3mURXSK55rcAW3R9+xP5ZrgCpctzn5gYNBL+rtFtMeyQ5UGA/AONs92jiJ++P56
         sdvYMBGgOEufD/6fJsnDj71oqRXSVdGfo+sXumtGLWdHQwZepknkEAivsNmoK9JvhEaA
         efrA==
X-Gm-Message-State: AOJu0YwxYn9BiiZ3rf4qm2qvuC71JZn0cmBT0FAmw9aeegeJeHNGAElP
	I8Z+RrL8ZpLNj9+tyk067ZnqQPlCGwMMWOWVf7FzFvV1Th3T2etm4rE2x4hHe6QtdswYzu5303S
	btoIwk484
X-Gm-Gg: ASbGncuC5of1MnTpyCes8RKVXFahe0XtCiHoSXzngrw/RphVjc+FFDgWn61LCLWgawV
	i9dQm416zgMw+DLyY4kaTzJOp8ho3mg1uIgoHsYlBqgyomYKJbU5lZ+IAxN9NGxjldTQTE6XYjt
	k9mtnDfn1Vwed/bcdkXCqwf5wF2xAXkoJDq+1ZaaR6gQkuv+wHR9Cew+HdxuNDh77wn1kEwWJTF
	Hsc9JT8zIs0esX0aubWb2fRd5adpZSz5C3WRVd+mM3TX6pV/zEZVIX+mXu+x3zkUfKg/h4c+leC
	2idh0JNscErsFMgxCOniuKWtQkEwlEHliNZr6O9H9I/Mdy57j/xpIR5nSUbI
X-Google-Smtp-Source: AGHT+IFopWvtrQAycWoy1OoInACeLz5QNrzGyAWZQ22PSx21MM0wzMaKY5gnTDqVUFbJMDTpEejXUg==
X-Received: by 2002:a05:600c:8593:b0:453:6962:1a72 with SMTP id 5b1f17b1804b1-4536b5514b2mr28935e9.5.1750455218201;
        Fri, 20 Jun 2025 14:33:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6d11906d6sm2975319f8f.85.2025.06.20.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:33:37 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/3] mm/hugetlb: unshare page tables during VMA split, not before
Date: Fri, 20 Jun 2025 23:33:31 +0200
Message-ID: <20250620213334.158850-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <2025062041-uplifted-cahoots-6c42@gregkh>
References: <2025062041-uplifted-cahoots-6c42@gregkh>
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
[stable backport: code got moved around, VMA splitting is in
__vma_adjust]
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 60 ++++++++++++++++++++++++++++++-----------
 mm/mmap.c               |  8 ++++++
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cc555072940f..26f2947c399d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -239,6 +239,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -472,6 +473,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 14b9494c58ed..fc5d3d665266 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -95,7 +95,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -4900,26 +4900,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
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
+	mmap_assert_write_locked(vma->vm_mm);
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
@@ -7495,9 +7509,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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
@@ -7521,8 +7542,12 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
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
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
@@ -7532,8 +7557,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
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
 	 * No need to call mmu_notifier_invalidate_range(), see
 	 * Documentation/mm/mmu_notifier.rst.
@@ -7548,7 +7575,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 {
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
-			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
+			/* take_locks = */ true);
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/mmap.c b/mm/mmap.c
index ebc3583fa612..0f303dc8425a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -727,7 +727,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		return -ENOMEM;
 	}
 
+	/*
+	 * Get rid of huge pages and shared page tables straddling the split
+	 * boundary.
+	 */
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
+	if (is_vm_hugetlb_page(orig_vma)) {
+		hugetlb_split(orig_vma, start);
+		hugetlb_split(orig_vma, end);
+	}
 	if (file) {
 		mapping = file->f_mapping;
 		root = &mapping->i_mmap;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


