Return-Path: <stable+bounces-155191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8138AE241D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7313B4C0427
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CE23958D;
	Fri, 20 Jun 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG9SKXhX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DEF2376EF
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455434; cv=none; b=uKIty27l6/P71RtzJjl0383jT1TY9L5Szt/GAcnVjRJa+48bEOUrVIu360kvTeA84JAW1cYfNQiSgSgxBf9PeVw9vgwLURw/k3q8lPSb6IhhxYzieiv7Xhte/ziwPnhef8iL26kX4UDDJczw6duJTUuTBIQaQ0G8LijI8R+aloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455434; c=relaxed/simple;
	bh=+j593iKlxaFPl9eco8S05LSZOahF49ZqEpeLwWJlYkI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+mA5PbJaQYMQcLJ+NlnH6fbLY5ZIDGMz9gpbuefPOv32IoJKqRz5wOd9mZxR32WnTzSNfjBWOXDRsR6ZozKQ+PPlFL0JiXLYE+5PcrfZE3XuQ57fcMji5Jwo/TildmldwZIzDsS4n1zfkrCJ799WGY3+z/UvYRfUBXSOQMDPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gG9SKXhX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453200cd31cso7665e9.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455430; x=1751060230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtIk34Ix3It4bTB0A/Wo2losLIzMSldPl9BrG66up/Q=;
        b=gG9SKXhX7OwjdSFgDepSTdRgAS0TrZ88LP83Lk5R+FZDoVIn0BbGiHnrxntTU488Lj
         Zvpi55oNjgq8sYnOPUJOq5EimdCyi7w2xQV8rsB6qMheNh/EmCFxJhYhLuel1S4RNMKM
         llFX7IC77KTEZ+i7NHHynB5Fm9Y47Ituf8DSsAqqxsx1hRquw/xfOT72uC6J9+EZu+HH
         90Ckp9EMnt7q52iTRUyhUyy2xEbPfdOdoztyqCjT196kdF1ixqihDKso5CEG8cLd9AWY
         DMlmu01MwfEHmj1fnU5fpfeH3mhu3N7RHGhc6xMPXG4hzMLslrsdXRDT9NbSZCVhnzye
         PdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455430; x=1751060230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtIk34Ix3It4bTB0A/Wo2losLIzMSldPl9BrG66up/Q=;
        b=ah2nF2Njiz2UhQzRG3NySWYx8vDhKtmg+QhGuldoKtOKshBFZkM5qIqLlCQhiTcIRM
         P5Ftni5mdLCoZ4kWTfF8ykDkEna7W2xOR0vv4W/yWUFgTj2HCOsKqq0QucVD69UOXUTh
         9DdMYzU0yLzKIHKuXNA/01EatUgiVmNSmelaYODzEX4YsL982DFWiZjLP8XhTmAY0Fzs
         WhBDcHNwMtmn3H3w6636vWjs73CfnjDx0gTFSr99YfptRBiO//92tPeAaUrdJSmEBpmQ
         eV1RzLp4t3V2EweYaLvNuV8ahWeA1ed5wQcL05K+nFP22IMq/RAcpxWuXL0DEgcGNrcg
         Kzlg==
X-Gm-Message-State: AOJu0Yx/zWOVSCwJPhNbm4mtID8Y0m5+8iOt89rMM8Hv2vB+ESHuwVBy
	iKHzHNWSCSj21PCbLg5K/UBeGd094uLrpvza5hYOthNDxuzELGUSXzPleqL2DMEy7PMy+IoEkyB
	Cmqwe91vz
X-Gm-Gg: ASbGncvck2gCrTDAsejcDp2Qov+doN1t7C37vd0iml4qqNsO1a9QXNASw5IV/tMGi01
	CUXa+0ZVWr8IetJwALNmeyHN6uj2KeDezfWoRjidgbd70/B12hBWnyL+fcWppZiGwrmJHiJSkBF
	54+hSn+0E6SDbjQDrd7Nq1Eoy2FawHLanLyop63clVIGuo80xr2+jZCNKNZ/vIucIv4h8LSNIBA
	iL5qDu22faPVGoo+ix/7/c6SqiAbidW/70Wo9l0z9dEHdja0yRORVqsTGrlYgRP60j6mLXusZLG
	t0KY2goNR3S5UMFYVVUob8t8Fl2/zAyCSrGONurZ6QGh8xveMw==
X-Google-Smtp-Source: AGHT+IF9s208M+xnjfcPQU9thNEW47acJ5dU+IQD557w12szv47LkIGbmZKsGb2QomLU8XmAkuTUdg==
X-Received: by 2002:a05:600c:1c0f:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-4536abfa310mr359355e9.2.1750455430232;
        Fri, 20 Jun 2025 14:37:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535a14221csm63980335e9.1.2025.06.20.14.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:37:09 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 2/4] mm/hugetlb: unshare page tables during VMA split, not before
Date: Fri, 20 Jun 2025 23:37:04 +0200
Message-ID: <20250620213706.161203-2-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <20250620213706.161203-1-jannh@google.com>
References: <2025062043-plunging-sculpture-7ca1@gregkh>
 <20250620213706.161203-1-jannh@google.com>
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
 include/linux/hugetlb.h |  6 +++++
 mm/hugetlb.c            | 53 +++++++++++++++++++++++++++++++----------
 mm/mmap.c               |  8 +++++++
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 90c66b9458c3..1c03935aa3d1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -188,6 +188,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
+void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -369,6 +371,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 	return 0;
 }
 
+static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
+
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1be0d9a88e6c..0711f91f5c5e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -97,7 +97,7 @@ static inline void ClearPageHugeFreed(struct page *head)
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end);
+		unsigned long start, unsigned long end, bool take_locks);
 
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
@@ -3699,26 +3699,40 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
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
@@ -5727,9 +5741,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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
@@ -5753,7 +5774,11 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
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
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
@@ -5763,7 +5788,9 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
-	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	if (take_locks) {
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
 	/*
 	 * No need to call mmu_notifier_invalidate_range(), see
 	 * Documentation/mm/mmu_notifier.rst.
diff --git a/mm/mmap.c b/mm/mmap.c
index 9f76625a1743..8c188ed3738a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -832,7 +832,15 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
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


