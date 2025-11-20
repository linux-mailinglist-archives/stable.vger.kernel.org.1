Return-Path: <stable+bounces-195307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81635C753A2
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4B4EAA6D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FD348889;
	Thu, 20 Nov 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Va8XtoWN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F36345CDF
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654185; cv=none; b=GcWvauyyuNiGqLLFhl1aa8QwzqA7+4sEespc7Vpz3AW/SWmPs4KO5K/1GKsOCcUn3aijTsIIzdjet1HVEKjDRr9Jm0z8xtnY3rYoS55yfAAt4q52rBiydMak3v1Ke0OqA3Bph+iaA+lO1Lrwf2HUCMp0POwX23FsbLPLCNkiyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654185; c=relaxed/simple;
	bh=tSCRcVLeoiw23j2vsgFQRHre+/mUTfpROakEAeK4BXo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tYB3try/EBhMUvdCnkLAxVd41dGImlbisKjcImFlyibY8NF3tJ7YQR2Qe9CYpSEry2AzGisftGk8oaQAPk4Q8TniCr6scldLq/004J8Lc6a9IheBmaBJd36p7NR8saLmCLId5k3aYWCnrEx61m6WK4rKvatOEAUkbRdSsCGACmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Va8XtoWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97215C116C6;
	Thu, 20 Nov 2025 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763654185;
	bh=tSCRcVLeoiw23j2vsgFQRHre+/mUTfpROakEAeK4BXo=;
	h=Subject:To:Cc:From:Date:From;
	b=Va8XtoWNE+StPLo0Gm7CXhW2AJu6iZCOC3nVQ6tpesD5XvF6lOg/CZsahUpxSTFi6
	 5bnA3DwbzsD4Q7pamHhC5vCFGbXjDLqkHBzth3bmQryohCx8fOTS/3/KUYPdbarEMx
	 orM2bN8yz2N5y1j+6WN18SUX5mX5EwW6W4vLlR/Y=
Subject: FAILED: patch "[PATCH] mm/huge_memory: do not change split_huge_page*() target order" failed to apply to 6.12-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,david@redhat.com,dev.jain@arm.com,jane.chu@oracle.com,lance.yang@linux.dev,liam.howlett@oracle.com,linmiaohe@huawei.com,lorenzo.stoakes@oracle.com,mcgrof@kernel.org,nao.horiguchi@gmail.com,npache@redhat.com,p.raghav@samsung.com,richard.weiyang@gmail.com,ryan.roberts@arm.com,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:56:15 +0100
Message-ID: <2025112015-revolving-professed-8d2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 77008e1b2ef73249bceb078a321a3ff6bc087afb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112015-revolving-professed-8d2d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77008e1b2ef73249bceb078a321a3ff6bc087afb Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 16 Oct 2025 21:36:30 -0400
Subject: [PATCH] mm/huge_memory: do not change split_huge_page*() target order
 silently

Page cache folios from a file system that support large block size (LBS)
can have minimal folio order greater than 0, thus a high order folio might
not be able to be split down to order-0.  Commit e220917fa507 ("mm: split
a folio in minimum folio order chunks") bumps the target order of
split_huge_page*() to the minimum allowed order when splitting a LBS
folio.  This causes confusion for some split_huge_page*() callers like
memory failure handling code, since they expect after-split folios all
have order-0 when split succeeds but in reality get min_order_for_split()
order folios and give warnings.

Fix it by failing a split if the folio cannot be split to the target
order.  Rename try_folio_split() to try_folio_split_to_order() to reflect
the added new_order parameter.  Remove its unused list parameter.

[The test poisons LBS folios, which cannot be split to order-0 folios, and
also tries to poison all memory.  The non split LBS folios take more
memory than the test anticipated, leading to OOM.  The patch fixed the
kernel warning and the test needs some change to avoid OOM.]

Link: https://lkml.kernel.org/r/20251017013630.139907-1-ziy@nvidia.com
Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f327d62fc985..71ac78b9f834 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -376,45 +376,30 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 		struct list_head *list);
 /*
- * try_folio_split - try to split a @folio at @page using non uniform split.
+ * try_folio_split_to_order - try to split a @folio at @page to @new_order using
+ * non uniform split.
  * @folio: folio to be split
- * @page: split to order-0 at the given page
- * @list: store the after-split folios
+ * @page: split to @new_order at the given page
+ * @new_order: the target split order
  *
- * Try to split a @folio at @page using non uniform split to order-0, if
- * non uniform split is not supported, fall back to uniform split.
+ * Try to split a @folio at @page using non uniform split to @new_order, if
+ * non uniform split is not supported, fall back to uniform split. After-split
+ * folios are put back to LRU list. Use min_order_for_split() to get the lower
+ * bound of @new_order.
  *
  * Return: 0: split is successful, otherwise split failed.
  */
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	if (!non_uniform_split_supported(folio, 0, false))
-		return split_huge_page_to_list_to_order(&folio->page, list,
-				ret);
-	return folio_split(folio, ret, page, list);
+	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+		return split_huge_page_to_list_to_order(&folio->page, NULL,
+				new_order);
+	return folio_split(folio, new_order, page, NULL);
 }
 static inline int split_huge_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * split_huge_page() locks the page before splitting and
-	 * expects the same page that has been split to be locked when
-	 * returned. split_folio(page_folio(page)) cannot be used here
-	 * because it converts the page to folio and passes the head
-	 * page to be split.
-	 */
-	return split_huge_page_to_list_to_order(page, NULL, ret);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
@@ -597,14 +582,20 @@ static inline int split_huge_page(struct page *page)
 	return -EINVAL;
 }
 
+static inline int min_order_for_split(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
 }
 
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
 	VM_WARN_ON_ONCE_FOLIO(1, folio);
 	return -EINVAL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d1b74950332..feac4aef7dfb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3653,8 +3653,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3986,12 +3984,7 @@ int min_order_for_split(struct folio *folio)
 
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	return split_huge_page_to_list_to_order(&folio->page, list, ret);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
 
 /*
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..9210cf808f5c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
+	unsigned int min_order;
 
 	if (pos < start)
 		offset = start - pos;
@@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!folio_test_large(folio))
 		return true;
 
+	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_to_order(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_to_order(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:


