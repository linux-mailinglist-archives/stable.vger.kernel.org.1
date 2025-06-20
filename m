Return-Path: <stable+bounces-155190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C9AE241B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 23:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2165217FF24
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A15238143;
	Fri, 20 Jun 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUj044wn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228562AD16
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455432; cv=none; b=JdImw6JO5EMQH+4+qvyRMMhS5SkLrdhCePoL55uP79UYUd/r6H4n9KxPEaioRbV4K6LhkmPV2ry3X5BL1opoI9u9vkt7+ENi58LFDwC2eOkaMZEqoSwe/DIdAhVPWR8Cljs874nf49VXLuo5fP7wm/jvTqpjaZCvIUV3wqfBsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455432; c=relaxed/simple;
	bh=bGwKO62DKZRnfwWSDZfJSVuD2XqgdpcYZxnaXd3E2Xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbY2rj2Vjq4r45T86BoTtm8mRv1aMgaqkESKTRNmHVQvsqj+BCNmMWvEuG+OLDKk6s6xEOfbDFDxTgJzt8oE4zVrLSGdd2lqu4onCH8xNuHoeTRgnzoP7IpP53a/Pwvg+9ar4rBY+BvF0M2AfQHPjwrXyjfl+idllNRgzxXze6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUj044wn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450dab50afeso14485e9.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750455429; x=1751060229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PZ1p1pZcuT5HWuv9Nu6H0Ot5N+hUaDoXLjPYmoYdIc=;
        b=BUj044wnC8LOUk30OEsrMlUx1AUJBrQweErmapdP3OKl4VINEC+PvqQOGpBxdIPISW
         o5zw5C5FdGdAtyyV0kF55RaUBY5PThVt7/8xONOY6yO+iLBmKfX4CKKEM0qrgwo27Tl2
         LGDzTWelb4oRyHjvN3QGJIb2OM8zvNd0ds+2uIncfiKzHyqY9QwEwNRoQgDm3U3wOF2p
         2zoDvPHrUPup+ym++qAaYW4B92TIan/hbCurbqlZJ+tn5PEdcC6ICsP/wsK833jcZVcN
         nlR7FazNEPtJeOMvYCxKpRyMN84owg51jJ9ZwzQ42x07pISE1oCNsKAq6YVGYolOd6Ar
         k2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455429; x=1751060229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PZ1p1pZcuT5HWuv9Nu6H0Ot5N+hUaDoXLjPYmoYdIc=;
        b=SR9xW9LElJD8OXKAeV18NWceNmx8WuT2bsyBvN41FvNmhi9b6ZoPi1jEDmBB0xuMtU
         fIe2KsmjfAp6in4OJIb5Dwj95Ni/DLhuVzSwOlCRK0C5wl3b6rsWJeheAOw4rOV8P6rs
         P6vK2S5pBQxcsurx2SL3PS7Fu5J4XwXp2+7I128PkG4TFvLDiy2d70NsNqN4KYsbnkvf
         oPrcUZHcp9FeRBMGffN/84HRkQf3AT9S0ZnzlBCRbK4BP20Fl0Bzf3pXv+qyzYIPgWtm
         IBQvg5i6Z3jXdpAoNoytUJU/xDddM252bedy09n3q/xbFd+EXykrCRdtrlv9zaJYcRBp
         tYuQ==
X-Gm-Message-State: AOJu0Yz2MtLcHq0a9q0BrTQRxmHyiZnIFR25hnGOi6ts2DlHzVkApSdo
	zQBN0kVn81/LJy+LAzsUQw1HooBL89Uvpj+s4XrFgcyoGxJmaTZYOIyEoVHDmUQtRoCKk7U0eyN
	ZOUwg//Lv
X-Gm-Gg: ASbGncs2YqWpdsj8yIIqEXrFciQ+2Ijd0J2n/bByDpyFCc/Op/fbc2ltEl/wn5RYUTQ
	5Nr1b+RFzxYiYoCBGeTYENkGMlqz2W2Tsb1ThfbfXLFZDouZgz4DBu65ZOkfc1vYElhYEn9wY1N
	H0Sww2zFa6yrXYLHsMc4IrdSSbNmdDsC0UfJgTnaXDEPzLBkAIWsxrmWGEiMYQXLZ2ROzegmgv+
	pj+tkBR80/aBibPymt4Dnfc1NFRbjf7XPN0Q9BfBjW2LaV4C78IGtMvPuRBpnfhleLTvXooIEC7
	wtceOvJmDwBu2Lcr8Mln6nmCBROdM2m/jGwY8SvW6WUIFgq5BQ==
