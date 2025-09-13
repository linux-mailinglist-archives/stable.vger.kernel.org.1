Return-Path: <stable+bounces-179519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A1B562A3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2F486904
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C523D7DA;
	Sat, 13 Sep 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcq3w2lQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB223D7D0
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790220; cv=none; b=n9lHaxZxOutmnFI1dCsfzuHiRT6FIwgvDYXEBR9qvDLwnQce/BHkSvqr0j83VLZkVNHK9i0vWRURXlBBgySYRMtRbqdPipHC7MW24OIg9vrLs/DWrH1ENu5PFTeIz14NyJRImaaC6A1mdluA25rgWDcUj7Rh785blvbIEyb4x84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790220; c=relaxed/simple;
	bh=+fq6LpoFm5z/f+L7e5QXbSufZuVpMjDQ2cQ7gjLRNXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCzdVkKDXvLUhq/Dy4GrvxHmb4grbSKdEIpJow8aZrpfPUjAKo9TJ3gcxbwnVmFEGDwMXEh0aLe36ZTN8p5SlEEWJooV7RDmymvph9eO1esi2DTO+2Wbkbd5y7V5BslFYtRkDxe2mBazSfUedCYEgmgy85CXwgrVhThz8Jhpa8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcq3w2lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1AFC4CEEB;
	Sat, 13 Sep 2025 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757790219;
	bh=+fq6LpoFm5z/f+L7e5QXbSufZuVpMjDQ2cQ7gjLRNXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcq3w2lQaDy0EKErJzy85l6X2tms41gTlT8CRs2F3Vqnxd6zJyUdwgdt9Sn7bycoP
	 gtmJfKf1hvZv/MINxbGMWbYTjwDUYnoT698nS0izNJH78KR8GFPVEn3B7+SFiKJnsR
	 4FNj5ARD4DJStAJHcMKpzj2tI0f3/myeOwdwjkZJYJBw+dVdJKAcDFb9f2X6ItJf5x
	 Z4l3gdwrd1mDwrynbJSiNoWBHcoGBHb/nl293QrrvEVOPs6i9zCGvGHMNsMIw7Aefr
	 RsB9yHrC6f0Arr5NZYG2rwWZNg7ihnbSxagF7mONsv9kGq9gzTBdN8UqAU5RV9KiIw
	 GAl3sKhFPRBzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Yang Shi <shy828301@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm/khugepaged: convert hpage_collapse_scan_pmd() to use folios
Date: Sat, 13 Sep 2025 15:03:36 -0400
Message-ID: <20250913190337.1520681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091344-pronounce-zoning-2e65@gregkh>
References: <2025091344-pronounce-zoning-2e65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit 5c07ebb372d66423e508ecfb8e00324f8797f072 ]

Replaces 5 calls to compound_head(), and removes 1385 bytes of kernel
text.

Link: https://lkml.kernel.org/r/20231020183331.10770-3-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 394bfac1c7f7 ("mm/khugepaged: fix the address passed to notifier on testing young")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eb46acfd3d205..0c8e87ded1d4d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1140,6 +1140,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	int result = SCAN_FAIL, referenced = 0;
 	int none_or_zero = 0, shared = 0;
 	struct page *page = NULL;
+	struct folio *folio = NULL;
 	unsigned long _address;
 	spinlock_t *ptl;
 	int node = NUMA_NO_NODE, unmapped = 0;
@@ -1221,29 +1222,28 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			}
 		}
 
-		page = compound_head(page);
-
+		folio = page_folio(page);
 		/*
 		 * Record which node the original page is from and save this
 		 * information to cc->node_load[].
 		 * Khugepaged will allocate hugepage from the node has the max
 		 * hit record.
 		 */
-		node = page_to_nid(page);
+		node = folio_nid(folio);
 		if (hpage_collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
 			goto out_unmap;
 		}
 		cc->node_load[node]++;
-		if (!PageLRU(page)) {
+		if (!folio_test_lru(folio)) {
 			result = SCAN_PAGE_LRU;
 			goto out_unmap;
 		}
-		if (PageLocked(page)) {
+		if (folio_test_locked(folio)) {
 			result = SCAN_PAGE_LOCK;
 			goto out_unmap;
 		}
-		if (!PageAnon(page)) {
+		if (!folio_test_anon(folio)) {
 			result = SCAN_PAGE_ANON;
 			goto out_unmap;
 		}
@@ -1265,7 +1265,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * has excessive GUP pins (i.e. 512).  Anyway the same check
 		 * will be done again later the risk seems low.
 		 */
-		if (!is_refcount_suitable(page)) {
+		if (!is_refcount_suitable(&folio->page)) {
 			result = SCAN_PAGE_COUNT;
 			goto out_unmap;
 		}
@@ -1275,8 +1275,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		 * enough young pte to justify collapsing the page
 		 */
 		if (cc->is_khugepaged &&
-		    (pte_young(pteval) || page_is_young(page) ||
-		     PageReferenced(page) || mmu_notifier_test_young(vma->vm_mm,
+		    (pte_young(pteval) || folio_test_young(folio) ||
+		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
 								     address)))
 			referenced++;
 	}
@@ -1298,7 +1298,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		*mmap_locked = false;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, page, writable, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.51.0


