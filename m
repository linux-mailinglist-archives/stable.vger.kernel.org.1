Return-Path: <stable+bounces-204176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B78CE8980
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CABF3012DDF
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261AC2DF3FD;
	Tue, 30 Dec 2025 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnhY97VY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EA1494DB
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767062915; cv=none; b=J4NBr95yaZfd/xm4i6uIi1Xvv7wZ/8tUkypk1SUGp1QHl80i8GX+tylsL/09yXSCA4MX2EgPdoDm4pIuuprrcQ1s8oAiDL6XqreSH8uwZNbA/En3JAs4eKsrB9nkTKMq+rHH2km2jMQ3mKUOP6Z941EVUlw4psCL6WGcprMZm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767062915; c=relaxed/simple;
	bh=IP9IDv9N+bsPcVnvcAY+xC6eOKtwmUH+ae4059nTdoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4TzGdrFvYpcGK8HCFL+xdLhlHBvQWXyX7P3+6Kl39aj2j594wCDiMKw2P32NbInPjJajjbqyTWZjoiHajEmvHvSAXSYllzozInigGbJpuru+YORuVJXdiQu1ZrG0dQp3sjPRAebeL/qqH4PB0Sz9aTFXMmxzyU437+mpQKxcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnhY97VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F8CC4CEF7;
	Tue, 30 Dec 2025 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767062915;
	bh=IP9IDv9N+bsPcVnvcAY+xC6eOKtwmUH+ae4059nTdoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnhY97VYhdqwYa+pQxjg2H381KxzEJtDKjSqErM9aESMhswi0r1QNNmGinh+3MW72
	 jfSBI/b04U4P88w1EAAZlBL9C0Wtu176MuwGNktdZQhmCDvo2eLmy05h2zlGtNgB+7
	 KQXxBzhOe9n9jsdcDQaEGw6mBwCSi9FByZEAev9J5qZylzsH36Rg6V/5Akx/Xw5ziR
	 hfLt9/LDbeJd3hzi14zNXngeewi9j1WbihCKuMgkCPed2fH6m7c6/9sn7BzmMa1JDv
	 TpQPVyHRj/n0IW/gDhujZ3/WBmSN0i7O6YWh4qxNghxyPS/oFkRteGFgkZtrH0cP4T
	 4ZLcSUCRVCBKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/huge_memory: merge uniform_split_supported() and non_uniform_split_supported()
Date: Mon, 29 Dec 2025 21:48:31 -0500
Message-ID: <20251230024831.1972219-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122925-victory-numeral-2346@gregkh>
References: <2025122925-victory-numeral-2346@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 8a0e4bdddd1c998b894d879a1d22f1e745606215 ]

uniform_split_supported() and non_uniform_split_supported() share
significantly similar logic.

The only functional difference is that uniform_split_supported() includes
an additional check on the requested @new_order.

The reason for this check comes from the following two aspects:

  * some file system or swap cache just supports order-0 folio
  * the behavioral difference between uniform/non-uniform split

The behavioral difference between uniform split and non-uniform:

  * uniform split splits folio directly to @new_order
  * non-uniform split creates after-split folios with orders from
    folio_order(folio) - 1 to new_order.

This means for non-uniform split or !new_order split we should check the
file system and swap cache respectively.

This commit unifies the logic and merge the two functions into a single
combined helper, removing redundant code and simplifying the split
support checking mechanism.

Link: https://lkml.kernel.org/r/20251106034155.21398-3-richard.weiyang@gmail.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ split_type => uniform_split and replaced SPLIT_TYPE_NON_UNIFORM checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/huge_mm.h |  8 ++---
 mm/huge_memory.c        | 71 +++++++++++++++++------------------------
 2 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71ac78b9f834..240cbc676480 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -369,10 +369,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
-bool uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns);
-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns);
+bool folio_split_supported(struct folio *folio, unsigned int new_order,
+		bool uniform_split, bool warns);
 int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 		struct list_head *list);
 /*
@@ -392,7 +390,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
 {
-	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+	if (!folio_split_supported(folio, new_order, false, /* warns= */ false))
 		return split_huge_page_to_list_to_order(&folio->page, NULL,
 				new_order);
 	return folio_split(folio, new_order, page, NULL);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6cba1cb14b23..7a74198f05c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3515,8 +3515,8 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns)
+bool folio_split_supported(struct folio *folio, unsigned int new_order,
+		bool uniform_split, bool warns)
 {
 	if (folio_test_anon(folio)) {
 		/* order-1 is not supported for anonymous THP. */
@@ -3524,48 +3524,41 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 				"Cannot split to order-1 folio");
 		if (new_order == 1)
 			return false;
-	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-	    !mapping_large_folio_support(folio->mapping)) {
-		/*
-		 * No split if the file system does not support large folio.
-		 * Note that we might still have THPs in such mappings due to
-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-		 * does not actually support large folios properly.
-		 */
-		VM_WARN_ONCE(warns,
-			"Cannot split file folio to non-0 order");
-		return false;
-	}
-
-	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio)) {
-		VM_WARN_ONCE(warns,
-			"Cannot split swapcache folio to non-0 order");
-		return false;
-	}
-
-	return true;
-}
-
-/* See comments in non_uniform_split_supported() */
-bool uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns)
-{
-	if (folio_test_anon(folio)) {
-		VM_WARN_ONCE(warns && new_order == 1,
-				"Cannot split to order-1 folio");
-		if (new_order == 1)
-			return false;
-	} else  if (new_order) {
+	} else if (!uniform_split || new_order) {
 		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 		    !mapping_large_folio_support(folio->mapping)) {
+			/*
+			 * We can always split a folio down to a single page
+			 * (new_order == 0) uniformly.
+			 *
+			 * For any other scenario
+			 *   a) uniform split targeting a large folio
+			 *      (new_order > 0)
+			 *   b) any non-uniform split
+			 * we must confirm that the file system supports large
+			 * folios.
+			 *
+			 * Note that we might still have THPs in such
+			 * mappings, which is created from khugepaged when
+			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
+			 * case, the mapping does not actually support large
+			 * folios properly.
+			 */
 			VM_WARN_ONCE(warns,
 				"Cannot split file folio to non-0 order");
 			return false;
 		}
 	}
 
-	if (new_order && folio_test_swapcache(folio)) {
+	/*
+	 * swapcache folio could only be split to order 0
+	 *
+	 * non-uniform split creates after-split folios with orders from
+	 * folio_order(folio) - 1 to new_order, making it not suitable for any
+	 * swapcache folio split. Only uniform split to order-0 can be used
+	 * here.
+	 */
+	if ((!uniform_split || new_order) && folio_test_swapcache(folio)) {
 		VM_WARN_ONCE(warns,
 			"Cannot split swapcache folio to non-0 order");
 		return false;
@@ -3632,11 +3625,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (uniform_split && !uniform_split_supported(folio, new_order, true))
-		return -EINVAL;
-
-	if (!uniform_split &&
-	    !non_uniform_split_supported(folio, new_order, true))
+	if (!folio_split_supported(folio, new_order, uniform_split, /* warn = */ true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
-- 
2.51.0