X-Google-Smtp-Source: AGHT+IGtXC8B4f9ZXuhRSuPEW0YKVHYaCD7IEOMEFVMZauweY/H0tuLRhwlg6dAhngaZqsoR/XmO4g==
X-Received: by 2002:a05:600c:8112:b0:442:feea:622d with SMTP id 5b1f17b1804b1-4536b54b58fmr82375e9.1.1750455429226;
        Fri, 20 Jun 2025 14:37:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:83c5:7af8:c033:2ca6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535ead2a84sm70055275e9.32.2025.06.20.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:37:08 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 1/4] hugetlb: unshare some PMDs when splitting VMAs
Date: Fri, 20 Jun 2025 23:37:03 +0200
Message-ID: <20250620213706.161203-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
In-Reply-To: <2025062043-plunging-sculpture-7ca1@gregkh>
References: <2025062043-plunging-sculpture-7ca1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Houghton <jthoughton@google.com>

commit b30c14cd61025eeea2f2e8569606cd167ba9ad2d upstream.

PMD sharing can only be done in PUD_SIZE-aligned pieces of VMAs; however,
it is possible that HugeTLB VMAs are split without unsharing the PMDs
first.

Without this fix, it is possible to hit the uffd-wp-related WARN_ON_ONCE
in hugetlb_change_protection [1].  The key there is that
hugetlb_unshare_all_pmds will not attempt to unshare PMDs in
non-PUD_SIZE-aligned sections of the VMA.

It might seem ideal to unshare in hugetlb_vm_op_open, but we need to
unshare in both the new and old VMAs, so unsharing in hugetlb_vm_op_split
seems natural.

[1]: https://lore.kernel.org/linux-mm/CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com/

Link: https://lkml.kernel.org/r/20230104231910.1464197-1-jthoughton@google.com
Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[backport notes: I believe the "Fixes" tag is somewhat wrong - kernels
before that commit already had an adjust_range_if_pmd_sharing_possible()
that assumes that shared PMDs can't straddle page table boundaries.
huge_pmd_unshare() takes different parameter type]
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/hugetlb.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02b7c8f9b0e8..1be0d9a88e6c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -96,6 +96,8 @@ static inline void ClearPageHugeFreed(struct page *head)
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end);
 
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
@@ -3697,6 +3699,25 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
 		return -EINVAL;
+
+	/*
+	 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
+	 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this
+	 * split, unshare PMDs in the PUD_SIZE interval surrounding addr now.
+	 */
+	if (addr & ~PUD_MASK) {
+		/*
+		 * hugetlb_vm_op_split is called right before we attempt to
+		 * split the VMA. We will need to unshare PMDs in the old and
+		 * new VMAs, so let's unshare before we split.
+		 */
+		unsigned long floor = addr & PUD_MASK;
+		unsigned long ceil = floor + PUD_SIZE;
+
+		if (floor >= vma->vm_start && ceil <= vma->vm_end)
+			hugetlb_unshare_pmds(vma, floor, ceil);
+	}
+
 	return 0;
 }
 
@@ -5706,6 +5727,50 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	}
 }
 
+static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
+				   unsigned long start,
+				   unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+	unsigned long sz = huge_page_size(h);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long address;
+	spinlock_t *ptl;
+	pte_t *ptep;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	if (start >= end)
+		return;
+
+	flush_cache_range(vma, start, end);
+	/*
+	 * No need to call adjust_range_if_pmd_sharing_possible(), because
+	 * we have already done the PUD_SIZE alignment.
+	 */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+	for (address = start; address < end; address += PUD_SIZE) {
+		ptep = huge_pte_offset(mm, address, sz);
+		if (!ptep)
+			continue;
+		ptl = huge_pte_lock(h, mm, ptep);
+		huge_pmd_unshare(mm, vma, &address, ptep);
+		spin_unlock(ptl);
+	}
+	flush_hugetlb_tlb_range(vma, start, end);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	/*
+	 * No need to call mmu_notifier_invalidate_range(), see
+	 * Documentation/mm/mmu_notifier.rst.
+	 */
+	mmu_notifier_invalidate_range_end(&range);
+}
+
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


