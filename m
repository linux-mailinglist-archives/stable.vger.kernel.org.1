Return-Path: <stable+bounces-155187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583CAE2418
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19520168791
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE57233155;
	Fri, 20 Jun 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAa5ZyMJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61321FF28
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455339; cv=none; b=cc+qVUOB4cDDnl7MjM9cmjns7ucas35ZVVibrfLElWZi1YgubMy0u9+5PcgER6RMEqbTV6rL9K75D6ojYipF2iKYmTOxs6oK1NK7CvHSsk9HSliPjBy0+BRn/WxqA4myS9kF0qaTjEoAh+zWS1UBw2vHTF4/muDHOHuzleXtDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455339; c=relaxed/simple;
	bh=5ZAFJjGg+L1fVigARdTN0ygkj19n7AWjoL4lJmHe4HY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oilgE4qGYIjjgR3HWcjC591qw/3PTBudXkrG7WTJWORAN8fW7MoxLUSgF/MU1kq2Zu2fTYeKWKU9lVYHCbDZsx5FzpQEx+1cMIArc0osEgeMzg6unn+GxWvvVfrX33E2U4irkoAwJafwCpXX9yZ6SM6wzLUqM2BL+IapUXq9TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAa5ZyMJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450dab50afeso14375e9.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455335; x=1751060135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNKWFinVngvHtDN+QXaZyi65Vh2sjzGbbtCYoZdvWjw=;
        b=uAa5ZyMJv/IOGZYGYKNQGkQX2fQPK+pOyNOpwGLEJYbUAL+8sHxflSD8sHaQHSP626
         lwlkgMoN6mc7Ed9AdLzrCWDEjcKQb6GUGB5f0hUphNEhJljGXoATgFXZR3L5ZlCaQbRf
         9n1b2Uz1hVDPVlJt7wWJKEVDmYSzJVs8zCCfaa+TyRmuQN2Xr6Kp0JLYHYs+MrMp1iZT
         MA5zbBDvEtcSaFPXR/bLC0NX2jskL4jbW4SRjDYgo7AGfb1lCeqmMMhUsUcJ8ew1zAfF
         0Ry1Z7VA5Yybd43oCilxuAQJwtAYmB+Qiy28Nd0TDs9RRJTUbx3gRlfsqb6aEFQW7ZZm
         Zfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455335; x=1751060135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNKWFinVngvHtDN+QXaZyi65Vh2sjzGbbtCYoZdvWjw=;
        b=M9p2o5mxCYBA+qXgWUZeWo4Y6E8UNHL3MR/B/49G1R6hoaiFnKapN6os8orAkjzJPm
         8xZ3ZQhaY3iajAasWpvuN2MGr7HM7NWxMCWUwbGl84irWzBU8yq6FL0ZEod94lvcAZSD
         jEC2xROnnwq5X9/dWmz4NSjk/bkXS3znNaUmjsELVAaMYFg8jYPd2L3XROPsH4DiXMBz
         rVsyZ2WftNCBh8Vo0vfV+F0RX20UiLzQ//dHQuZQKLAFCerQjqilGXm9MpScX94887ha
         /3zOP8oPeiU5+LQpqjzVcSlcXsLURN6gx0/AmbWPERrPbmdBPTBqc7i+7P+H02ufgOMA
         cN9Q==
X-Gm-Message-State: AOJu0YwKzqq0lT521srEl+aIPpYtUTXnv6hNV1dxJh6mErWCWRzbiL3f
	RFZ1SelEWe3jiSeJKQnkBBtEgpUI/iSNBudIRwUN9WBUAq/dvwoNA2dd0vUcG871AAid9LbF2DM
	VVsPOp83d
X-Gm-Gg: ASbGncsn8HvisQnDa5Jis2crzsFVw0SgSo3hRWy0SvopZCfsKvvcd6uj+oJm8NwYUGr
	/HPD2Vpxjfl9lmBJJQZIipkePVJsmrMvVKW+SpZtbKQh5wfvmxbza/ygTYvDrU0hHa8MTWTd1kX
	OcvZcHYXDJB09eK+q6e+uCiMansTNDB9wt1RYtiq6JsO/XLZOfBtlisYmgEP3XAuAQuIVho9mL4
	L2xYv8fp7W0K4CeGfgov98XimvwwThxgX/S050ZO4Ncfkxv7tiogJRpuR0+1AptaQrM45cNsEMI
	vfPNtFuR1Uyu/3TgiCGeyEuiZzVoHZm9X2YNTGX8JFJmnAqtjP8=
X-Google-Smtp-Source: AGHT+IGdFO3ibYR5eeb6nwd8Ed+vwgYEZEtiCrs4WkMv0vlKoIxiKipp4oT5MXjhypywUAWe2EtmZA==
X-Received: by 2002:a05:600c:8593:b0:453:6962:1a72 with SMTP id 5b1f17b1804b1-4536b5514b2mr34395e9.5.1750455335096;
        Fri, 20 Jun 2025 14:35:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6d11887ebsm2990706f8f.80.2025.06.20.14.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:35:34 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/3] mm/hugetlb: unshare page tables during VMA split, not before
Date: Fri, 20 Jun 2025 23:35:30 +0200
Message-ID: <20250620213532.159985-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <2025062042-thrill-gyration-f247@gregkh>
References: <2025062042-thrill-gyration-f247@gregkh>
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
__vma_adjust, hugetlb lock wasn't used back then]
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 56 ++++++++++++++++++++++++++++++-----------
 mm/mmap.c               |  8 ++++++
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f96f10957a98..60572d423586 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -213,6 +213,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -409,6 +410,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01a685963a99..82dd31063270 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -83,7 +83,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -4165,26 +4165,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
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
@@ -6369,9 +6383,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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
@@ -6394,7 +6415,11 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
-	i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (take_locks) {
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+	} else {
+		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	}
 	for (address = start; address < end; address += PUD_SIZE) {
 		unsigned long tmp = address;
 
@@ -6407,7 +6432,9 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (take_locks) {
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
 	/*
 	 * No need to call mmu_notifier_invalidate_range(), see
 	 * Documentation/vm/mmu_notifier.rst.
@@ -6422,7 +6449,8 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 {
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
-			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
+			ALIGN_DOWN(vma->vm_end, PUD_SIZE),
+			/* take_locks = */ true);
 }
 
 #ifdef CONFIG_CMA
diff --git a/mm/mmap.c b/mm/mmap.c
index f8a2f15fc5a2..fde4ecd77413 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -833,7 +833,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 again:
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
-- 
2.50.0.rc2.701.gf1e915cc24-goog


