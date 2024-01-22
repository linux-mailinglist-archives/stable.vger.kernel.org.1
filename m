Return-Path: <stable+bounces-12767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAB8372C4
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A9AB23742
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DF3EA8B;
	Mon, 22 Jan 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNe8V/ZW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82E3E49E
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951905; cv=none; b=P6jdHZHXDzq+0FXMLRAyH2eTpJzlXyyHC+bs88JmQOSfrLkwg4JQhtDl1fsz/aKBqQBkMPXWwskZuwleVrxTtRkaydV8V+qFByHzRkK/Nt7JeFKiELqURIJxHtm1exyClMuh9cTOiDXzGqHLbDSdKf7QkuWiavw5PywXQFlC9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951905; c=relaxed/simple;
	bh=Jb3S7WwQ+TCPWBLxQOYBbt2CuhKSPAnyNuTUxORQx6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UYdSwPOLo6BjMPFdEKuAxwI7ftjIkp77fwowqOhVXirC7Bz05U7n01gWvKwXpVuskPBnjdEwxbwigcUq7EfQKaw+hsnRsWBtPI0smPJorjc/bX33/jtBbK77S/HqaiZyqjDkpsGv968WcmY1v2kxqZsuHt656ebiZKgRjErfo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CNe8V/ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C34C433C7;
	Mon, 22 Jan 2024 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705951905;
	bh=Jb3S7WwQ+TCPWBLxQOYBbt2CuhKSPAnyNuTUxORQx6k=;
	h=Subject:To:Cc:From:Date:From;
	b=CNe8V/ZWBFGNLwWM7/b2Hyqf7uNFLbyUtJc3Zt+CmFewJ+ekK9CRl6L7rLo/N1+gf
	 rQAfEr4SOY+V0EMYmKrNpZ6R9fROAWyPkjJ3nSTW+04uZYBmBCsw5D9wRQeuZs4rjc
	 neCtvZRr6g2YQ2jkCrub6WkLJQ0rixAzCNNc1TAs=
Subject: FAILED: patch "[PATCH] block: Remove special-casing of compound pages" failed to apply to 4.19-stable tree
To: willy@infradead.org,akpm@osdl.org,axboe@kernel.dk,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:31:29 -0800
Message-ID: <2024012229-dealer-luster-6ff4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012229-dealer-luster-6ff4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1b151e2435fc ("block: Remove special-casing of compound pages")
fd363244e883 ("block: Add BIO_PAGE_PINNED and associated infrastructure")
e51bab4e2058 ("block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic")
a450f49708ea ("iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing")
7ee4ccf57484 ("block: set FOLL_PCI_P2PDMA in bio_map_user_iov()")
80bd4a7aab4c ("blk-mq: move the srcu_struct used for quiescing to the tagset")
e88811bc43b9 ("block: use on-stack page vec for <= UIO_FASTIOV")
480cb846c27b ("block: convert to advancing variants of iov_iter_get_pages{,_alloc}()")
e97424fd4472 ("block: fix leaking page ref on truncated direct io")
34cdb8c825f2 ("block: ensure bio_iov_add_page can't fail")
325347d965e7 ("block: ensure iov_iter advances for added pages")
46754bd05605 ("block: move ->bio_split to the gendisk")
5a97806f7dc0 ("block: change the blk_queue_split calling convention")
8374cfe647a1 ("Merge tag 'for-6.0/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 14 Aug 2023 15:41:00 +0100
Subject: [PATCH] block: Remove special-casing of compound pages

The special casing was originally added in pre-git history; reproducing
the commit log here:

> commit a318a92567d77
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Sun Sep 21 01:42:22 2003 -0700
>
>     [PATCH] Speed up direct-io hugetlbpage handling
>
>     This patch short-circuits all the direct-io page dirtying logic for
>     higher-order pages.  Without this, we pointlessly bounce BIOs up to
>     keventd all the time.

In the last twenty years, compound pages have become used for more than
just hugetlb.  Rewrite these functions to operate on folios instead
of pages and remove the special case for hugetlbfs; I don't think
it's needed any more (and if it is, we can put it back in as a call
to folio_test_hugetlb()).

This was found by inspection; as far as I can tell, this bug can lead
to pages used as the destination of a direct I/O read not being marked
as dirty.  If those pages are then reclaimed by the MM without being
dirtied for some other reason, they won't be written out.  Then when
they're faulted back in, they will not contain the data they should.
It'll take a pretty unusual setup to produce this problem with several
races all going the wrong way.

This problem predates the folio work; it could for example have been
triggered by mmaping a THP in tmpfs and using that as the target of an
O_DIRECT read.

Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..5eba53ca953b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1145,13 +1145,22 @@ EXPORT_SYMBOL(bio_add_folio);
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio) {
+		struct page *page;
+		size_t done = 0;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		bio_release_page(bio, bvec->bv_page);
+		if (mark_dirty) {
+			folio_lock(fi.folio);
+			folio_mark_dirty(fi.folio);
+			folio_unlock(fi.folio);
+		}
+		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		do {
+			bio_release_page(bio, page++);
+			done += PAGE_SIZE;
+		} while (done < fi.length);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1439,18 +1448,12 @@ EXPORT_SYMBOL(bio_free_pages);
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
  * for performing direct-IO in BIOs.
  *
- * The problem is that we cannot run set_page_dirty() from interrupt context
+ * The problem is that we cannot run folio_mark_dirty() from interrupt context
  * because the required locks are not interrupt-safe.  So what we can do is to
  * mark the pages dirty _before_ performing IO.  And in interrupt context,
  * check that the pages are still dirty.   If so, fine.  If not, redirty them
  * in process context.
  *
- * We special-case compound pages here: normally this means reads into hugetlb
- * pages.  The logic in here doesn't really work right for compound pages
- * because the VM does not uniformly chase down the head page in all cases.
- * But dirtiness of compound pages is pretty meaningless anyway: the VM doesn't
- * handle them at all.  So we skip compound pages here at an early stage.
- *
  * Note that this code is very hard to test under normal circumstances because
  * direct-io pins the pages with get_user_pages().  This makes
  * is_page_cache_freeable return false, and the VM will not clean the pages.
@@ -1466,12 +1469,12 @@ EXPORT_SYMBOL(bio_free_pages);
  */
 void bio_set_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+	bio_for_each_folio_all(fi, bio) {
+		folio_lock(fi.folio);
+		folio_mark_dirty(fi.folio);
+		folio_unlock(fi.folio);
 	}
 }
 EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
@@ -1515,12 +1518,11 @@ static void bio_dirty_fn(struct work_struct *work)
 
 void bio_check_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 	unsigned long flags;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+	bio_for_each_folio_all(fi, bio) {
+		if (!folio_test_dirty(fi.folio))
 			goto defer;
 	}
 


