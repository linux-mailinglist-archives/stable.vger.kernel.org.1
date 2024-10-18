Return-Path: <stable+bounces-86869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BC79A448E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1308F1F21EF2
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A15204013;
	Fri, 18 Oct 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQfK/Ubz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C5204011
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272425; cv=none; b=PlNs+ocmfLDHZwliQyCQNkzbZ9EQQTMADaJcpWAn4mAfem58rk6G3q2CdgddBZBz48qB6T3sgu/0TRT5SIKu4VowOhjd6G4Stp5ZXvqIxpaFnQbzAcPPGBWDEjCLlmiaYsOVOZNusMi3Jk25Bj9ySXk7aO4AmcO8qjG/bO7jEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272425; c=relaxed/simple;
	bh=w7kB5wib5tndfp7xuvkvAYZPeetX211sxv2O+JjC7+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfDsX77KjEWwA45meK6t06jehuv8dYVv7nZbjclTzdXSmtPMsAbujSL4kNPHQ2BgKd+iszS2rQQTPcnXbJ78w0kgJEzM5WytMxDqQeNz/RGjVjJNIZE9wOCCDyQI8HJv+E9pZPvACu/XQ0PufL5IlEeFYNT7R0yjU2V5yRnXkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQfK/Ubz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD7C4CEC5;
	Fri, 18 Oct 2024 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729272425;
	bh=w7kB5wib5tndfp7xuvkvAYZPeetX211sxv2O+JjC7+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BQfK/UbzmrDz0HatLn8pFosGBLg09LPhVxbcYekZtfWVk41lVgL1S7nT1Efb69rZj
	 VoL8cfmzR8DLLhmXLdlXNVMvvyFyMOU7a1mVOZVqa61BZJcbr5iTFotyADxpLw0Yqg
	 PWTHq5c6p2gDBZrmFIUu/xhZOOPDKrQ9QdbgAMQX+kbor+K1Zs5hO8ZsoxiGYOygnT
	 HziOJ4IlzwGh/ftzK4KCDRVNw0cZb0XNq4UGe6ny39AJ0mN12yWAepn5NR5CfNEkQG
	 4LLemNfoj1giHcOZVRTHI2WrRePersd9nmG7L63xPrNNI2Munpb3agdznueF2NU3cK
	 XtBj2vU4NffQQ==
From: chrisl@kernel.org
Date: Fri, 18 Oct 2024 10:27:04 -0700
Subject: [PATCH 6.11.y v2 1/3] mm/hugetlb_vmemmap: don't synchronize_rcu()
 without HVO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-stable-yuzhao-v2-1-1fd556716eda@kernel.org>
References: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
In-Reply-To: <20241018-stable-yuzhao-v2-0-1fd556716eda@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
 Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Marc Hartmayer <mhartmay@linux.ibm.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit c2a967f6ab0ec896648c0497d3dc15d8f136b148 ]

hugetlb_vmemmap_optimize_folio() and hugetlb_vmemmap_restore_folio() are
wrappers meant to be called regardless of whether HVO is enabled.
Therefore, they should not call synchronize_rcu().  Otherwise, it
regresses use cases not enabling HVO.

So move synchronize_rcu() to __hugetlb_vmemmap_optimize_folio() and
__hugetlb_vmemmap_restore_folio(), and call it once for each batch of
folios when HVO is enabled.

Link: https://lkml.kernel.org/r/20240719042503.2752316-1-yuzhao@google.com
Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407091001.1250ad4a-oliver.sang@intel.com
Reported-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 mm/hugetlb_vmemmap.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0c3f56b3578eb..57b7f591eee82 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -43,6 +43,8 @@ struct vmemmap_remap_walk {
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
 /* Skip the TLB flush when we remap the PTE */
 #define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
+/* synchronize_rcu() to avoid writes from page_ref_add_unless() */
+#define VMEMMAP_SYNCHRONIZE_RCU		BIT(2)
 	unsigned long		flags;
 };
 
@@ -457,6 +459,9 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 	if (!folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
+	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
+		synchronize_rcu();
+
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
 	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
@@ -489,10 +494,7 @@ static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
  */
 int hugetlb_vmemmap_restore_folio(const struct hstate *h, struct folio *folio)
 {
-	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
-	synchronize_rcu();
-
-	return __hugetlb_vmemmap_restore_folio(h, folio, 0);
+	return __hugetlb_vmemmap_restore_folio(h, folio, VMEMMAP_SYNCHRONIZE_RCU);
 }
 
 /**
@@ -515,14 +517,14 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	struct folio *folio, *t_folio;
 	long restored = 0;
 	long ret = 0;
-
-	/* avoid writes from page_ref_add_unless() while unfolding vmemmap */
-	synchronize_rcu();
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = __hugetlb_vmemmap_restore_folio(h, folio,
-							      VMEMMAP_REMAP_NO_TLB_FLUSH);
+			ret = __hugetlb_vmemmap_restore_folio(h, folio, flags);
+			/* only need to synchronize_rcu() once for each batch */
+			flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
+
 			if (ret)
 				break;
 			restored++;
@@ -570,6 +572,9 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
+	if (flags & VMEMMAP_SYNCHRONIZE_RCU)
+		synchronize_rcu();
 	/*
 	 * Very Subtle
 	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
@@ -617,10 +622,7 @@ void hugetlb_vmemmap_optimize_folio(const struct hstate *h, struct folio *folio)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	/* avoid writes from page_ref_add_unless() while folding vmemmap */
-	synchronize_rcu();
-
-	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, 0);
+	__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, VMEMMAP_SYNCHRONIZE_RCU);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -647,6 +649,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
+	unsigned long flags = VMEMMAP_REMAP_NO_TLB_FLUSH | VMEMMAP_SYNCHRONIZE_RCU;
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = hugetlb_vmemmap_split_folio(h, folio);
@@ -663,14 +666,12 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	flush_tlb_all();
 
-	/* avoid writes from page_ref_add_unless() while folding vmemmap */
-	synchronize_rcu();
-
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
 
-		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
-						       VMEMMAP_REMAP_NO_TLB_FLUSH);
+		ret = __hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
+		/* only need to synchronize_rcu() once for each batch */
+		flags &= ~VMEMMAP_SYNCHRONIZE_RCU;
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
@@ -684,8 +685,7 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages,
-							 VMEMMAP_REMAP_NO_TLB_FLUSH);
+			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
 		}
 	}
 

-- 
2.47.0.rc1.288.g06298d1525-goog


