Return-Path: <stable+bounces-203540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87DCE6B26
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262A230084C3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF922F25F1;
	Mon, 29 Dec 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vljd+R2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30326D4CD
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011608; cv=none; b=PU3eqeYSTx5Y6kTcuHoUzt2vBwU1mA37nTPBcSRFLwMNsFV2UJa2EKVs9KvoY9wM4NgwUcp96ek/HBWkIsUKBu+T+LWaLsvOZH5qyJbDMO2HT1j8zk9SsJfsRGugOmMh/mbffcSk+ZU3UhF0yLTV+m51kUkLaLxRSAhwYgBTm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011608; c=relaxed/simple;
	bh=+AfT6j2fV1FAL/gzF90O4nopIQckNjJirXVgZQOyPto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kqCoD/zQ5f3KS6DWNMdY9t2tEG6P6d6MkJl/mffmB13/eLIu+lIuorbr8xGc4hnbDarfa4f6TJFvkhnYcSz7lj1jcJ+BgBL7hNIvQ5ba1EgA8ZRhtYyUKBHcVfbAo6Ze+MGLreWoNRWw3yq1dIbgCkck8hILqZQqef6BYgNW30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vljd+R2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629B4C4CEF7;
	Mon, 29 Dec 2025 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767011607;
	bh=+AfT6j2fV1FAL/gzF90O4nopIQckNjJirXVgZQOyPto=;
	h=Subject:To:Cc:From:Date:From;
	b=vljd+R2W3KBzu0jvnQqo/Cet+kMaT9SKXsMXug0ueJQU1bB7YjXrs175XXj0D/G2h
	 Kvod/Qszp9Ftrg8RkVh6KhgQG9FU8Pk8HIUriEJLHchreJ6oiKbFsvVeyIeP/utFkt
	 RXgpNdHqBCg8IGy0SykegVVQKJSEjGg4wWvLPfbc=
Subject: FAILED: patch "[PATCH] mm/huge_memory: merge uniform_split_supported() and" failed to apply to 6.18-stable tree
To: richard.weiyang@gmail.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 13:33:25 +0100
Message-ID: <2025122925-victory-numeral-2346@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8a0e4bdddd1c998b894d879a1d22f1e745606215
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122925-victory-numeral-2346@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a0e4bdddd1c998b894d879a1d22f1e745606215 Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Thu, 6 Nov 2025 03:41:55 +0000
Subject: [PATCH] mm/huge_memory: merge uniform_split_supported() and
 non_uniform_split_supported()

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

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b74708dc5b5f..19d4a5f52ca2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -374,10 +374,8 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
 		unsigned int new_order, bool unmapped);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
-bool uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns);
-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns);
+bool folio_split_supported(struct folio *folio, unsigned int new_order,
+		enum split_type split_type, bool warns);
 int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 		struct list_head *list);
 
@@ -408,7 +406,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
 {
-	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+	if (!folio_split_supported(folio, new_order, SPLIT_TYPE_NON_UNIFORM, /* warns= */ false))
 		return split_huge_page_to_order(&folio->page, new_order);
 	return folio_split(folio, new_order, page, NULL);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4118f330c55e..d79a4bb363de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3593,8 +3593,8 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return 0;
 }
 
-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
-		bool warns)
+bool folio_split_supported(struct folio *folio, unsigned int new_order,
+		enum split_type split_type, bool warns)
 {
 	if (folio_test_anon(folio)) {
 		/* order-1 is not supported for anonymous THP. */
@@ -3602,48 +3602,41 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
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
+	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
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
+	if ((split_type == SPLIT_TYPE_NON_UNIFORM || new_order) && folio_test_swapcache(folio)) {
 		VM_WARN_ONCE(warns,
 			"Cannot split swapcache folio to non-0 order");
 		return false;
@@ -3711,11 +3704,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (new_order >= old_order)
 		return -EINVAL;
 
-	if (split_type == SPLIT_TYPE_UNIFORM && !uniform_split_supported(folio, new_order, true))
-		return -EINVAL;
-
-	if (split_type == SPLIT_TYPE_NON_UNIFORM &&
-	    !non_uniform_split_supported(folio, new_order, true))
+	if (!folio_split_supported(folio, new_order, split_type, /* warn = */ true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);


